-- View: camdaux.vw_bulk_file_jobs_to_delete

-- DROP VIEW camdaux.vw_bulk_file_jobs_to_delete;

CREATE OR REPLACE VIEW camdaux.vw_bulk_file_jobs_to_delete
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
    jl.add_date,
    jl.start_date,
    jl.end_date,
    jl.status_cd,
    jl.additional_details
   FROM camdaux.job_log jl
     JOIN camdaux.bulk_file_log bfl USING (job_id)
     JOIN ( SELECT bulk_file_log.data_type,
            bulk_file_log.data_subtype,
            bulk_file_log.year,
            bulk_file_log.quarter,
            bulk_file_log.state_cd,
            bulk_file_log.prg_cd
           FROM camdaux.bulk_file_log
          GROUP BY bulk_file_log.data_type, bulk_file_log.data_subtype, bulk_file_log.year, bulk_file_log.quarter, bulk_file_log.state_cd, bulk_file_log.prg_cd
         HAVING count(*) > 1) d ON bfl.data_type::text = d.data_type::text AND COALESCE(bfl.data_subtype, 'NULL'::character varying)::text = COALESCE(d.data_subtype, 'NULL'::character varying)::text AND COALESCE(bfl.year, 0::numeric) = COALESCE(d.year, 0::numeric) AND COALESCE(bfl.quarter, 0::numeric) = COALESCE(d.quarter, 0::numeric) AND COALESCE(bfl.state_cd, 'NULL'::character varying)::text = COALESCE(d.state_cd, 'NULL'::character varying)::text AND COALESCE(bfl.prg_cd, 'NULL'::character varying)::text = COALESCE(d.prg_cd, 'NULL'::character varying)::text
  WHERE jl.status_cd::text = 'ERROR'::text OR (jl.status_cd::text = 'QUEUED'::text OR jl.status_cd::text = 'WIP'::text) AND timezone('est'::text, CURRENT_TIMESTAMP) >= (jl.add_date + '24:00:00'::interval)
  ORDER BY bfl.year, bfl.quarter, bfl.state_cd;
