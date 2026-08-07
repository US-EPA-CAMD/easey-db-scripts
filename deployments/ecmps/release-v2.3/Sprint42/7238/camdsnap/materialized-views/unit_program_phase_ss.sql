create materialized view camdsnap.UNIT_PROGRAM_PHASE_SS
as 
select  upp.up_id,
        upp.phase,
        upp.begin_year,
        upp.end_year,
        now() as refresh_time
  from  camd.UNIT_PROGRAM_PHASE upp;


comment on materialized view camdsnap.UNIT_PROGRAM_PHASE_SS is 'snapshot table for snapshot CAMDSNAP.UNIT_PROGRAM_PHASE_SS';
