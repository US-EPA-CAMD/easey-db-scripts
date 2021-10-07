CREATE OR REPLACE VIEW camddmw.vw_facility_unit_attributes
 AS
 SELECT uf.unit_id,
    uf.op_year,
    pyd.prg_code,
    pyd.report_freq,
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
    uf.facility_name
   FROM camddmw.unit_fact uf
     JOIN ( SELECT ug.unit_id,
            string_agg(g.genid::text, ', '::text) AS generator_id
           FROM camd.generator g
             JOIN camd.unit_generator ug ON g.gen_id = ug.gen_id
          GROUP BY ug.unit_id) d ON uf.unit_id = d.unit_id
     LEFT JOIN camddmw.program_year_dim pyd ON uf.unit_id = pyd.unit_id AND uf.op_year = pyd.op_year
     LEFT JOIN camddmw.owner_display_fact odf ON uf.unit_id = odf.unit_id AND uf.op_year = odf.op_year;
