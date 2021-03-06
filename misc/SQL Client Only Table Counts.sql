select 'configuration_type_code' as tablename, count(*) from [ECMPS_2021-11-03].dbo.configuration_type_code union all
select 'unit_program_exemption' as tablename, count(*) from [ECMPS_2021-11-03].dbo.unit_program_exemption union all
select 'program_parameter' as tablename, count(*) from [ECMPS_2021-11-03].[host].program_parameter union all
select 'parameter_group_override_code' as tablename, count(*) from [ECMPS_AUX_2021-11-03].[Chet].parameter_group_override_code union all
select 'check_applicability_code' as tablename, count(*) from [ECMPS_AUX_2021-11-03].dbo.check_applicability_code union all
select 'check_catalog' as tablename, count(*) from [ECMPS_AUX_2021-11-03].dbo.check_catalog union all
select 'check_catalog_result' as tablename, count(*) from [ECMPS_AUX_2021-11-03].dbo.check_catalog_result union all
select 'check_catalog_parameter' as tablename, count(*) from [ECMPS_AUX_2021-11-03].dbo.check_catalog_parameter union all
select 'check_catalog_plugin' as tablename, count(*) from [ECMPS_AUX_2021-11-03].dbo.check_catalog_plugin union all
select 'check_data_type_code' as tablename, count(*) from [ECMPS_AUX_2021-11-03].dbo.check_data_type_code union all
select 'check_operator_code' as tablename, count(*) from [ECMPS_AUX_2021-11-03].dbo.check_operator_code union all
select 'check_operator_data_type' as tablename, count(*) from [ECMPS_AUX_2021-11-03].dbo.check_operator_data_type union all
select 'check_parameter_code' as tablename, count(*) from [ECMPS_AUX_2021-11-03].dbo.check_parameter_code union all
select 'check_parameter_type_code' as tablename, count(*) from [ECMPS_AUX_2021-11-03].dbo.check_parameter_type_code union all
select 'check_parameter_usage_code' as tablename, count(*) from [ECMPS_AUX_2021-11-03].dbo.check_parameter_usage_code union all
select 'check_status_code' as tablename, count(*) from [ECMPS_AUX_2021-11-03].dbo.check_status_code union all
select 'check_type_code' as tablename, count(*) from [ECMPS_AUX_2021-11-03].dbo.check_type_code union all
select 'cross_check_catalog' as tablename, count(*) from [ECMPS_AUX_2021-11-03].dbo.cross_check_catalog union all
select 'cross_check_catalog_value' as tablename, count(*) from [ECMPS_AUX_2021-11-03].dbo.cross_check_catalog_value union all
select 'eval_score_code' as tablename, count(*) from [ECMPS_AUX_2021-11-03].dbo.eval_score_code union all
select 'plugin_type_code' as tablename, count(*) from [ECMPS_AUX_2021-11-03].dbo.plugin_type_code union all
select 'response_catalog' as tablename, count(*) from [ECMPS_AUX_2021-11-03].dbo.response_catalog union all
select 'response_type_code' as tablename, count(*) from [ECMPS_AUX_2021-11-03].dbo.response_type_code union all
select 'rule_check' as tablename, count(*) from [ECMPS_AUX_2021-11-03].dbo.rule_check union all
select 'rule_check_condition' as tablename, count(*) from [ECMPS_AUX_2021-11-03].dbo.rule_check_condition union all
select 'system_parameter' as tablename, count(*) from [ECMPS_AUX_2021-11-03].dbo.system_parameter union all
select 'system_parameter_name' as tablename, count(*) from [ECMPS_AUX_2021-11-03].dbo.system_parameter_name union all
--select 'test_scenario_catalog' as tablename, count(*) from dbo.test_scenario_catalog union all
--select 'test_scenario_status_code' as tablename, count(*) from dbo.test_scenario_status_code union all
select 'process_group_code' as tablename, count(*) from [ECMPS_AUX_2021-11-03].[Lookup].process_group_code union all
select 'parameter_method_to_formula' as tablename, count(*) from [ECMPS_2021-11-03].[CrossCheck].parameter_method_to_formula
order by tablename
