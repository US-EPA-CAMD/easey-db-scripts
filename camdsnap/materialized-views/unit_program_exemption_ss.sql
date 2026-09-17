create materialized view camdsnap.UNIT_PROGRAM_EXEMPTION_SS 
as 
select  unp.up_id,
        unx.exemption_type_cd as exempt_type,
        unx.ex_rec_date,
        unx.begin_date,
        unx.end_date,
        unx.add_date,
        unx.update_date,
        unx.userid,
        now() as refresh_time
  from  camd.UNIT_PROGRAM unp,
        camd.UNIT_EXEMPTION unx,
        camdmd.PROGRAM_EXEMPTION prx
 where  unp.unit_id = unx.unit_id
   and  unp.prg_cd = prx.prg_cd
   and  unx.exemption_type_cd = prx.exemption_type_cd;


comment on materialized view camdsnap.UNIT_PROGRAM_EXEMPTION_SS is 'snapshot table for snapshot CAMDSNAP.UNIT_PROGRAM_EXEMPTION_SS';
