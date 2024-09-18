-- PROCEDURE: camdecmps.copy_monitor_plan_from_workspace_to_global(text)

DROP PROCEDURE IF EXISTS camdecmps.copy_monitor_plan_from_workspace_to_global(text);

CREATE OR REPLACE PROCEDURE camdecmps.copy_monitor_plan_from_workspace_to_global(
	monplanid text)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	unitIds   			int[];
	monLocIds 			text[];
	stackPipeIds		text[];
	unitStackConfigIds 	text[];
BEGIN
	SELECT ARRAY(
		SELECT mon_loc_id
		FROM camdecmpswks.monitor_plan_location
		WHERE mon_plan_id = monPlanId
	) INTO monLocIds;

	SELECT ARRAY(
		SELECT unit_id
		FROM camdecmpswks.monitor_location
		WHERE mon_loc_id = ANY(monLocIds)
		AND unit_id IS NOT NULL
	) INTO unitIds;

	SELECT ARRAY(
		SELECT stack_pipe_id
		FROM camdecmpswks.monitor_location
		WHERE mon_loc_id = ANY(monLocIds)
		AND stack_pipe_id IS NOT NULL
	) INTO stackPipeIds;

	SELECT ARRAY(
		SELECT config_id
		FROM camdecmpswks.unit_stack_configuration
		WHERE unit_id = ANY(unitIds)
		OR stack_pipe_id = ANY(stackPipeIds)
	) INTO unitStackConfigIds;

	---------------------------------- MONITOR PLAN TOP LEVEL --------------------------------------------
		-- MONITOR_PLAN --
	INSERT INTO camdecmps.monitor_plan (
		mon_plan_id, fac_id, config_type_cd, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, userid, add_date, update_date, submission_id, submission_availability_cd, begin_rpt_period_id, end_rpt_period_id, last_evaluated_date
	)
	SELECT
		mon_plan_id, fac_id, config_type_cd, last_updated, updated_status_flg, needs_eval_flg, chk_session_id, userid, add_date, update_date, submission_id, 'UPDATED', begin_rpt_period_id, end_rpt_period_id, last_evaluated_date
	FROM camdecmpswks.monitor_plan
	WHERE mon_plan_id = monPlanId
	ON CONFLICT (mon_plan_id) DO UPDATE
	SET fac_id = EXCLUDED.fac_id,
		config_type_cd = EXCLUDED.config_type_cd,
		last_updated = EXCLUDED.last_updated,
		updated_status_flg = EXCLUDED.updated_status_flg,
		needs_eval_flg = EXCLUDED.needs_eval_flg,
		chk_session_id = EXCLUDED.chk_session_id,
		userid = EXCLUDED.userid,
		add_date = EXCLUDED.add_date,
		update_date = EXCLUDED.update_date,
		submission_id = EXCLUDED.submission_id,
		submission_availability_cd = 'UPDATED',
		begin_rpt_period_id = EXCLUDED.begin_rpt_period_id,
		end_rpt_period_id = EXCLUDED.end_rpt_period_id,
		last_evaluated_date = EXCLUDED.last_evaluated_date;

		-- Check Session
	INSERT INTO camdecmpsaux.check_session (
			chk_session_id, mon_plan_id, test_sum_id, qa_cert_event_id, test_extension_exemption_id, rpt_period_id, session_begin_date, session_end_date, session_comment, severity_cd, category_cd, process_cd, userid
	)
	SELECT
			cs.chk_session_id, cs.mon_plan_id, cs.test_sum_id, cs.qa_cert_event_id, cs.test_extension_exemption_id, cs.rpt_period_id, cs.session_begin_date, cs.session_end_date, cs.session_comment, cs.severity_cd, cs.category_cd, cs.process_cd, cs.userid
	FROM camdecmpswks.monitor_plan mp
	JOIN camdecmpswks.check_session cs ON mp.chk_session_id = cs.chk_session_id
	WHERE mp.mon_plan_id = monPlanId
	ON CONFLICT (chk_session_id) DO UPDATE SET
			mon_plan_id = EXCLUDED.mon_plan_id,
			test_sum_id = EXCLUDED.test_sum_id,
			qa_cert_event_id = EXCLUDED.qa_cert_event_id,
			test_extension_exemption_id = EXCLUDED.test_extension_exemption_id,
			rpt_period_id = EXCLUDED.rpt_period_id,
			session_begin_date = EXCLUDED.session_begin_date,
			session_end_date = EXCLUDED.session_end_date,
			session_comment = EXCLUDED.session_comment,
			severity_cd = EXCLUDED.severity_cd,
			category_cd = EXCLUDED.category_cd,
			process_cd = EXCLUDED.process_cd,
			userid = EXCLUDED.userid;

	INSERT INTO camdecmpsaux.check_log (
			chk_log_id, chk_session_id, begin_date, rule_check_id, result_message, chk_log_comment, check_catalog_result_id, mon_loc_id, source_table, row_id, test_sum_id, op_begin_date, op_begin_hour, op_end_date, op_end_hour, check_date, check_hour, check_result, severity_cd, suppressed_severity_cd, check_cd, error_suppress_id
	)
	SELECT
			cl.chk_log_id, cl.chk_session_id, cl.begin_date, cl.rule_check_id, cl.result_message, cl.chk_log_comment, cl.check_catalog_result_id, cl.mon_loc_id, cl.source_table, cl.row_id, cl.test_sum_id, cl.op_begin_date, cl.op_begin_hour, cl.op_end_date, cl.op_end_hour, cl.check_date, cl.check_hour, cl.check_result, cl.severity_cd, cl.suppressed_severity_cd, cl.check_cd, cl.error_suppress_id
	FROM camdecmpswks.monitor_plan mp
	JOIN camdecmpswks.check_session cs ON mp.chk_session_id = cs.chk_session_id
	JOIN camdecmpswks.check_log cl ON cs.chk_session_id = cl.chk_session_id
	WHERE mp.mon_plan_id = monPlanId
	ON CONFLICT (chk_log_id) DO UPDATE SET
			chk_session_id = EXCLUDED.chk_session_id,
			begin_date = EXCLUDED.begin_date,
			rule_check_id = EXCLUDED.rule_check_id,
			result_message = EXCLUDED.result_message,
			chk_log_comment = EXCLUDED.chk_log_comment,
			check_catalog_result_id = EXCLUDED.check_catalog_result_id,
			mon_loc_id = EXCLUDED.mon_loc_id,
			source_table = EXCLUDED.source_table,
			row_id = EXCLUDED.row_id,
			test_sum_id = EXCLUDED.test_sum_id,
			op_begin_date = EXCLUDED.op_begin_date,
			op_begin_hour = EXCLUDED.op_begin_hour,
			op_end_date = EXCLUDED.op_end_date,
			op_end_hour = EXCLUDED.op_end_hour,
			check_date = EXCLUDED.check_date,
			check_hour = EXCLUDED.check_hour,
			check_result = EXCLUDED.check_result,
			severity_cd = EXCLUDED.severity_cd,
			suppressed_severity_cd = EXCLUDED.suppressed_severity_cd,
			check_cd = EXCLUDED.check_cd,
			error_suppress_id = EXCLUDED.error_suppress_id;

	-- MONITOR_PLAN_COMMENT --
	INSERT INTO camdecmps.monitor_plan_comment (
		mon_plan_comment_id, mon_plan_id, mon_plan_comment, begin_date, end_date, userid, add_date, submission_availability_cd, update_date
	)
	SELECT
		mon_plan_comment_id, mon_plan_id, mon_plan_comment, begin_date, end_date, userid, add_date, 'UPDATED', update_date
	FROM camdecmpswks.monitor_plan_comment
	WHERE mon_plan_id = monPlanId
	ON CONFLICT (mon_plan_comment_id) DO UPDATE
	SET mon_plan_id = EXCLUDED.mon_plan_id,
		mon_plan_comment = EXCLUDED.mon_plan_comment,
		begin_date = EXCLUDED.begin_date,
		end_date = EXCLUDED.end_date,
		userid = EXCLUDED.userid,
		add_date = EXCLUDED.add_date,
		submission_availability_cd = 'UPDATED',
		update_date = EXCLUDED.update_date;

	-- MONITOR_PLAN_REPORTING_FREQ --
	INSERT INTO camdecmps.monitor_plan_reporting_freq (
		mon_plan_rf_id, mon_plan_id, report_freq_cd, end_rpt_period_id, begin_rpt_period_id, userid, add_date, update_date
	)
	SELECT
		mon_plan_rf_id, mon_plan_id, report_freq_cd, end_rpt_period_id, begin_rpt_period_id, userid, add_date, update_date
	FROM camdecmpswks.monitor_plan_reporting_freq
	WHERE mon_plan_id = monPlanId
	ON CONFLICT (mon_plan_rf_id) DO UPDATE
	SET mon_plan_id = EXCLUDED.mon_plan_id,
		report_freq_cd = EXCLUDED.report_freq_cd,
		end_rpt_period_id = EXCLUDED.end_rpt_period_id,
		begin_rpt_period_id = EXCLUDED.begin_rpt_period_id,
		userid = EXCLUDED.userid,
		add_date = EXCLUDED.add_date,
		update_date = EXCLUDED.update_date;

	-- MONITOR_LOCATION --
	INSERT INTO camdecmps.monitor_location (
		mon_loc_id, stack_pipe_id, unit_id, userid, add_date, update_date
	)
	SELECT
		mon_loc_id, stack_pipe_id, unit_id, userid, add_date, update_date
	FROM camdecmpswks.monitor_location
	WHERE mon_loc_id = ANY(monLocIds)
	ON CONFLICT (mon_loc_id) DO UPDATE
	SET stack_pipe_id = EXCLUDED.stack_pipe_id,
		unit_id = EXCLUDED.unit_id,
		userid = EXCLUDED.userid,
		add_date = EXCLUDED.add_date,
		update_date = EXCLUDED.update_date;

	-- MONITOR_PLAN_LOCATION --
	INSERT INTO camdecmps.monitor_plan_location (
		monitor_plan_location_id, mon_plan_id, mon_loc_id
	)
	SELECT
		monitor_plan_location_id, mon_plan_id, mon_loc_id
	FROM camdecmpswks.monitor_plan_location
	WHERE mon_loc_id = ANY(monLocIds)
	ON CONFLICT (monitor_plan_location_id) DO UPDATE
	SET mon_plan_id = EXCLUDED.mon_plan_id,
		mon_loc_id = EXCLUDED.mon_loc_id;

	---------------------------------- UNIT & STACK PIPE DATA --------------------------------------------

	-- STACK_PIPE --
	INSERT INTO camdecmps.stack_pipe (stack_pipe_id, fac_id, stack_name, active_date, retire_date, userid, add_date, update_date)
	SELECT stack_pipe_id, fac_id, stack_name, active_date, retire_date, userid, add_date, update_date
	FROM camdecmpswks.stack_pipe
	WHERE stack_pipe_id = ANY(stackPipeIds)
	ON CONFLICT (stack_pipe_id) DO UPDATE
	SET fac_id = EXCLUDED.fac_id,
		stack_name = EXCLUDED.stack_name,
		active_date = EXCLUDED.active_date,
		retire_date = EXCLUDED.retire_date,
		userid = EXCLUDED.userid,
		add_date = EXCLUDED.add_date,
		update_date = EXCLUDED.update_date;

