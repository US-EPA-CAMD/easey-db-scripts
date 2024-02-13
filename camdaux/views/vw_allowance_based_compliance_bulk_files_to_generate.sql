-- View: camdaux.vw_allowance_based_compliance_bulk_files_to_generate

DROP VIEW IF EXISTS camdaux.vw_allowance_based_compliance_bulk_files_to_generate;

CREATE OR REPLACE VIEW camdaux.vw_allowance_based_compliance_bulk_files_to_generate
 AS
 SELECT acd.prg_code,
    acd.op_year AS calendar_year
   FROM camddmw.account_compliance_dim acd
     JOIN camddmw.account_fact af ON acd.account_number::text = af.account_number::text AND acd.prg_code::text = af.prg_code::text
     JOIN camdmd.program_code pc ON acd.prg_code::text = pc.prg_cd::text AND pc.bulk_file_active = 1::numeric
      JOIN (
              SELECT  COALESCE(max(job.start_date), timezone('est'::text, CURRENT_TIMESTAMP) - '90 days'::interval) AS last_start_timestamp
                 FROM  camdaux.job_log job
                 WHERE  job.job_system::text = 'Quartz'::text AND job.job_class::text = 'Bulk Data File'::text AND job.job_name::text = 'Allowance Compliance'::text AND job.status_cd::text = 'COMPLETE'::text
           ) cmp
          ON NULL::unknown IS NULL
  WHERE  (acd.last_update_date >= date(timezone('est'::text, cmp.last_start_timestamp) - '1 day'::interval) OR af.last_update_date >= date(timezone('est'::text, cmp.last_start_timestamp) - '1 day'::interval)) AND camdaux.can_generate_compliance(acd.op_year::integer, acd.prg_code)
  GROUP BY  acd.prg_code, acd.op_year;
