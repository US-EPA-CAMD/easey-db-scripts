-- PROCEDURE: camdecmpswks.copy_monitor_plan_to_workspace(text)

-- DROP PROCEDURE camdecmpswks.copy_monitor_plan_to_workspace(text);

CREATE OR REPLACE PROCEDURE camdecmpswks.copy_monitor_plan_to_workspace(
	monplanid text)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	monLocIds 		text[];
	unitIds   		integer[];
	stackPipeIds	text[];	
BEGIN
	-- GET LIST OF LOCATION IDs IN THE MONITOR PLAN
	SELECT ARRAY(
		SELECT mon_loc_id
		FROM camdecmps.monitor_plan_location
		WHERE mon_plan_id = monPlanId
	) INTO monLocIds;

	-- GET LIST OF UNIT IDs FOR ALL LOCATIONS IN THE MONITOR PLAN
	SELECT ARRAY(
		SELECT unit_id
		FROM camdecmps.monitor_location
		WHERE mon_loc_id = ANY(monLocIds)
		AND unit_id IS NOT NULL
	) INTO unitIds;
	
	-- GET LIST OF STACK PIPE IDs FOR ALL LOCATIONS IN THE MONITOR PLAN
	SELECT ARRAY(
		SELECT stack_pipe_id
		FROM camdecmps.monitor_location
		WHERE mon_loc_id = ANY(monLocIds)
		AND stack_pipe_id IS NOT NULL
	) INTO stackPipeIds;

	---------------------------------- UNIT & STACK PIPE DATA --------------------------------------------

	-- STACK_PIPE --
	INSERT INTO camdecmpswks.stack_pipe(
		stack_pipe_id, fac_id, stack_name, active_date, retire_date, userid, add_date, update_date
	)
	SELECT
		stack_pipe_id, fac_id, stack_name, active_date, retire_date, userid, add_date, update_date		
	FROM camdecmps.stack_pipe
	WHERE stack_pipe_id = ANY(stackPipeIds);

	-- UNIT_CAPACITY --
	INSERT INTO camdecmpswks.unit_capacity(
		unit_cap_id, unit_id, begin_date, end_date, max_hi_capacity, userid, add_date, update_date
	)
	SELECT
		unit_cap_id, unit_id, begin_date, end_date, max_hi_capacity, userid, add_date, update_date
	FROM camdecmps.unit_capacity
	WHERE unit_id = ANY (unitIds);

	-- UNIT_CONTROL --
	INSERT INTO camdecmpswks.unit_control(
		ctl_id, unit_id, control_cd, ce_param, install_date, opt_date, orig_cd, seas_cd, retire_date, indicator_cd, userid, add_date, update_date
	)
	SELECT
		ctl_id, unit_id, control_cd, ce_param, install_date, opt_date, orig_cd, seas_cd, retire_date, indicator_cd, userid, add_date, update_date
	FROM camdecmps.unit_control
	WHERE unit_id = ANY (unitIds);

	-- UNIT_FUEL --
	INSERT INTO camdecmpswks.unit_fuel(
		uf_id, unit_id, fuel_type, begin_date, end_date, indicator_cd, act_or_proj_cd, ozone_seas_ind, dem_so2, dem_gcv, sulfur_content, userid, add_date, update_date
	)
	SELECT
		uf_id, unit_id, fuel_type, begin_date, end_date, indicator_cd, act_or_proj_cd, ozone_seas_ind, dem_so2, dem_gcv, sulfur_content, userid, add_date, update_date
	FROM camdecmps.unit_fuel
	WHERE unit_id = ANY (unitIds);

	-- UNIT_STACK_CONFIGURATION --
	INSERT INTO camdecmpswks.unit_stack_configuration(
		config_id, unit_id, stack_pipe_id, begin_date, end_date, userid, add_date, update_date
	)
	SELECT
		config_id, unit_id, stack_pipe_id, begin_date, end_date, userid, add_date, update_date
	FROM camdecmps.unit_stack_configuration
	WHERE unit_id = ANY (unitIds);	

	---------------------------------- MONITOR PLAN DATA --------------------------------------------

	-- MONITOR_PLAN --
	INSERT INTO camdecmpswks.monitor_plan(
		mon_plan_id, fac_id, config_type_cd, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, userid, add_date, update_date, submission_id, submission_availability_cd, pending_status_cd, begin_rpt_period_id, end_rpt_period_id, last_evaluated_date
	)
	SELECT
		mon_plan_id, fac_id, config_type_cd, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, userid, add_date, update_date, submission_id, submission_availability_cd, 'NOTSUB', begin_rpt_period_id, end_rpt_period_id, last_evaluated_date
	FROM camdecmps.monitor_plan
	WHERE mon_plan_id = monPlanId;

	-- MONITOR_PLAN_COMMENT --
	INSERT INTO camdecmpswks.monitor_plan_comment(
		mon_plan_comment_id, mon_plan_id, mon_plan_comment, begin_date, end_date, userid, add_date, submission_availability_cd, update_date
	)
	SELECT
		mon_plan_comment_id, mon_plan_id, mon_plan_comment, begin_date, end_date, userid, add_date, submission_availability_cd, update_date
	FROM camdecmps.monitor_plan_comment
	WHERE mon_plan_id = monPlanId;

	-- MONITOR_PLAN_REPORTING_FREQ --
	INSERT INTO camdecmpswks.monitor_plan_reporting_freq(
		mon_plan_rf_id, mon_plan_id, report_freq_cd, end_rpt_period_id, begin_rpt_period_id, userid, add_date, update_date
	)
	SELECT
		mon_plan_rf_id, mon_plan_id, report_freq_cd, end_rpt_period_id, begin_rpt_period_id, userid, add_date, update_date
	FROM camdecmps.monitor_plan_reporting_freq
	WHERE mon_plan_id = monPlanId;

	-- MONITOR_LOCATION --
	INSERT INTO camdecmpswks.monitor_location(
		mon_loc_id, stack_pipe_id, unit_id, userid, add_date, update_date
	)
	SELECT
		mon_loc_id, stack_pipe_id, unit_id, userid, add_date, update_date
	FROM camdecmps.monitor_location
	WHERE mon_loc_id = ANY(monLocIds);
	
	-- MONITOR_PLAN_LOCATION --
	INSERT INTO camdecmpswks.monitor_plan_location(
		monitor_plan_location_id, mon_plan_id, mon_loc_id
	)
	SELECT
		monitor_plan_location_id, mon_plan_id, mon_loc_id
	FROM camdecmps.monitor_plan_location
	WHERE mon_loc_id = ANY(monLocIds);

	-- COMPONENT --
	INSERT INTO camdecmpswks.component(
		component_id, mon_loc_id, component_identifier, model_version, serial_number, manufacturer, component_type_cd, acq_cd, basis_cd, userid, add_date, update_date, hg_converter_ind
	)
	SELECT
		component_id, mon_loc_id, component_identifier, model_version, serial_number, manufacturer, component_type_cd, acq_cd, basis_cd, userid, add_date, update_date, hg_converter_ind
	FROM camdecmps.component
	WHERE mon_loc_id = ANY(monLocIds);

	-- ANALYZER_RANGE --
	INSERT INTO camdecmpswks.analyzer_range(
		analyzer_range_id, component_id, analyzer_range_cd, dual_range_ind, begin_date, begin_hour, end_date, end_hour, userid, add_date, update_date
	)
	SELECT
		ar.analyzer_range_id, ar.component_id, ar.analyzer_range_cd, ar.dual_range_ind, ar.begin_date, ar.begin_hour, ar.end_date, ar.end_hour, ar.userid, ar.add_date, ar.update_date
	FROM camdecmps.analyzer_range AS ar
	JOIN camdecmps.component
		USING(component_id)
	WHERE mon_loc_id = ANY(monLocIds);

	-- MATS_METHOD_DATA --
	INSERT INTO camdecmpswks.mats_method_data(
		mats_method_data_id, mon_loc_id, mats_method_cd, mats_method_parameter_cd, begin_date, begin_hour, end_date, end_hour, userid, add_date, update_date
	)
	SELECT
		mats_method_data_id, mon_loc_id, mats_method_cd, mats_method_parameter_cd, begin_date, begin_hour, end_date, end_hour, userid, add_date, update_date
	FROM camdecmps.mats_method_data
	WHERE mon_loc_id = ANY(monLocIds);

	-- MONITOR_DEFAULT --
	INSERT INTO camdecmpswks.monitor_default(
		mondef_id, mon_loc_id, parameter_cd, begin_date, begin_hour, end_date, end_hour, operating_condition_cd, default_value, default_purpose_cd, default_source_cd, fuel_cd, group_id, userid, add_date, update_date, default_uom_cd
	)
	SELECT
		mondef_id, mon_loc_id, parameter_cd, begin_date, begin_hour, end_date, end_hour, operating_condition_cd, default_value, default_purpose_cd, default_source_cd, fuel_cd, group_id, userid, add_date, update_date, default_uom_cd
	FROM camdecmps.monitor_default
	WHERE mon_loc_id = ANY(monLocIds);

	-- MONITOR_FORMULA --
	INSERT INTO camdecmpswks.monitor_formula(
		mon_form_id, mon_loc_id, parameter_cd, equation_cd, formula_identifier, begin_date, begin_hour, end_date, end_hour, formula_equation, userid, add_date, update_date
	)
	SELECT
		mon_form_id, mon_loc_id, parameter_cd, equation_cd, formula_identifier, begin_date, begin_hour, end_date, end_hour, formula_equation, userid, add_date, update_date
	FROM camdecmps.monitor_formula
	WHERE mon_loc_id = ANY(monLocIds);

	-- MONITOR_LOAD --
	INSERT INTO camdecmpswks.monitor_load(
		load_id, mon_loc_id, load_analysis_date, begin_date, begin_hour, end_date, end_hour, max_load_value, second_normal_ind, up_op_boundary, low_op_boundary, normal_level_cd, second_level_cd, userid, add_date, update_date, max_load_uom_cd
	)
	SELECT
		load_id, mon_loc_id, load_analysis_date, begin_date, begin_hour, end_date, end_hour, max_load_value, second_normal_ind, up_op_boundary, low_op_boundary, normal_level_cd, second_level_cd, userid, add_date, update_date, max_load_uom_cd
	FROM camdecmps.monitor_load
	WHERE mon_loc_id = ANY(monLocIds);

	-- MONITOR_LOCATION_ATTRIBUTE --
	INSERT INTO camdecmpswks.monitor_location_attribute(
		mon_loc_attrib_id, mon_loc_id, grd_elevation, duct_ind, bypass_ind, cross_area_flow, cross_area_exit, begin_date, end_date, stack_height, shape_cd, material_cd, add_date, update_date, userid
	)
	SELECT
		mon_loc_attrib_id, mon_loc_id, grd_elevation, duct_ind, bypass_ind, cross_area_flow, cross_area_exit, begin_date, end_date, stack_height, shape_cd, material_cd, add_date, update_date, userid
	FROM camdecmps.monitor_location_attribute
	WHERE mon_loc_id = ANY(monLocIds);

	-- MONITOR_METHOD --
	INSERT INTO camdecmpswks.monitor_method(
		mon_method_id, mon_loc_id, parameter_cd, sub_data_cd, bypass_approach_cd, method_cd, begin_date, begin_hour, end_date, end_hour, userid, add_date, update_date
	)
	SELECT
		mon_method_id, mon_loc_id, parameter_cd, sub_data_cd, bypass_approach_cd, method_cd, begin_date, begin_hour, end_date, end_hour, userid, add_date, update_date
	FROM camdecmps.monitor_method
	WHERE mon_loc_id = ANY(monLocIds);

	-- MONITOR_QUALIFICATION --
	INSERT INTO camdecmpswks.monitor_qualification(
		mon_qual_id, mon_loc_id, qual_type_cd, begin_date, end_date, userid, add_date, update_date
	)
	SELECT
		mon_qual_id, mon_loc_id, qual_type_cd, begin_date, end_date, userid, add_date, update_date
	FROM camdecmps.monitor_qualification
	WHERE mon_loc_id = ANY(monLocIds);

	-- MONITOR_QUALIFICATION_LEE --
	INSERT INTO camdecmpswks.monitor_qualification_lee(
		mon_qual_lee_id, mon_qual_id, qual_test_date, parameter_cd, qual_lee_test_type_cd, potential_annual_emissions, applicable_emission_standard, emission_standard_uom, emission_standard_pct, userid, add_date, update_date
	)
	SELECT
		mq.mon_qual_lee_id, mq.mon_qual_id, mq.qual_test_date, mq.parameter_cd, mq.qual_lee_test_type_cd, mq.potential_annual_emissions, mq.applicable_emission_standard, mq.emission_standard_uom, mq.emission_standard_pct, mq.userid, mq.add_date, mq.update_date
	FROM camdecmps.monitor_qualification_lee AS mq
	JOIN camdecmps.monitor_qualification
		USING (mon_qual_id)
	WHERE mon_loc_id = ANY(monLocIds);

	-- MONITOR_QUALIFICATION_LME --		
	INSERT INTO camdecmpswks.monitor_qualification_lme(
		mon_lme_id, mon_qual_id, qual_data_year, so2_tons, nox_tons, op_hours, userid, add_date, update_date
	)
	SELECT
		mq.mon_lme_id, mq.mon_qual_id, mq.qual_data_year, mq.so2_tons, mq.nox_tons, mq.op_hours, mq.userid, mq.add_date, mq.update_date
	FROM camdecmps.monitor_qualification_lme AS mq
	JOIN camdecmps.monitor_qualification
		USING (mon_qual_id)
	WHERE mon_loc_id = ANY(monLocIds);

	-- MONITOR_QUALIFICATION_PCT --		
	INSERT INTO camdecmpswks.monitor_qualification_pct(
		mon_pct_id, mon_qual_id, qual_year, yr1_qual_data_type_cd, yr1_qual_data_year, yr1_pct_value, yr2_qual_data_type_cd, yr2_qual_data_year, yr2_pct_value, yr3_qual_data_type_cd, yr3_qual_data_year, yr3_pct_value, avg_pct_value, userid, add_date, update_date
	)
	SELECT
		mq.mon_pct_id, mq.mon_qual_id, mq.qual_year, mq.yr1_qual_data_type_cd, mq.yr1_qual_data_year, mq.yr1_pct_value, mq.yr2_qual_data_type_cd, mq.yr2_qual_data_year, mq.yr2_pct_value, mq.yr3_qual_data_type_cd, mq.yr3_qual_data_year, mq.yr3_pct_value, mq.avg_pct_value, mq.userid, mq.add_date, mq.update_date
	FROM camdecmps.monitor_qualification_pct AS mq
	JOIN camdecmps.monitor_qualification
		USING (mon_qual_id)
	WHERE mon_loc_id = ANY(monLocIds);

	-- MONITOR_SPAN --
	INSERT INTO camdecmpswks.monitor_span(
		span_id, mon_loc_id, mpc_value, mec_value, mpf_value, max_low_range, span_value, full_scale_range, begin_date, begin_hour, end_date, end_hour, default_high_range, flow_span_value, flow_full_scale_range, component_type_cd, span_scale_cd, span_method_cd, userid, add_date, update_date, span_uom_cd
	)
	SELECT
		span_id, mon_loc_id, mpc_value, mec_value, mpf_value, max_low_range, span_value, full_scale_range, begin_date, begin_hour, end_date, end_hour, default_high_range, flow_span_value, flow_full_scale_range, component_type_cd, span_scale_cd, span_method_cd, userid, add_date, update_date, span_uom_cd
	FROM camdecmps.monitor_span
	WHERE mon_loc_id = ANY(monLocIds);

	-- MONITOR_SYSTEM --
	INSERT INTO camdecmpswks.monitor_system(
		mon_sys_id, mon_loc_id, system_identifier, sys_type_cd, begin_date, begin_hour, end_date, end_hour, sys_designation_cd, fuel_cd, userid, add_date, update_date
	)
	SELECT
		mon_sys_id, mon_loc_id, system_identifier, sys_type_cd, begin_date, begin_hour, end_date, end_hour, sys_designation_cd, fuel_cd, userid, add_date, update_date
	FROM camdecmps.monitor_system
	WHERE mon_loc_id = ANY(monLocIds);

	-- MONITOR_SYSTEM_COMPONENT --
	INSERT INTO camdecmpswks.monitor_system_component(
		mon_sys_comp_id, mon_sys_id, component_id, begin_hour, begin_date, end_date, end_hour, userid, add_date, update_date
	)
	SELECT
		msc.mon_sys_comp_id, msc.mon_sys_id, msc.component_id, msc.begin_hour, msc.begin_date, msc.end_date, msc.end_hour, msc.userid, msc.add_date, msc.update_date
	FROM camdecmps.monitor_system_component AS msc
	JOIN camdecmps.monitor_system
		USING(mon_sys_id)
	WHERE mon_loc_id = ANY(monLocIds);

	-- RECT_DUCT_WAF --
	INSERT INTO camdecmpswks.rect_duct_waf(
		rect_duct_waf_data_id, mon_loc_id, waf_determined_date, waf_effective_date, waf_effective_hour, waf_method_cd, waf_value, num_test_runs, num_traverse_points_waf, num_test_ports, num_traverse_points_ref, duct_width, duct_depth, end_date, end_hour, add_date, update_date, userid
	)
	SELECT
		rect_duct_waf_data_id, mon_loc_id, waf_determined_date, waf_effective_date, waf_effective_hour, waf_method_cd, waf_value, num_test_runs, num_traverse_points_waf, num_test_ports, num_traverse_points_ref, duct_width, duct_depth, end_date, end_hour, add_date, update_date, userid
	FROM camdecmps.rect_duct_waf
	WHERE mon_loc_id = ANY(monLocIds);

	-- SYSTEM_FUEL_FLOW --
	INSERT INTO camdecmpswks.system_fuel_flow(
		sys_fuel_id, mon_sys_id, max_rate, begin_date, begin_hour, end_date, end_hour, max_rate_source_cd, userid, add_date, update_date, sys_fuel_uom_cd
	)
	SELECT
		sff.sys_fuel_id, sff.mon_sys_id, sff.max_rate, sff.begin_date, sff.begin_hour, sff.end_date, sff.end_hour, sff.max_rate_source_cd, sff.userid, sff.add_date, sff.update_date, sff.sys_fuel_uom_cd
	FROM camdecmps.system_fuel_flow AS sff
	JOIN camdecmps.monitor_system
		USING(mon_sys_id)
	WHERE mon_loc_id = ANY(monLocIds);

END;
$BODY$;
