-- View camddmw.vw_hour_unit_mats_data

DROP VIEW IF EXISTS camddmw.vw_hour_unit_mats_data;

CREATE OR REPLACE VIEW camddmw.vw_hour_unit_mats_data
 AS
 SELECT uf.state,
    uf.facility_name,
    uf.orispl_code,
    uf.unitid,
    humd.op_date,
    humd.op_hour,
    humd.op_time,
    humd.gload,
    humd.heat_input,
    humd.hg_rate_eo,
    humd.hg_rate_hi,
    humd.hg_mass,
    humd.hg_measure_flg,
    humd.hcl_rate_eo,
    humd.hcl_rate_hi,
    humd.hcl_mass,
    humd.hcl_measure_flg,
    humd.hf_rate_eo,
    humd.hf_rate_hi,
    humd.hf_mass,
    humd.hf_measure_flg,
    uf.assoc_stacks,
    humd.sload,
    uf.primary_fuel_info,
    uf.secondary_fuel_info,
    uf.unit_type_info,
    uf.so2_control_info,
    uf.nox_control_info,
    uf.part_control_info,
    uf.hg_control_info
   FROM camddmw.hour_unit_mats_data humd
     JOIN camddmw.unit_fact uf ON humd.unit_id = uf.unit_id AND humd.op_year = uf.op_year
     JOIN camddmw.op_year oy ON humd.op_year = oy.op_year AND oy.archive_ind = 0::numeric
UNION ALL
 SELECT uf.state,
    uf.facility_name,
    uf.orispl_code,
    uf.unitid,
    humd.op_date,
    humd.op_hour,
    humd.op_time,
    humd.gload,
    humd.heat_input,
    humd.hg_rate_eo,
    humd.hg_rate_hi,
    humd.hg_mass,
    humd.hg_measure_flg,
    humd.hcl_rate_eo,
    humd.hcl_rate_hi,
    humd.hcl_mass,
    humd.hcl_measure_flg,
    humd.hf_rate_eo,
    humd.hf_rate_hi,
    humd.hf_mass,
    humd.hf_measure_flg,
    uf.assoc_stacks,
    humd.sload,
    uf.primary_fuel_info,
    uf.secondary_fuel_info,
    uf.unit_type_info,
    uf.so2_control_info,
    uf.nox_control_info,
    uf.part_control_info,
    uf.hg_control_info
   FROM camddmw_arch.hour_unit_mats_data_a humd
     JOIN camddmw.unit_fact uf ON humd.unit_id = uf.unit_id AND humd.op_year = uf.op_year
     JOIN camddmw.op_year oy ON humd.op_year = oy.op_year AND oy.archive_ind = 1::numeric;

