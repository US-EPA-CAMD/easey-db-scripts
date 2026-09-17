create materialized view camdsnap.FACILITY_PEOPLE_SS 
as 
select  fcp.fac_ppl_id,
        fcp.fac_id,
        fcp.ppl_id,
        fcp.responsibility_id,
        prg.prg_id,
        fcp.begin_date,
        fcp.end_date,
        fcp.userid,
        fcp.update_date,
        fcp.add_date,
        now() as refresh_time
  from  camd.PLANT_PERSON fcp,
        camd.PROGRAM prg,
        camd.PLANT fac
 where  fcp.prg_cd = prg.prg_cd
   and  fac.state = prg.state_cd
   and  fac.fac_id = fcp.fac_id
union
select  fcp.fac_ppl_id,
        fcp.fac_id,
        fcp.ppl_id,
        fcp.responsibility_id,
        prg.prg_id,
        fcp.begin_date,
        fcp.end_date,
        fcp.userid,
        fcp.update_date,
        fcp.add_date,
        now() as refresh_time
  from  camd.PLANT_PERSON fcp,
        camd.PROGRAM prg
 where  fcp.prg_cd = prg.prg_cd
   and  prg.fed_ind = 1
union
select  fcp.fac_ppl_id,
        fcp.fac_id,
        fcp.ppl_id,
        fcp.responsibility_id,
        null as prg_id,
        fcp.begin_date,
        fcp.end_date,
        fcp.userid,
        fcp.update_date,
        fcp.add_date,
        now() as refresh_time
  from  camd.PLANT_PERSON fcp
 where  fcp.prg_cd is null;


comment on materialized view camdsnap.FACILITY_PEOPLE_SS is 'snapshot table for snapshot CAMDSNAP.FACILITY_PEOPLE_SS';
