--View camddmw.vw_month_unit_data

DROP VIEW IF EXISTS camddmw.vw_month_unit_data;

CREATE OR REPLACE VIEW camddmw.vw_month_unit_data
 AS
 SELECT uf.state,
    uf.facility_name,
    uf.orispl_code,
    uf.unitid,
    uf.assoc_stacks,
    mud.op_year,
    mud.op_month,
    mud.sum_op_time,
    mud.count_op_time,
    mud.gload,
    mud.sload,
    mud.so2_mass,
    mud.so2_rate,
    mud.co2_mass,
    mud.co2_rate,
    mud.nox_mass,
    mud.nox_rate,
    mud.heat_input,
    uf.primary_fuel_info,
    uf.secondary_fuel_info,
    uf.unit_type_info,
    uf.so2_control_info,
    uf.nox_control_info,
    uf.part_control_info,
    uf.hg_control_info,
    uf.prg_code_info
   FROM camddmw.month_unit_data mud
     JOIN camddmw.unit_fact uf ON mud.unit_id = uf.unit_id AND mud.op_year = uf.op_year
     JOIN camddmw.op_year oy ON mud.op_year = oy.op_year AND oy.archive_ind = 0::numeric
UNION ALL
 SELECT uf.state,
    uf.facility_name,
    uf.orispl_code,
    uf.unitid,
    uf.assoc_stacks,
    mud.op_year,
    mud.op_month,
    mud.sum_op_time,
    mud.count_op_time,
    mud.gload,
    mud.sload,
    mud.so2_mass,
    mud.so2_rate,
    mud.co2_mass,
    mud.co2_rate,
    mud.nox_mass,
    mud.nox_rate,
    mud.heat_input,
    uf.primary_fuel_info,
    uf.secondary_fuel_info,
    uf.unit_type_info,
    uf.so2_control_info,
    uf.nox_control_info,
    uf.part_control_info,
    uf.hg_control_info,
    uf.prg_code_info
   FROM camddmw_arch.month_unit_data_a mud
     JOIN camddmw.unit_fact uf ON mud.unit_id = uf.unit_id AND mud.op_year = uf.op_year
     JOIN camddmw.op_year oy ON mud.op_year = oy.op_year AND oy.archive_ind = 1::numeric;
