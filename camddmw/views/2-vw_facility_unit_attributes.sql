-- View: camddmw.vw_facility_unit_attributes

DROP VIEW IF EXISTS camddmw.vw_facility_unit_attributes;

CREATE OR REPLACE VIEW camddmw.vw_facility_unit_attributes
 AS
 SELECT uf.unit_id,
    uf.op_year,
    uf.prg_code_info,
    uf.state,
    uf.orispl_code,
    uf.unitid,
    uf.assoc_stacks,
    uf.epa_region,
    uf.nerc_region,
    uf.county,
    uf.county_code,
    uf.fips_code,
    uf.source_cat,
    uf.latitude,
    uf.longitude,
    uf.so2_phase,
    uf.nox_phase,
    uf.unit_type_info,
    uf.primary_fuel_info,
    uf.secondary_fuel_info,
    uf.so2_control_info,
    uf.nox_control_info,
    uf.part_control_info,
    uf.hg_control_info,
    uf.comr_op_date,
    uf.op_status_info,
    uf.capacity_input,
    odf.own_display,
    odf.opr_display,
    d.generator_id,
    uf.facility_name,
    d.arp_nameplate_capacity,
    d.other_nameplate_capacity,
    rep.primary_rep_info
   FROM camddmw.unit_fact uf
     LEFT JOIN camddmw.vw_rep_display_fact rep ON uf.unit_id = rep.unit_id AND uf.op_year = rep.op_year
     LEFT JOIN ( SELECT ug.unit_id,
            string_agg(g.genid::text, ', '::text) AS generator_id,
            string_agg(COALESCE(g.arp_nameplate_capacity::text, 'null'::text), ', '::text) AS arp_nameplate_capacity,
            string_agg(COALESCE(g.other_nameplate_capacity::text, 'null'::text), ', '::text) AS other_nameplate_capacity
           FROM camd.generator g
             JOIN camd.unit_generator ug ON g.gen_id = ug.gen_id
          GROUP BY ug.unit_id) d ON uf.unit_id = d.unit_id
     LEFT JOIN camddmw.owner_display_fact odf ON uf.unit_id = odf.unit_id AND uf.op_year = odf.op_year;
