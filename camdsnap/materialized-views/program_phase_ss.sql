create materialized view camdsnap.PROGRAM_PHASE_SS
as 
select  prp.program_phase_id,
        prp.prg_id,
        prp.phase,
        prp.prog_phase_begin_date,
        prp.prog_phase_end_date,
        prp.phase_monitor_cert_deadline,
        prp.add_date,
        prp.update_date,
        prp.userid,
        now() as refresh_time
  from  camd.PROGRAM_PHASE prp;


comment on materialized view camdsnap.PROGRAM_PHASE_SS is 'snapshot table for snapshot CAMDSNAP.PROGRAM_PHASE_SS';
