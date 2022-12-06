DO $$
DECLARE
	datasetCode text = 'MATSHG';
	datatableId integer;
BEGIN
	INSERT INTO camdaux.dataset(dataset_cd, template_cd, display_name, sort_order, no_results_msg)
	VALUES(datasetCode, 'EMVIEW', 'MATS HG View', 15, 'MATS HG data does not exist for the specified monitor plan and reporting period.');

	/***** DATATABLE 1 *****/
	INSERT INTO camdaux.datatable(dataset_cd, table_order, display_name, sql_statement, no_results_msg_override)
	VALUES(datasetCode, 1, 'MATS HG', null, null)
	RETURNING datatable_id INTO datatableId;

	/***** COLUMNS *****/
	INSERT INTO camdaux.datacolumn(datatable_id, column_order, name, alias, display_name)
	VALUES
		(datatableId, 1, 'date_hour', 'dateHour', 'Date/Hr'),
		(datatableId, 2, 'op_time', 'opTime', 'Op. Time'),
		(datatableId, 3, 'mats_load', 'matsLoad', 'MATS Load'),
		(datatableId, 4, 'mats_startup_shutdown', 'matsStartupShutdown', 'MATS Startup Shutdown'),
		(datatableId, 5, 'hg_conc_value', 'hgConcValue', 'HG Conc. Value'),
		(datatableId, 6, 'hg_conc_system_id', 'hgConcSystemIdentifier', 'HG Conc. System Id'),
		(datatableId, 7, 'hg_conc_sys_type', 'hgConcSystemType', 'HG Conc. System Type'),
		(datatableId, 8, 'hg_conc_modc_cd', 'hgConcMODCCode', 'HG Conc. MODC'),
		(datatableId, 9, 'hg_conc_pma', 'hgConcPMA', 'HG Conc. PMA'),
		(datatableId, 10, 'sampling_train_comp_id1', 'samplingTrainCompID1', 'Sampling Train Component Id 1'),
		(datatableId, 11, 'gas_flowmeter_reading1', 'gasFlowmeterReading1', 'Gas Flow Meter Reading 1'),
		(datatableId, 12, 'ratio_stack_gas_flow_rate1', 'ratioStackGASFlowRate1', 'Ratio Stack Gas Flow Rate 1'),
		(datatableId, 13, 'sampling_train_comp_id2', 'samplingTrainCompID2', 'Sampling Train Component Id 2'),
		(datatableId, 14, 'gas_flowmeter_reading2', 'gasFlowmeterReading2', 'Gas Flow Meter Reading 2'),
		(datatableId, 15, 'ratio_stack_gas_flow_rate2', 'ratioStackGASFlowRate2', 'Ratio Stack Gas Flow Rate 2'),
		(datatableId, 16, 'flow_rate', 'flowRate', 'Flow Rate'),
		(datatableId, 17, 'flow_modc', 'flowMODC', 'Flow MODC'),
		(datatableId, 18, 'flow_pma', 'flowPMA', 'Flow PMA'),
		(datatableId, 19, 'rpt_pct_diluent', 'rptPCTDiluent', 'Rptd. % Diluent'),
		(datatableId, 20, 'diluent_parameter', 'diluentParameter', 'Diluent Parameter'),
		(datatableId, 21, 'calc_pct_diluent', 'calcPCTDiluent', '% Diluent Used in Calc.'),
		(datatableId, 22, 'diluent_modc', 'diluentMODC', 'Diluent MODC'),
		(datatableId, 23, 'calc_pct_h2o', 'calcPCTH2O', '% H2O used in Calc.'),
		(datatableId, 24, 'h2o_source', 'h2oSource', 'Source of H2O Value'),
		(datatableId, 25, 'f_factor', 'fFactor', 'F-Factor'),
		(datatableId, 26, 'hg_formula_cd', 'hgFormulaCode', 'HG Formula Code'),
		(datatableId, 27, 'rpt_hg_rate', 'rptHGRate', 'Rpt. HG Rate'),
		(datatableId, 28, 'calc_hg_rate', 'calcHGRate', 'Calc. HG Rate'),
		(datatableId, 29, 'hg_uom', 'hgUOM', 'HG UOM'),
		(datatableId, 30, 'hg_modc_cd', 'hgMODCCode', 'HG MODC'),
		(datatableId, 31, 'error_codes', 'errorCodes', 'Hourly Errors');
END $$;