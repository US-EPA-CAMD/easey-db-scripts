-- View: camddmw.vw_day_unit_data

-- DROP VIEW camddmw.vw_day_unit_data;

CREATE OR REPLACE VIEW camddmw.vw_day_unit_data
 AS
 SELECT uf.state,
    uf.facility_name,
    uf.orispl_code,
    uf.unitid,
    uf.assoc_stacks,
    dud.op_date,
    dud.sum_op_time,
    dud.count_op_time,
    dud.gload,
    dud.sload,
    dud.so2_mass,
    dud.so2_rate,
    dud.co2_mass,
    dud.co2_rate,
    dud.nox_mass,
    dud.nox_rate,
    dud.heat_input,
    uf.primary_fuel_info,
    uf.secondary_fuel_info,
    uf.unit_type_info,
    uf.so2_control_info,
    uf.nox_control_info,
    uf.part_control_info,
    uf.hg_control_info,
    uf.prg_code_info
   FROM camddmw.day_unit_data dud
     JOIN camddmw.unit_fact uf ON dud.unit_id = uf.unit_id AND dud.op_year = uf.op_year
UNION
 SELECT uf.state,
    uf.facility_name,
    uf.orispl_code,
    uf.unitid,
    uf.assoc_stacks,
    dud.op_date,
    dud.sum_op_time,
    dud.count_op_time,
    dud.gload,
    dud.sload,
    dud.so2_mass,
    dud.so2_rate,
    dud.co2_mass,
    dud.co2_rate,
    dud.nox_mass,
    dud.nox_rate,
    dud.heat_input,
    uf.primary_fuel_info,
    uf.secondary_fuel_info,
    uf.unit_type_info,
    uf.so2_control_info,
    uf.nox_control_info,
    uf.part_control_info,
    uf.hg_control_info,
    uf.prg_code_info
   FROM camddmw_arch.day_unit_data_a dud
     JOIN camddmw.unit_fact uf ON dud.unit_id = uf.unit_id AND dud.op_year = uf.op_year;