-- UNIT --
INSERT INTO camd.unit (unit_id, fac_id, unitid, unit_description, indian_country_ind, stateid, boiler_sequence_number, comm_op_date, comm_op_date_cd, comr_op_date, comr_op_date_cd, source_category_cd, naics_cd, no_active_gen_ind, non_load_based_ind, actual_90th_op_date, moved_ind, userid, add_date, update_date)
SELECT unit_id, fac_id, unitid, unit_description, indian_country_ind, stateid, boiler_sequence_number, comm_op_date, comm_op_date_cd, comr_op_date, comr_op_date_cd, source_category_cd, naics_cd, no_active_gen_ind, non_load_based_ind, actual_90th_op_date, moved_ind, userid, add_date, update_date
FROM camdecmpswks.unit
WHERE unit_id = ANY(unitIds)
    ON CONFLICT (unit_id) DO UPDATE
         SET fac_id = EXCLUDED.fac_id,
         unitid = EXCLUDED.unitid,
         unit_description = EXCLUDED.unit_description,
         indian_country_ind = EXCLUDED.indian_country_ind,
         stateid = EXCLUDED.stateid,
         boiler_sequence_number = EXCLUDED.boiler_sequence_number,
         comm_op_date = EXCLUDED.comm_op_date,
         comm_op_date_cd = EXCLUDED.comm_op_date_cd,
         comr_op_date = EXCLUDED.comr_op_date,
         comr_op_date_cd = EXCLUDED.comr_op_date_cd,
         source_category_cd = EXCLUDED.source_category_cd,
         naics_cd = EXCLUDED.naics_cd,
         no_active_gen_ind = EXCLUDED.no_active_gen_ind,
         non_load_based_ind = EXCLUDED.non_load_based_ind,
         actual_90th_op_date = EXCLUDED.actual_90th_op_date,
         moved_ind = EXCLUDED.moved_ind,
         userid = EXCLUDED.userid,
         add_date = EXCLUDED.add_date,
         update_date = EXCLUDED.update_date;

	-- UNIT_CAPACITY --
	INSERT INTO camdecmps.unit_capacity (unit_cap_id, unit_id, begin_date, end_date, max_hi_capacity, userid, add_date, update_date)
	SELECT unit_cap_id, unit_id, begin_date, end_date, max_hi_capacity, userid, add_date, update_date
	FROM camdecmpswks.unit_capacity
	WHERE unit_id = ANY (unitIds)
	ON CONFLICT (unit_cap_id) DO UPDATE
	SET unit_id = EXCLUDED.unit_id,
		begin_date = EXCLUDED.begin_date,
		end_date = EXCLUDED.end_date,
		max_hi_capacity = EXCLUDED.max_hi_capacity,
		userid = EXCLUDED.userid,
		add_date = EXCLUDED.add_date,
		update_date = EXCLUDED.update_date;

	-- UNIT_CONTROL --
	INSERT INTO camdecmps.unit_control (ctl_id, unit_id, control_cd, ce_param, install_date, opt_date, orig_cd, seas_cd, retire_date, indicator_cd, userid, add_date, update_date)
	SELECT ctl_id, unit_id, control_cd, ce_param, install_date, opt_date, orig_cd, seas_cd, retire_date, indicator_cd, userid, add_date, update_date
	FROM camdecmpswks.unit_control
	WHERE unit_id = ANY (unitIds)
	ON CONFLICT (ctl_id) DO UPDATE
	SET unit_id = EXCLUDED.unit_id,
		control_cd = EXCLUDED.control_cd,
		ce_param = EXCLUDED.ce_param,
		install_date = EXCLUDED.install_date,
		opt_date = EXCLUDED.opt_date,
		orig_cd = EXCLUDED.orig_cd,
		seas_cd = EXCLUDED.seas_cd,
		retire_date = EXCLUDED.retire_date,
		indicator_cd = EXCLUDED.indicator_cd,
		userid = EXCLUDED.userid,
		add_date = EXCLUDED.add_date,
		update_date = EXCLUDED.update_date;

	-- UNIT_FUEL --
	INSERT INTO camdecmps.unit_fuel (uf_id, unit_id, fuel_type, begin_date, end_date, indicator_cd, act_or_proj_cd, ozone_seas_ind, dem_so2, dem_gcv, sulfur_content, userid, add_date, update_date)
	SELECT uf_id, unit_id, fuel_type, begin_date, end_date, indicator_cd, act_or_proj_cd, ozone_seas_ind, dem_so2, dem_gcv, sulfur_content, userid, add_date, update_date
	FROM camdecmpswks.unit_fuel
	WHERE unit_id = ANY (unitIds)
	ON CONFLICT (uf_id) DO UPDATE
	SET unit_id = EXCLUDED.unit_id,
		fuel_type = EXCLUDED.fuel_type,
		begin_date = EXCLUDED.begin_date,
		end_date = EXCLUDED.end_date,
		indicator_cd = EXCLUDED.indicator_cd,
		act_or_proj_cd = EXCLUDED.act_or_proj_cd,
		ozone_seas_ind = EXCLUDED.ozone_seas_ind,
		dem_so2 = EXCLUDED.dem_so2,
		dem_gcv = EXCLUDED.dem_gcv,
		sulfur_content = EXCLUDED.sulfur_content,
		userid = EXCLUDED.userid,
		add_date = EXCLUDED.add_date,
		update_date = EXCLUDED.update_date;

	-- UNIT_STACK_CONFIGURATION --
	INSERT INTO camdecmps.unit_stack_configuration (config_id, unit_id, stack_pipe_id, begin_date, end_date, userid, add_date, update_date)
	SELECT config_id, unit_id, stack_pipe_id, begin_date, end_date, userid, add_date, update_date
	FROM camdecmpswks.unit_stack_configuration
	WHERE config_id = ANY (unitStackConfigIds)
	ON CONFLICT (config_id) DO UPDATE
	SET unit_id = EXCLUDED.unit_id,
		stack_pipe_id = EXCLUDED.stack_pipe_id,
		begin_date = EXCLUDED.begin_date,
		end_date = EXCLUDED.end_date,
		userid = EXCLUDED.userid,
		add_date = EXCLUDED.add_date,
		update_date = EXCLUDED.update_date;

	---------------------------------- MONITOR PLAN DATA --------------------------------------------

	-- COMPONENT --
	INSERT INTO camdecmps.component (
		component_id, mon_loc_id, component_identifier, model_version, serial_number, manufacturer, component_type_cd, acq_cd, basis_cd, userid, add_date, update_date, hg_converter_ind
	)
	SELECT
		component_id, mon_loc_id, component_identifier, model_version, serial_number, manufacturer, component_type_cd, acq_cd, basis_cd, userid, add_date, update_date, hg_converter_ind
	FROM camdecmpswks.component
	WHERE mon_loc_id = ANY(monLocIds)
	ON CONFLICT (component_id) DO UPDATE
	SET mon_loc_id = EXCLUDED.mon_loc_id,
		component_identifier = EXCLUDED.component_identifier,
		model_version = EXCLUDED.model_version,
		serial_number = EXCLUDED.serial_number,
		manufacturer = EXCLUDED.manufacturer,
		component_type_cd = EXCLUDED.component_type_cd,
		acq_cd = EXCLUDED.acq_cd,
		basis_cd = EXCLUDED.basis_cd,
		userid = EXCLUDED.userid,
		add_date = EXCLUDED.add_date,
		update_date = EXCLUDED.update_date,
		hg_converter_ind = EXCLUDED.hg_converter_ind;

	-- ANALYZER_RANGE --
	INSERT INTO camdecmps.analyzer_range (
		analyzer_range_id, component_id, analyzer_range_cd, dual_range_ind, begin_date, begin_hour, end_date, end_hour, userid, add_date, update_date
	)
	SELECT
		ar.analyzer_range_id, ar.component_id, ar.analyzer_range_cd, ar.dual_range_ind, ar.begin_date, ar.begin_hour, ar.end_date, ar.end_hour, ar.userid, ar.add_date, ar.update_date
	FROM camdecmpswks.analyzer_range AS ar
	JOIN camdecmpswks.component AS c
		ON ar.component_id = c.component_id
	WHERE c.mon_loc_id = ANY(monLocIds)
	ON CONFLICT (analyzer_range_id) DO UPDATE
	SET component_id = EXCLUDED.component_id,
		analyzer_range_cd = EXCLUDED.analyzer_range_cd,
		dual_range_ind = EXCLUDED.dual_range_ind,
		begin_date = EXCLUDED.begin_date,
		begin_hour = EXCLUDED.begin_hour,
		end_date = EXCLUDED.end_date,
		end_hour = EXCLUDED.end_hour,
		userid = EXCLUDED.userid,
		add_date = EXCLUDED.add_date,
		update_date = EXCLUDED.update_date;

	-- MATS_METHOD_DATA --
	INSERT INTO camdecmps.mats_method_data (
		mats_method_data_id, mon_loc_id, mats_method_cd, mats_method_parameter_cd, begin_date, begin_hour, end_date, end_hour, userid, add_date, update_date
	)
	SELECT
		mats_method_data_id, mon_loc_id, mats_method_cd, mats_method_parameter_cd, begin_date, begin_hour, end_date, end_hour, userid, add_date, update_date
	FROM camdecmpswks.mats_method_data
	WHERE mon_loc_id = ANY(monLocIds)
	ON CONFLICT (mats_method_data_id) DO UPDATE
	SET mon_loc_id = EXCLUDED.mon_loc_id,
		mats_method_cd = EXCLUDED.mats_method_cd,
		mats_method_parameter_cd = EXCLUDED.mats_method_parameter_cd,
		begin_date = EXCLUDED.begin_date,
		begin_hour = EXCLUDED.begin_hour,
		end_date = EXCLUDED.end_date,
		end_hour = EXCLUDED.end_hour,
		userid = EXCLUDED.userid,
		add_date = EXCLUDED.add_date,
		update_date = EXCLUDED.update_date;

	-- MONITOR_DEFAULT --
	INSERT INTO camdecmps.monitor_default (
		mondef_id, mon_loc_id, parameter_cd, begin_date, begin_hour, end_date, end_hour, operating_condition_cd, default_value, default_purpose_cd, default_source_cd, fuel_cd, group_id, userid, add_date, update_date, default_uom_cd
	)
	SELECT
		mondef_id, mon_loc_id, parameter_cd, begin_date, begin_hour, end_date, end_hour, operating_condition_cd, default_value, default_purpose_cd, default_source_cd, fuel_cd, group_id, userid, add_date, update_date, default_uom_cd
	FROM camdecmpswks.monitor_default
	WHERE mon_loc_id = ANY(monLocIds)
	ON CONFLICT (mondef_id) DO UPDATE
	SET mon_loc_id = EXCLUDED.mon_loc_id,
		parameter_cd = EXCLUDED.parameter_cd,
		begin_date = EXCLUDED.begin_date,
		begin_hour = EXCLUDED.begin_hour,
		end_date = EXCLUDED.end_date,
		end_hour = EXCLUDED.end_hour,
		operating_condition_cd = EXCLUDED.operating_condition_cd,
		default_value = EXCLUDED.default_value,
		default_purpose_cd = EXCLUDED.default_purpose_cd,
		default_source_cd = EXCLUDED.default_source_cd,
		fuel_cd = EXCLUDED.fuel_cd,
		group_id = EXCLUDED.group_id,
		userid = EXCLUDED.userid,
		add_date = EXCLUDED.add_date,
		update_date = EXCLUDED.update_date,
		default_uom_cd = EXCLUDED.default_uom_cd;

	-- MONITOR_FORMULA --
	INSERT INTO camdecmps.monitor_formula (
		mon_form_id, mon_loc_id, parameter_cd, equation_cd, formula_identifier, begin_date, begin_hour, end_date, end_hour, formula_equation, userid, add_date, update_date
	)
	SELECT
		mon_form_id, mon_loc_id, parameter_cd, equation_cd, formula_identifier, begin_date, begin_hour, end_date, end_hour, formula_equation, userid, add_date, update_date
	FROM camdecmpswks.monitor_formula
	WHERE mon_loc_id = ANY(monLocIds)
	ON CONFLICT (mon_form_id) DO UPDATE
	SET mon_loc_id = EXCLUDED.mon_loc_id,
		parameter_cd = EXCLUDED.parameter_cd,
		equation_cd = EXCLUDED.equation_cd,
		formula_identifier = EXCLUDED.formula_identifier,
		begin_date = EXCLUDED.begin_date,
		begin_hour = EXCLUDED.begin_hour,
		end_date = EXCLUDED.end_date,
		end_hour = EXCLUDED.end_hour,
		formula_equation = EXCLUDED.formula_equation,
		userid = EXCLUDED.userid,
		add_date = EXCLUDED.add_date,
		update_date = EXCLUDED.update_date;

		-- MONITOR_LOAD --
	INSERT INTO camdecmps.monitor_load (
		load_id, mon_loc_id, load_analysis_date, begin_date, begin_hour, end_date, end_hour, max_load_value, second_normal_ind, up_op_boundary, low_op_boundary, normal_level_cd, second_level_cd, userid, add_date, update_date, max_load_uom_cd
	)
	SELECT
		load_id, mon_loc_id, load_analysis_date, begin_date, begin_hour, end_date, end_hour, max_load_value, second_normal_ind, up_op_boundary, low_op_boundary, normal_level_cd, second_level_cd, userid, add_date, update_date, max_load_uom_cd
	FROM camdecmpswks.monitor_load
	WHERE mon_loc_id = ANY(monLocIds)
	ON CONFLICT (load_id) DO UPDATE
	SET mon_loc_id = EXCLUDED.mon_loc_id,
		load_analysis_date = EXCLUDED.load_analysis_date,
		begin_date = EXCLUDED.begin_date,
		begin_hour = EXCLUDED.begin_hour,
		end_date = EXCLUDED.end_date,
		end_hour = EXCLUDED.end_hour,
		max_load_value = EXCLUDED.max_load_value,
		second_normal_ind = EXCLUDED.second_normal_ind,
		up_op_boundary = EXCLUDED.up_op_boundary,
		low_op_boundary = EXCLUDED.low_op_boundary,
		normal_level_cd = EXCLUDED.normal_level_cd,
		second_level_cd = EXCLUDED.second_level_cd,
		userid = EXCLUDED.userid,
		add_date = EXCLUDED.add_date,
		update_date = EXCLUDED.update_date,
		max_load_uom_cd = EXCLUDED.max_load_uom_cd;

	-- MONITOR_LOCATION_ATTRIBUTE --
	INSERT INTO camdecmps.monitor_location_attribute (
		mon_loc_attrib_id, mon_loc_id, grd_elevation, duct_ind, bypass_ind, cross_area_flow, cross_area_exit, begin_date, end_date, stack_height, shape_cd, material_cd, add_date, update_date, userid
	)
	SELECT
		mon_loc_attrib_id, mon_loc_id, grd_elevation, duct_ind, bypass_ind, cross_area_flow, cross_area_exit, begin_date, end_date, stack_height, shape_cd, material_cd, add_date, update_date, userid
	FROM camdecmpswks.monitor_location_attribute
	WHERE mon_loc_id = ANY(monLocIds)
	ON CONFLICT (mon_loc_attrib_id) DO UPDATE
	SET mon_loc_id = EXCLUDED.mon_loc_id,
		grd_elevation = EXCLUDED.grd_elevation,
		duct_ind = EXCLUDED.duct_ind,
		bypass_ind = EXCLUDED.bypass_ind,
		cross_area_flow = EXCLUDED.cross_area_flow,
		cross_area_exit = EXCLUDED.cross_area_exit,
		begin_date = EXCLUDED.begin_date,
		end_date = EXCLUDED.end_date,
		stack_height = EXCLUDED.stack_height,
		shape_cd = EXCLUDED.shape_cd,
		material_cd = EXCLUDED.material_cd,
		add_date = EXCLUDED.add_date,
		update_date = EXCLUDED.update_date,
		userid = EXCLUDED.userid;

	-- MONITOR_METHOD --
	INSERT INTO camdecmps.monitor_method (
		mon_method_id, mon_loc_id, parameter_cd, sub_data_cd, bypass_approach_cd, method_cd, begin_date, begin_hour, end_date, end_hour, userid, add_date, update_date
	)
	SELECT
		mon_method_id, mon_loc_id, parameter_cd, sub_data_cd, bypass_approach_cd, method_cd, begin_date, begin_hour, end_date, end_hour, userid, add_date, update_date
	FROM camdecmpswks.monitor_method
	WHERE mon_loc_id = ANY(monLocIds)
	ON CONFLICT (mon_method_id) DO UPDATE
	SET mon_loc_id = EXCLUDED.mon_loc_id,
		parameter_cd = EXCLUDED.parameter_cd,
		sub_data_cd = EXCLUDED.sub_data_cd,
		bypass_approach_cd = EXCLUDED.bypass_approach_cd,
		method_cd = EXCLUDED.method_cd,
		begin_date = EXCLUDED.begin_date,
		begin_hour = EXCLUDED.begin_hour,
		end_date = EXCLUDED.end_date,
		end_hour = EXCLUDED.end_hour,
		userid = EXCLUDED.userid,
		add_date = EXCLUDED.add_date,
		update_date = EXCLUDED.update_date;

	-- MONITOR_QUALIFICATION --
	INSERT INTO camdecmps.monitor_qualification (
		mon_qual_id, mon_loc_id, qual_type_cd, begin_date, end_date, userid, add_date, update_date
	)
	SELECT
		mon_qual_id, mon_loc_id, qual_type_cd, begin_date, end_date, userid, add_date, update_date
	FROM camdecmpswks.monitor_qualification
	WHERE mon_loc_id = ANY(monLocIds)
	ON CONFLICT (mon_qual_id) DO UPDATE
	SET mon_loc_id = EXCLUDED.mon_loc_id,
		qual_type_cd = EXCLUDED.qual_type_cd,
		begin_date = EXCLUDED.begin_date,
		end_date = EXCLUDED.end_date,
		userid = EXCLUDED.userid,
		add_date = EXCLUDED.add_date,
		update_date = EXCLUDED.update_date;

	-- MONITOR_QUALIFICATION_LEE --
	INSERT INTO camdecmps.monitor_qualification_lee (
		mon_qual_lee_id, mon_qual_id, qual_test_date, parameter_cd, qual_lee_test_type_cd, potential_annual_emissions, applicable_emission_standard, emission_standard_uom, emission_standard_pct, userid, add_date, update_date
	)
	SELECT
		mq.mon_qual_lee_id, mq.mon_qual_id, mq.qual_test_date, mq.parameter_cd, mq.qual_lee_test_type_cd, mq.potential_annual_emissions, mq.applicable_emission_standard, mq.emission_standard_uom, mq.emission_standard_pct, mq.userid, mq.add_date, mq.update_date
	FROM camdecmpswks.monitor_qualification_lee AS mq
	JOIN camdecmpswks.monitor_qualification AS mql
		ON mq.mon_qual_id = mql.mon_qual_id
	WHERE mql.mon_loc_id = ANY(monLocIds)
	ON CONFLICT (mon_qual_lee_id) DO UPDATE
	SET mon_qual_id = EXCLUDED.mon_qual_id,
		qual_test_date = EXCLUDED.qual_test_date,
		parameter_cd = EXCLUDED.parameter_cd,
		qual_lee_test_type_cd = EXCLUDED.qual_lee_test_type_cd,
		potential_annual_emissions = EXCLUDED.potential_annual_emissions,
		applicable_emission_standard = EXCLUDED.applicable_emission_standard,
		emission_standard_uom = EXCLUDED.emission_standard_uom,
		emission_standard_pct = EXCLUDED.emission_standard_pct,
		userid = EXCLUDED.userid,
		add_date = EXCLUDED.add_date,
		update_date = EXCLUDED.update_date;

	-- MONITOR_QUALIFICATION_LME --
	INSERT INTO camdecmps.monitor_qualification_lme (
		mon_lme_id, mon_qual_id, qual_data_year, so2_tons, nox_tons, op_hours, userid, add_date, update_date
	)
	SELECT
		mq.mon_lme_id, mq.mon_qual_id, mq.qual_data_year, mq.so2_tons, mq.nox_tons, mq.op_hours, mq.userid, mq.add_date, mq.update_date
	FROM camdecmpswks.monitor_qualification_lme AS mq
	JOIN camdecmpswks.monitor_qualification AS mql
		ON mq.mon_qual_id = mql.mon_qual_id
	WHERE mql.mon_loc_id = ANY(monLocIds)
	ON CONFLICT (mon_lme_id) DO UPDATE
	SET mon_qual_id = EXCLUDED.mon_qual_id,
		qual_data_year = EXCLUDED.qual_data_year,
		so2_tons = EXCLUDED.so2_tons,
		nox_tons = EXCLUDED.nox_tons,
		op_hours = EXCLUDED.op_hours,
		userid = EXCLUDED.userid,
		add_date = EXCLUDED.add_date,
		update_date = EXCLUDED.update_date;

	-- MONITOR_QUALIFICATION_PCT --
	INSERT INTO camdecmps.monitor_qualification_pct (
		mon_pct_id, mon_qual_id, qual_year, yr1_qual_data_type_cd, yr1_qual_data_year, yr1_pct_value, yr2_qual_data_type_cd, yr2_qual_data_year, yr2_pct_value, yr3_qual_data_type_cd, yr3_qual_data_year, yr3_pct_value, avg_pct_value, userid, add_date, update_date
	)
	SELECT
		mq.mon_pct_id, mq.mon_qual_id, mq.qual_year, mq.yr1_qual_data_type_cd, mq.yr1_qual_data_year, mq.yr1_pct_value, mq.yr2_qual_data_type_cd, mq.yr2_qual_data_year, mq.yr2_pct_value, mq.yr3_qual_data_type_cd, mq.yr3_qual_data_year, mq.yr3_pct_value, mq.avg_pct_value, mq.userid, mq.add_date, mq.update_date
	FROM camdecmpswks.monitor_qualification_pct AS mq
	JOIN camdecmpswks.monitor_qualification AS mql
		ON mq.mon_qual_id = mql.mon_qual_id
	WHERE mql.mon_loc_id = ANY(monLocIds)
	ON CONFLICT (mon_pct_id) DO UPDATE
	SET mon_qual_id = EXCLUDED.mon_qual_id,
		qual_year = EXCLUDED.qual_year,
		yr1_qual_data_type_cd = EXCLUDED.yr1_qual_data_type_cd,
		yr1_qual_data_year = EXCLUDED.yr1_qual_data_year,
		yr1_pct_value = EXCLUDED.yr1_pct_value,
		yr2_qual_data_type_cd = EXCLUDED.yr2_qual_data_type_cd,
		yr2_qual_data_year = EXCLUDED.yr2_qual_data_year,
		yr2_pct_value = EXCLUDED.yr2_pct_value,
		yr3_qual_data_type_cd = EXCLUDED.yr3_qual_data_type_cd,
		yr3_qual_data_year = EXCLUDED.yr3_qual_data_year,
		yr3_pct_value = EXCLUDED.yr3_pct_value,
		avg_pct_value = EXCLUDED.avg_pct_value,
		userid = EXCLUDED.userid,
		add_date = EXCLUDED.add_date,
		update_date = EXCLUDED.update_date;

	-- MONITOR_QUALIFICATION_CPMS --
	INSERT INTO camdecmps.monitor_qualification_cpms (
		mon_qual_cpms_id, mon_qual_id, qual_data_year, stack_test_number, operating_limit, userid, add_date, update_date
	)
	SELECT
		mq.mon_qual_cpms_id, mq.mon_qual_id, mq.qual_data_year, mq.stack_test_number, mq.operating_limit, mq.userid, mq.add_date, mq.update_date
	FROM camdecmpswks.monitor_qualification_cpms AS mq
	JOIN camdecmpswks.monitor_qualification AS mql
		ON mq.mon_qual_id = mql.mon_qual_id
	WHERE mql.mon_loc_id = ANY(monLocIds)
	ON CONFLICT (mon_qual_cpms_id) DO UPDATE
	SET mon_qual_id = EXCLUDED.mon_qual_id,
		qual_data_year = EXCLUDED.qual_data_year,
		stack_test_number = EXCLUDED.stack_test_number,
		operating_limit = EXCLUDED.operating_limit,
		userid = EXCLUDED.userid,
		add_date = EXCLUDED.add_date,
		update_date = EXCLUDED.update_date;

	-- MONITOR_SPAN --
	INSERT INTO camdecmps.monitor_span (
		span_id, mon_loc_id, mpc_value, mec_value, mpf_value, max_low_range, span_value, full_scale_range, begin_date, begin_hour, end_date, end_hour, default_high_range, flow_span_value, flow_full_scale_range, component_type_cd, span_scale_cd, span_method_cd, userid, add_date, update_date, span_uom_cd
	)
	SELECT
		span_id, mon_loc_id, mpc_value, mec_value, mpf_value, max_low_range, span_value, full_scale_range, begin_date, begin_hour, end_date, end_hour, default_high_range, flow_span_value, flow_full_scale_range, component_type_cd, span_scale_cd, span_method_cd, userid, add_date, update_date, span_uom_cd
	FROM camdecmpswks.monitor_span
	WHERE mon_loc_id = ANY(monLocIds)
	ON CONFLICT (span_id) DO UPDATE
	SET mon_loc_id = EXCLUDED.mon_loc_id,
		mpc_value = EXCLUDED.mpc_value,
		mec_value = EXCLUDED.mec_value,
		mpf_value = EXCLUDED.mpf_value,
		max_low_range = EXCLUDED.max_low_range,
		span_value = EXCLUDED.span_value,
		full_scale_range = EXCLUDED.full_scale_range,
		begin_date = EXCLUDED.begin_date,
		begin_hour = EXCLUDED.begin_hour,
		end_date = EXCLUDED.end_date,
		end_hour = EXCLUDED.end_hour,
		default_high_range = EXCLUDED.default_high_range,
		flow_span_value = EXCLUDED.flow_span_value,
		flow_full_scale_range = EXCLUDED.flow_full_scale_range,
		component_type_cd = EXCLUDED.component_type_cd,
		span_scale_cd = EXCLUDED.span_scale_cd,
		span_method_cd = EXCLUDED.span_method_cd,
		userid = EXCLUDED.userid,
		add_date = EXCLUDED.add_date,
		update_date = EXCLUDED.update_date,
		span_uom_cd = EXCLUDED.span_uom_cd;

	-- MONITOR_SYSTEM --
	INSERT INTO camdecmps.monitor_system (
		mon_sys_id, mon_loc_id, system_identifier, sys_type_cd, begin_date, begin_hour, end_date, end_hour, sys_designation_cd, fuel_cd, userid, add_date, update_date
	)
	SELECT
		mon_sys_id, mon_loc_id, system_identifier, sys_type_cd, begin_date, begin_hour, end_date, end_hour, sys_designation_cd, fuel_cd, userid, add_date, update_date
	FROM camdecmpswks.monitor_system
	WHERE mon_loc_id = ANY(monLocIds)
	ON CONFLICT (mon_sys_id) DO UPDATE
	SET mon_loc_id = EXCLUDED.mon_loc_id,
		system_identifier = EXCLUDED.system_identifier,
		sys_type_cd = EXCLUDED.sys_type_cd,
		begin_date = EXCLUDED.begin_date,
		begin_hour = EXCLUDED.begin_hour,
		end_date = EXCLUDED.end_date,
		end_hour = EXCLUDED.end_hour,
		sys_designation_cd = EXCLUDED.sys_designation_cd,
		fuel_cd = EXCLUDED.fuel_cd,
		userid = EXCLUDED.userid,
		add_date = EXCLUDED.add_date,
		update_date = EXCLUDED.update_date;

	-- MONITOR_SYSTEM_COMPONENT --
	INSERT INTO camdecmps.monitor_system_component (
		mon_sys_comp_id, mon_sys_id, component_id, begin_hour, begin_date, end_date, end_hour, userid, add_date, update_date
	)
	SELECT
		msc.mon_sys_comp_id, msc.mon_sys_id, msc.component_id, msc.begin_hour, msc.begin_date, msc.end_date, msc.end_hour, msc.userid, msc.add_date, msc.update_date
	FROM camdecmpswks.monitor_system_component AS msc
	JOIN camdecmpswks.monitor_system AS ms
		ON msc.mon_sys_id = ms.mon_sys_id
	WHERE ms.mon_loc_id = ANY(monLocIds)
	ON CONFLICT (mon_sys_comp_id) DO UPDATE
	SET mon_sys_id = EXCLUDED.mon_sys_id,
		component_id = EXCLUDED.component_id,
		begin_hour = EXCLUDED.begin_hour,
		begin_date = EXCLUDED.begin_date,
		end_date = EXCLUDED.end_date,
		end_hour = EXCLUDED.end_hour,
		userid = EXCLUDED.userid,
		add_date = EXCLUDED.add_date,
		update_date = EXCLUDED.update_date;

	-- RECT_DUCT_WAF --
	INSERT INTO camdecmps.rect_duct_waf (
		rect_duct_waf_data_id, mon_loc_id, waf_determined_date, waf_effective_date, waf_effective_hour, waf_method_cd, waf_value, num_test_runs, num_traverse_points_waf, num_test_ports, num_traverse_points_ref, duct_width, duct_depth, end_date, end_hour, add_date, update_date, userid
	)
	SELECT
		rect_duct_waf_data_id, mon_loc_id, waf_determined_date, waf_effective_date, waf_effective_hour, waf_method_cd, waf_value, num_test_runs, num_traverse_points_waf, num_test_ports, num_traverse_points_ref, duct_width, duct_depth, end_date, end_hour, add_date, update_date, userid
	FROM camdecmpswks.rect_duct_waf
	WHERE mon_loc_id = ANY(monLocIds)
	ON CONFLICT (rect_duct_waf_data_id) DO UPDATE
	SET mon_loc_id = EXCLUDED.mon_loc_id,
		waf_determined_date = EXCLUDED.waf_determined_date,
		waf_effective_date = EXCLUDED.waf_effective_date,
		waf_effective_hour = EXCLUDED.waf_effective_hour,
		waf_method_cd = EXCLUDED.waf_method_cd,
		waf_value = EXCLUDED.waf_value,
		num_test_runs = EXCLUDED.num_test_runs,
		num_traverse_points_waf = EXCLUDED.num_traverse_points_waf,
		num_test_ports = EXCLUDED.num_test_ports,
		num_traverse_points_ref = EXCLUDED.num_traverse_points_ref,
		duct_width = EXCLUDED.duct_width,
		duct_depth = EXCLUDED.duct_depth,
		end_date = EXCLUDED.end_date,
		end_hour = EXCLUDED.end_hour,
		add_date = EXCLUDED.add_date,
		update_date = EXCLUDED.update_date,
		userid = EXCLUDED.userid;

	-- SYSTEM_FUEL_FLOW --
	INSERT INTO camdecmps.system_fuel_flow (
		sys_fuel_id, mon_sys_id, max_rate, begin_date, begin_hour, end_date, end_hour, max_rate_source_cd, userid, add_date, update_date, sys_fuel_uom_cd
	)
	SELECT
		sff.sys_fuel_id, sff.mon_sys_id, sff.max_rate, sff.begin_date, sff.begin_hour, sff.end_date, sff.end_hour, sff.max_rate_source_cd, sff.userid, sff.add_date, sff.update_date, sff.sys_fuel_uom_cd
	FROM camdecmpswks.system_fuel_flow AS sff
	JOIN camdecmpswks.monitor_system AS ms
		ON sff.mon_sys_id = ms.mon_sys_id
	WHERE ms.mon_loc_id = ANY(monLocIds)
	ON CONFLICT (sys_fuel_id) DO UPDATE
	SET mon_sys_id = EXCLUDED.mon_sys_id,
		max_rate = EXCLUDED.max_rate,
		begin_date = EXCLUDED.begin_date,
		begin_hour = EXCLUDED.begin_hour,
		end_date = EXCLUDED.end_date,
		end_hour = EXCLUDED.end_hour,
		max_rate_source_cd = EXCLUDED.max_rate_source_cd,
		userid = EXCLUDED.userid,
		add_date = EXCLUDED.add_date,
		update_date = EXCLUDED.update_date,
		sys_fuel_uom_cd = EXCLUDED.sys_fuel_uom_cd;

END;
$BODY$;
