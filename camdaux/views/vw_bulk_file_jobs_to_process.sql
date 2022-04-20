-- View: camdaux.vw_bulk_file_jobs_to_process

-- DROP VIEW camdaux.vw_bulk_file_jobs_to_process;

CREATE OR REPLACE VIEW camdaux.vw_bulk_file_jobs_to_process
 AS
 SELECT bfl.job_id,
    bfl.parent_job_id,
    jl.job_system,
    jl.job_class,
    jl.job_name,
    bfl.data_type,
    bfl.data_subtype,
    bfl.year,
    bfl.quarter,
    bfl.state_cd,
    bfl.prg_cd,
    rp.begin_date AS qtr_begin_date,
    rp.end_date AS qtr_end_date,
    jl.add_date,
    jl.start_date,
    jl.end_date,
    jl.status_cd,
    jl.additional_details
   FROM camdaux.job_log jl
     JOIN camdaux.bulk_file_log bfl USING (job_id)
     LEFT JOIN camdecmpsmd.reporting_period rp ON bfl.year = rp.calendar_year AND bfl.quarter = rp.quarter
  WHERE jl.status_cd::text = 'ERROR'::text OR (jl.status_cd::text = 'QUEUED'::text OR jl.status_cd::text = 'WIP'::text) AND timezone('est'::text, CURRENT_TIMESTAMP) >= (jl.add_date + '24:00:00'::interval)
  ORDER BY bfl.year, bfl.quarter, bfl.state_cd;
