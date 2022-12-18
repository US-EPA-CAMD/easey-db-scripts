-- View: camdaux.vw_emissions_based_compliance_bulk_files_to_generate

DROP VIEW IF EXISTS camdaux.vw_emissions_based_compliance_bulk_files_to_generate;

CREATE OR REPLACE VIEW camdaux.vw_emissions_based_compliance_bulk_files_to_generate
 AS
 SELECT unit_fact.op_year AS calendar_year,
    'ARP'::text AS prg_code
   FROM camddmw.unit_fact
  WHERE unit_fact.last_update_date >= date(timezone('est'::text, CURRENT_TIMESTAMP) - '1 day'::interval) AND camdaux.can_generate_compliance(unit_fact.op_year::integer, 'ARP'::character varying)
UNION
 SELECT unit_compliance_dim.op_year AS calendar_year,
    'ARP'::text AS prg_code
   FROM camddmw.unit_compliance_dim
  WHERE unit_compliance_dim.last_update_date >= date(timezone('est'::text, CURRENT_TIMESTAMP) - '1 day'::interval) AND camdaux.can_generate_compliance(unit_compliance_dim.op_year::integer, 'ARP'::character varying)
UNION
 SELECT owner_display_fact.op_year AS calendar_year,
    'ARP'::text AS prg_code
   FROM camddmw.owner_display_fact
  WHERE owner_display_fact.last_update_date >= date(timezone('est'::text, CURRENT_TIMESTAMP) - '1 day'::interval) AND camdaux.can_generate_compliance(owner_display_fact.op_year::integer, 'ARP'::character varying);
