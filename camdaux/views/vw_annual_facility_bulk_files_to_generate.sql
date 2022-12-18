-- View: camdaux.vw_annual_facility_bulk_files_to_generate

DROP VIEW IF EXISTS camdaux.vw_annual_facility_bulk_files_to_generate;

CREATE OR REPLACE VIEW camdaux.vw_annual_facility_bulk_files_to_generate
 AS
 SELECT DISTINCT uf.op_year AS year
   FROM camddmw.unit_fact uf
     LEFT JOIN camddmw.owner_display_fact odf ON uf.unit_id = odf.unit_id AND uf.op_year = odf.op_year
  WHERE uf.last_update_date >= date(timezone('est'::text, CURRENT_TIMESTAMP) - '1 day'::interval) OR odf.last_update_date >= date(timezone('est'::text, CURRENT_TIMESTAMP) - '1 day'::interval)
UNION
 SELECT DISTINCT date_part('year'::text, ug.begin_date) AS year
   FROM camd.unit_generator ug
     JOIN camd.generator g USING (gen_id)
  WHERE ug.add_date >= date(timezone('est'::text, CURRENT_TIMESTAMP) - '1 day'::interval) OR ug.update_date >= date(timezone('est'::text, CURRENT_TIMESTAMP) - '1 day'::interval) OR g.add_date >= date(timezone('est'::text, CURRENT_TIMESTAMP) - '1 day'::interval) OR g.update_date >= date(timezone('est'::text, CURRENT_TIMESTAMP) - '1 day'::interval)
UNION
 SELECT DISTINCT date_part('year'::text, ug.end_date) AS year
   FROM camd.unit_generator ug
     JOIN camd.generator g USING (gen_id)
  WHERE ug.end_date IS NOT NULL AND (ug.add_date >= date(timezone('est'::text, CURRENT_TIMESTAMP) - '1 day'::interval) OR ug.update_date >= date(timezone('est'::text, CURRENT_TIMESTAMP) - '1 day'::interval) OR g.add_date >= date(timezone('est'::text, CURRENT_TIMESTAMP) - '1 day'::interval) OR g.update_date >= date(timezone('est'::text, CURRENT_TIMESTAMP) - '1 day'::interval));
