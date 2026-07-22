create materialized view camdsnap.UNIT_PEOPLE_SS 
as 
select  fcp.fac_ppl_id as unt_ppl_id,
        fcp.fac_ppl_id,
        fcp.fac_id,
        unt.unit_id,
        fcp.ppl_id,
        fcp.responsibility_id,
        prg.prg_id,
        fcp.begin_date,
        fcp.end_date,
        fcp.userid,
        fcp.update_date,
        fcp.add_date          
  from  camd.PLANT_PERSON fcp
        join camd.PLANT fac
          on fac.fac_id = fcp.fac_id
        join camd.UNIT unt
          on unt.fac_id = fac.fac_id
        left join camd.PROGRAM prg
          on prg.state_cd || prg.prg_cd =  decode (fcp.prg_cd, 'ARP', null, fac.state ) || fcp.prg_cd
 where  not exists
        (
            select  unh.unit_id
              from  camdsnap.UNIT_HISTORY_SS unh
             where  unh.unit_history_type_cd in ( 'LOGICAL', 'PHYSCAL' )
               and  unt.unit_id = unh.unit_id
        )
union all
/* 
    PLANT_PERSON DATA FOR UNITS THAT HAVE MOVED FOR THE OLD LOCATION
    INCLUDES ALL RECORDS THAT BEGAN AND ENDED PRIOR TO THE MOVE,
    AS WELL AS ALL RECORDS THAT WERE ACTIVE WHEN THE MOVE OCCURRED
*/
select  fcp.fac_ppl_id as unt_ppl_id,
        fcp.fac_ppl_id,
        fcp.fac_id,
        unh.unit_id,
        fcp.ppl_id,
        fcp.responsibility_id,
        prg.prg_id,
        fcp.begin_date,
        case
            when unh.effective_date > nvl( fcp.end_date, sysdate )
            then fcp.end_date
            else unh.effective_date - 1
        end as end_date,
        fcp.userid,
        fcp.update_date,
        fcp.add_date          
  from  camd.PLANT_PERSON fcp
        join camd.PLANT fac
          on fac.fac_id = fcp.fac_id
        join camdsnap.UNIT_HISTORY_SS unh
          on unh.old_fac_id = fac.fac_id
         and unh.unit_history_type_cd in ( 'LOGICAL', 'PHYSCAL' )
        left join camd.PROGRAM prg
          on prg.state_cd || prg.prg_cd = decode( fcp.prg_cd, 'ARP', null, fac.state ) || fcp.prg_cd
 where  (
            unh.effective_date > nvl( fcp.end_date, sysdate )
            or
            unh.effective_date - 1 between fcp.begin_date and nvl( fcp.end_date, sysdate )
        )
union all
/*
    PLANT_PERSON DATA FOR UNITS THAT HAVE MOVED FOR THE NEW LOCATION
    INCLUDES ALL RECORDS THAT BEGAN ON OR AFTER THE MOVE,
    AS WELL AS ALL RECORDS THAT WERE ACTIVE WHEN THE MOVE OCCURRED
*/
select  fcp.fac_ppl_id as unt_ppl_id,
        fcp.fac_ppl_id,
        fcp.fac_id,
        unh.unit_id,
        fcp.ppl_id,
        fcp.responsibility_id,
        prg.prg_id,
        case
            when unh.effective_date <= fcp.begin_date
            then
                fcp.begin_date
            else
                unh.effective_date
        end as begin_date,
        fcp.end_date,
        fcp.userid,
        fcp.update_date,
        fcp.add_date          
  from  camd.PLANT_PERSON fcp
        join camd.PLANT fac
          on fac.fac_id = fcp.fac_id
        join camdsnap.UNIT_HISTORY_SS unh
          on unh.new_fac_id = fac.fac_id
         and unh.unit_history_type_cd IN ( 'LOGICAL', 'PHYSCAL' )
        left join camd.PROGRAM prg
          on prg.state_cd || prg.prg_cd = decode ( fcp.prg_cd, 'ARP', null, fac.state ) || fcp.prg_cd
 where  (
            unh.effective_date <= fcp.begin_date
            or
            unh.effective_date between fcp.begin_date and nvl( fcp.end_date, sysdate )
        );


comment on materialized view camdsnap.UNIT_PEOPLE_SS is 'snapshot table for snapshot CAMDSNAP.UNIT_PEOPLE_SS';
