-- View: camddmw.vw_ozone_unit_data

-- DROP VIEW camddmw.vw_ozone_unit_data;

CREATE OR REPLACE VIEW camddmw.vw_ozone_unit_data
 AS
 SELECT uf.state,
    uf.facility_name,
    uf.orispl_code,
    uf.unitid,
    uf.assoc_stacks,
    oud.op_year,
    oud.sum_op_time,
    oud.count_op_time,
    oud.gload,
    oud.sload,
    oud.so2_mass,
    oud.so2_rate,
    oud.co2_mass,
    oud.co2_rate,
    oud.nox_mass,
    oud.nox_rate,
    oud.heat_input,
    uf.primary_fuel_info,
    uf.secondary_fuel_info,
    uf.unit_type_info,
    uf.so2_control_info,
    uf.nox_control_info,
    uf.part_control_info,
    uf.hg_control_info,
    uf.prg_code_info
   FROM camddmw.ozone_unit_data oud
     JOIN camddmw.unit_fact uf ON oud.unit_id = uf.unit_id AND oud.op_year = uf.op_year
UNION
 SELECT uf.state,
    uf.facility_name,
    uf.orispl_code,
    uf.unitid,
    uf.assoc_stacks,
    oud.op_year,
    oud.sum_op_time,
    oud.count_op_time,
    oud.gload,
    oud.sload,
    oud.so2_mass,
    oud.so2_rate,
    oud.co2_mass,
    oud.co2_rate,
    oud.nox_mass,
    oud.nox_rate,
    oud.heat_input,
    uf.primary_fuel_info,
    uf.secondary_fuel_info,
    uf.unit_type_info,
    uf.so2_control_info,
    uf.nox_control_info,
    uf.part_control_info,
    uf.hg_control_info,
    uf.prg_code_info
   FROM camddmw_arch.ozone_unit_data_a oud
     JOIN camddmw.unit_fact uf ON oud.unit_id = uf.unit_id AND oud.op_year = uf.op_year;
