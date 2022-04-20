-- View: camdaux.vw_emissions_based_compliance_bulk_files_to_generate

-- DROP VIEW camdaux.vw_emissions_based_compliance_bulk_files_to_generate;

CREATE OR REPLACE VIEW camdaux.vw_emissions_based_compliance_bulk_files_to_generate
 AS
 SELECT 'ARP'::text AS prg_code
   FROM camddmw.unit_fact
  WHERE unit_fact.last_update_date >= date(timezone('est'::text, CURRENT_TIMESTAMP) - '1 day'::interval)
UNION
 SELECT 'ARP'::text AS prg_code
   FROM camddmw.unit_compliance_dim
  WHERE unit_compliance_dim.last_update_date >= date(timezone('est'::text, CURRENT_TIMESTAMP) - '1 day'::interval)
UNION
 SELECT 'ARP'::text AS prg_code
   FROM camddmw.owner_display_fact
  WHERE owner_display_fact.last_update_date >= date(timezone('est'::text, CURRENT_TIMESTAMP) - '1 day'::interval);
