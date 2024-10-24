-- View camddmw.vw_quarter_unit_data

DROP VIEW IF EXISTS camddmw.vw_quarter_unit_data;

CREATE OR REPLACE VIEW camddmw.vw_quarter_unit_data
 AS
 SELECT uf.state,
    uf.facility_name,
    uf.orispl_code,
    uf.unit_id,
    uf.unitid,
    uf.assoc_stacks,
    qud.op_year,
    qud.op_quarter,
    qud.sum_op_time,
    qud.count_op_time,
    qud.gload,
    qud.sload,
    qud.so2_mass,
    qud.so2_rate,
    qud.co2_mass,
    qud.co2_rate,
    qud.nox_mass,
    qud.nox_rate,
    qud.heat_input,
    uf.primary_fuel_info,
    uf.secondary_fuel_info,
    uf.unit_type_info,
    uf.so2_control_info,
    uf.nox_control_info,
    uf.part_control_info,
    uf.hg_control_info,
    uf.prg_code_info
   FROM camddmw.quarter_unit_data qud
     JOIN camddmw.unit_fact uf ON qud.unit_id = uf.unit_id AND qud.op_year = uf.op_year
     JOIN camddmw.op_year oy ON qud.op_year = oy.op_year AND oy.archive_ind = 0::numeric
UNION ALL
 SELECT uf.state,
    uf.facility_name,
    uf.orispl_code,
    uf.unit_id,
    uf.unitid,
    uf.assoc_stacks,
    qud.op_year,
    qud.op_quarter,
    qud.sum_op_time,
    qud.count_op_time,
    qud.gload,
    qud.sload,
    qud.so2_mass,
    qud.so2_rate,
    qud.co2_mass,
    qud.co2_rate,
    qud.nox_mass,
    qud.nox_rate,
    qud.heat_input,
    uf.primary_fuel_info,
    uf.secondary_fuel_info,
    uf.unit_type_info,
    uf.so2_control_info,
    uf.nox_control_info,
    uf.part_control_info,
    uf.hg_control_info,
    uf.prg_code_info
   FROM camddmw_arch.quarter_unit_data_a qud
     JOIN camddmw.unit_fact uf ON qud.unit_id = uf.unit_id AND qud.op_year = uf.op_year
     JOIN camddmw.op_year oy ON qud.op_year = oy.op_year AND oy.archive_ind = 1::numeric;