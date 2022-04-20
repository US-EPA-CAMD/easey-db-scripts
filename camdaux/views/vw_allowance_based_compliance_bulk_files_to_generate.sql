-- View: camdaux.vw_allowance_based_compliance_bulk_files_to_generate

-- DROP VIEW camdaux.vw_allowance_based_compliance_bulk_files_to_generate;

CREATE OR REPLACE VIEW camdaux.vw_allowance_based_compliance_bulk_files_to_generate
 AS
 SELECT DISTINCT account_fact.prg_code
   FROM camddmw.account_fact
  WHERE account_fact.last_update_date >= date(timezone('est'::text, CURRENT_TIMESTAMP) - '1 day'::interval)
UNION
 SELECT DISTINCT account_compliance_dim.prg_code
   FROM camddmw.account_compliance_dim
  WHERE account_compliance_dim.last_update_date >= date(timezone('est'::text, CURRENT_TIMESTAMP) - '1 day'::interval);
