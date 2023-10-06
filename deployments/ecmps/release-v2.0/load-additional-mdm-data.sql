DELETE FROM camdecmpsmd.hourly_type_code WHERE hourly_type_cd = 'COMBINE';
INSERT INTO camdecmpsmd.hourly_type_code ( hourly_type_cd, hourly_type_description )
VALUES ( 'COMBINE', 'Both Monitored and Derived Hourly' );
-----------------------------------------------------------------------
TRUNCATE camdmd.account_type_group_code;
INSERT INTO camdmd.account_type_group_code(account_type_group_cd, account_type_group_description)
VALUES
    ('FACLTY', 'Facility'),
    ('GENERAL', 'General'),
    ('OVERDF', 'Overdraft'),
    ('RESERVE', 'Reserve'),
    ('RETIRE', 'Surrender'),
    ('SHOLD', 'State Holding'),
    ('UNIT', 'Unit');
-----------------------------------------------------------------------
TRUNCATE camdmd.unit_type_group_code;
INSERT INTO camdmd.unit_type_group_code(unit_type_group_cd, unit_type_group_description)
VALUES
    ('B', 'Boilers'),
    ('F', 'Furnaces'),
    ('T', 'Turbines');
-----------------------------------------------------------------------
TRUNCATE camdecmpsmd.analytical_principle_code;
INSERT INTO camdecmpsmd.analytical_principle_code(
  analytical_principle_cd, analytical_principle_cd_description
) VALUES
  ('BA', 'Beta Attenuation'),
  ('ELS', 'Extractive Light Scatter'), 
  ('ILS', 'In-stack Light Scatter'), 
  ('LS', 'Light Scintillation'), 
  ('MAD', 'Mass Accumulation Detection');
-----------------------------------------------------------------------
DELETE FROM camdecmpsmd.control_equip_param_code WHERE control_equip_param_cd = 'PM';
INSERT INTO camdecmpsmd.control_equip_param_code(
	control_equip_param_cd, control_equip_param_desc
) VALUES ('PM', 'Particulate Matter');
-----------------------------------------------------------------------
UPDATE camdecmpsmd.control_code
SET control_equip_param_cd = null
WHERE control_cd IN ('B', 'ESP', 'HESP', 'WESP');
-----------------------------------------------------------------------
DELETE FROM camdecmpsmd.equation_code WHERE equation_cd IN (
  '11-3','11-16','11-34','11-37','11-46','F-18C','F-27B','C-3','C-4'
);
INSERT INTO camdecmpsmd.equation_code(
	equation_cd, equation_cd_description, moisture_ind
)	VALUES
  ('11-3', 'PS-11 Linear Equation', null),
  ('11-16', 'PS-11 Polynomial Equation', null),
  ('11-34', 'PS-11 Logarithmic Equation', null),
  ('11-37', 'PS-11 Exponential Equation', null),
  ('11-46', 'PS-11 Power Function Equation', null),
  ('F-18C', 'Total Daily Heat Input', null),
  ('F-27B', 'Daily NOx Mass', null),
  ('C-3', 'PMRE (lb/MWh wet)', null),
  ('C-4', 'PMRE (lb/MWh dry)', 1);

UPDATE camdecmpsmd.equation_code
SET equation_cd_description = 'Apportioned NOx Mass'
WHERE equation_cd = 'F-28';
-----------------------------------------------------------------------
TRUNCATE camdecmpsmd.eval_status_code;
INSERT INTO camdecmpsmd.eval_status_code(eval_status_cd, eval_status_cd_description)
VALUES
    ('EVAL', 'Needs Evaluation'),
    ('INQ', 'In Queue'),
    ('WIP', 'In Progress'),
    ('PASS', 'Passed'),
    ('ERR', 'Critical Errors'),
    ('INFO', 'Informational Message');
-----------------------------------------------------------------------
DELETE FROM camdecmpsmd.parameter_code WHERE parameter_cd IN (
  'PMC','PMCO','PMRE','PMRH','PMPMA','PMPMC'
);
INSERT INTO camdecmpsmd.parameter_code(
	parameter_cd, parameter_cd_description
) VALUES
  ('PMC', 'PM Concentration (mg/acm)'),
  ('PMCO', 'PM Concentration Parameter Output (mA, or other unit of measure)'),
  ('PMRE', 'Gross Output-Based PM Emission Rate (lb/MWh)'),
  ('PMRH', 'Heat Input-Based PM Emission Rate (lb/mmBtu)'),
  ('PMPMA', 'PM Parametric Emissions (mA)'),
  ('PMPMC', 'PM Parametric Emissions (mg/acm)');
-----------------------------------------------------------------------
DELETE FROM camdecmpsmd.component_type_code WHERE component_type_cd = 'CPM';
INSERT INTO camdecmpsmd.component_type_code(
	component_type_cd, component_type_cd_description, span_indicator, parameter_cd
)	VALUES ('CPM', 'PM Continuous Parametric Monitor', null, 'PMCO');

UPDATE camdecmpsmd.component_type_code
SET component_type_cd_description = 'Particulate Matter',
  span_indicator = null,
  parameter_cd = 'PMC'
WHERE component_type_cd = 'PM';
-----------------------------------------------------------------------
DELETE FROM camdecmpsmd.method_code WHERE method_cd = 'CPMS';
INSERT INTO camdecmpsmd.method_code(
	method_cd, method_cd_description
) VALUES ('CPMS', 'PM Continuous Parametric Monitoring System');
-----------------------------------------------------------------------
DELETE FROM camdecmpsmd.qual_type_code WHERE qual_type_cd = 'CPMS';
INSERT INTO camdecmpsmd.qual_type_code(
	qual_type_cd, qual_type_cd_description, qual_type_group_cd
)	VALUES ('CPMS', 'PM CPMS System operating limit', 'CPMS');
-----------------------------------------------------------------------
DELETE FROM camdecmpsmd.system_type_code WHERE sys_type_cd = 'CPMS';
INSERT INTO camdecmpsmd.system_type_code(
	sys_type_cd, sys_type_description, parameter_cd
) VALUES ('CPMS', 'Particulate Matter Parametric Monitoring System', 'PMCO');
-----------------------------------------------------------------------
TRUNCATE camdecmpsmd.test_type_group_code;
INSERT INTO camdecmpsmd.test_type_group_code(
  test_type_group_cd, test_type_group_cd_description, child_depth
) VALUES
    ('APPESUM', 'Appendix E Correlation Test Summary', 4),
    ('CALINJ', 'Calibration Injection', 2),
    ('CYCSUM', 'Cycle Time Summary', 3),
    ('FLC', 'Flow to Load Check', 2),
    ('FLR', 'Flow to Load Reference', 2),
    ('FFLB', 'Fuel Flow to Load Baseline', 2),
    ('FFL', 'Fuel Flow to Load', 2),
    ('FFACC', 'Fuel Flowmeter Accuracy', 2),
    ('HGL3LS', 'Hg Linearity and 3-Level Summary', 3),
    ('LINSUM', 'Linearity Summary', 3),
    ('OLOLCAL', 'Online Offline Calibration', 2),
    ('RELACC', 'Relative Accuracy', 6),
    ('TTACC', 'Transmitter Transducer Accuracy', 2),
    ('PEI', 'Primary Element Inspection', 1),
    ('LME', 'Unit Default', 3),
    ('MISC', 'Miscellaneous', 1);
-----------------------------------------------------------------------
TRUNCATE camdecmpsaux.email_template;
INSERT INTO camdecmpsaux.email_template(
  template_id, template_location, template_subject
) VALUES
  (150,	'templates/submission-confirmation.html', 'Submission Completion Notification'),
  (151,	'templates/submission-151.html', 'Emissions Submission Reminder'),
  (152,	'templates/submission-152.html', 'Emissions Submission Reminder'),
  (155,	'templates/submission-155.html', 'Submission Window Open for Quarterly Emission File'),
  (156,	'templates/submission-156.html', 'Outstanding Emissions Submission Reminder'),
  (157,	'templates/submission-157.html', 'Emissions Resubmission Window Closed');
-----------------------------------------------------------------------
TRUNCATE camdecmpswks.certification_statement;
INSERT INTO camdecmpswks.certification_statement(statement_text, prg_cd)
VALUES
	('I am authorized to make this submission on behalf of the owners and operators of the source or units for which the submission is made. I certify under penalty of law that I have personally examined, and am familiar with, the statements and information submitted in this document and all its attachments. Based on my inquiry of those individuals with primary responsibility for obtaining the information, I certify that the statements and information are to the best of my knowledge and belief true, accurate, and complete. I am aware that there are significant penalties for submitting false statements and information or omitting required statements and information, including the possibility of fine or imprisonment. If I am an agent authorized to make this electronic submission, I am signing the above certification on behalf of the authorizing designated representative or alternate designated representative, and this action is deemed to be a certification by that designated representative or alternate designated representative. The designated representative or alternate designated representative must sign (i.e., agree to) this certification statement. If you are an agent and you click on "Agree", you are not agreeing to the certification statement, but are submitting the certification statement on behalf of the designated representative or alternate designated representative who is agreeing to the certification statement. An agent is only authorized to make the electronic submission on behalf of the designated representative, not to sign (i.e., agree to) the certification statement.', null),
	('I am authorized to make this submission on behalf of the owners and operators of the source or units for which the submission is made. I certify under penalty of law that I have personally examined, and am familiar with, the statements and information submitted in this document and all its attachments. Based on my inquiry of those individuals with primary responsibility for obtaining the information, I certify that the statements and information are to the best of my knowledge and belief true, accurate, and complete. I am aware that there are significant penalties for submitting false statements and information or omitting required statements and information, including the possibility of fine or imprisonment. Except as provided in the paragraph below, If I am an agent authorized to make this electronic submission, I am signing the above certification on behalf of the authorizing designated representative or alternate designated representative, and this action is deemed to be a certification by that designated representative or alternate designated representative. If the facility for which this submission is being made has a responsible official (RO) that has registered in the CAMD Business System as an RO that attests to the truthfulness, accuracy, and completeness of the MATS-associated data submitted in each electronic quarterly report under section 7.2.5 of Appendix B to Subpart UUUUU of MATS, I certify that I am signing the above certification on behalf of the RO, and this action is deemed to be a certification by that RO covering the MATS-associated data only.', 'MATS');
-----------------------------------------------------------------------
TRUNCATE camdaux.template_code;
INSERT INTO camdaux.template_code(template_cd, group_cd, template_type, display_name)
VALUES
  ('BACKSTOP',	 	 'EM',		'DEFAULT',	'Daily Backstop'),
  ('EMALL',	 	 'EM',		'DEFAULT',	'Hourly Combined Parameters View'),
	('LTFF',	 	 'EM',		'DEFAULT',	'Long Term Fuel Flow'),
	('NSPS4TANNU',	 'EM',		'DEFAULT',	'NSPS4T Fourth Quarter'),
	('NSPS4TCOMP',	 'EM',		'DEFAULT',	'NSPS4T Compliance Period'),
	('NSPS4TSUM',	 'EM',		'DEFAULT',	'NSPS4T Summary'),
	('SAMPTRAIN',	 'EM',		'DEFAULT',	'Sampling Train'),
	('SORBTRAP',	 'EM',		'DEFAULT',	'Sorbent Trap'),
	('HRLYGFM',		 'EM',		'DEFAULT',	'Hourly Gas Flow Meter'),
	('HRLYPARAMFUEL','EM',		'DEFAULT',	'Hourly Parameter Fuel FLow'),
	('HRLYFUEL',	 'EM',		'DEFAULT',	'Hourly Fuel FLow'),
	('MATSDERHRLY',	 'EM',		'DEFAULT',	'MATS Derived Hourly Values'),
	('DERHRLY',	     'EM',		'DEFAULT',	'Derived Hourly Values'),
	('MATSMONHRLY',	 'EM',		'DEFAULT',	'MATS Monitor Hourly Values'),
	('MONITORHRLY',	 'EM',		'DEFAULT',	'Monitor Hourly Values'),
	('HRLYOP',	    'EM',		'DEFAULT',	'Hourly Operating'),
	('DLYFUEL',	    'EM',		'DEFAULT',	'Daily Fuels'),
	('DLYEM',	    'EM',		'DEFAULT',	'Daily Emissions'),
	('WKLYSYSINT',	'EM',		'DEFAULT',	'Weekly System Integrities'),
	('WKLYTESTSUM',	'EM',		'DEFAULT',	'Weekly Test Summaries'),
	('DLYCAL',	    'EM',		'DEFAULT',	'Daily Calibration'),
	('DLYTESTSUM',	'EM',		'DEFAULT',	'Daily Test Summaries'),
	('SUMVAL',		'EM',		'DEFAULT',	'Summary Values'),
	('EVAL',		'EVAL',		'DEFAULT',	'Evaluation Results'),
	('GENERR',		'EVAL',		'DEFAULT',	'General Errors'),
	('TESTERR',		'EVAL',		'DEFAULT',	'Test Data Errors'),
	('QAERR',		'EVAL',		'DEFAULT',	'QA Status Errors'),
	('TRPERR',		'EVAL',		'DEFAULT',	'Sorbent Trap Errors'),
	('HRLYERR',		'EVAL',		'DEFAULT',	'Hourly Data Errors'),
	('DLYERR',		'EVAL',		'DEFAULT',	'Daily Emissions Data Errors'),
	('SUMERR',		'EVAL',		'DEFAULT',	'Summary Data Errors'),
	('QUADTERR',	'EVAL',		'DEFAULT',	'NSPS4T Summary Data Errors'),
	('ADTERR',		'EVAL',		'DEFAULT',	'Audit Results'),
	('QCE',			'QCE',		'DEFAULT',	'QA Certification Events Details'),
	('TEE',			'TEE',		'DEFAULT',	'Test Extensions and Exemptions Details'),
	('FACINFO1C',	'ALL',		'1COLTBL',	'Facility Information'),
	('FACINFO2C',	'ALL',		'2COLTBL',	'Facility Information'),
	('FACINFO3C',	'ALL',		'3COLTBL',	'Facility Information'),	
	('RPTFREQ',		'MPP',		'DEFAULT',	'Reporting Frequency'),
	('LOCATTR',		'MPP',		'DEFAULT',	'Location Attributes'),
	('UNTOPCAP',	'MPP',		'DEFAULT',	'Unit Operation/Capacity'),
	('UNTPRG',		'MPP',		'DEFAULT',	'Unit Programs'),
	('UNTFUEL',		'MPP',		'DEFAULT',	'Unit Fuels'),
	('MONMTHD',		'MPP',		'DEFAULT',	'Monitoring Methods'),
	('MONSYSCMP',	'MPP',		'DEFAULT',	'Monitoring System/Analytical Components'),
	('ANLYZRNG',	'MPP',		'DEFAULT',	'Analyzer Ranges'),
	('SYSFUELFLW',	'MPP',		'DEFAULT',	'System Fuel Flows'),
	('MONFORM',		'MPP',		'DEFAULT',	'Emissions Formula'),
	('MONSPAN',		'MPP',		'DEFAULT',	'Span Values'),
	('MONLOAD',		'MPP',		'DEFAULT',	'Unit/Stack Loads & Operating Levels'),
	('MONDFLT',		'MPP',		'DEFAULT',	'Monitoring Defaults'),
	('QUALPCT',		'MPP',		'DEFAULT',	'Qualification Percentages'),
	('QUALLME',		'MPP',		'DEFAULT',	'LME Qualifications'),
	('QUALLEE',		'MPP',		'DEFAULT',	'LEE Qualifications'),
	('LINSUM',		'LINE',		'3COLTBL',	'Linearity Check'),
	('LINGAS',		'LINE',		'DEFAULT',	'Protocol Gas'),
	('LINSTAT',		'LINE',		'DEFAULT',	'Summary Statistics'),
	('LININJ',		'LINE', 	'DEFAULT',	'Injection Statistics'),
	('CYCSUM',		'CYCLE',	'3COLTBL',	'Cycle Time Test'),
	('CYCINJ',		'CYCLE', 	'DEFAULT',	'Injections'),
  ('HGLINSUM',	'HGLINE',	'3COLTBL',	'HG Linearity Check'),
  ('HGLINSTAT',	'HGLINE',	'DEFAULT',	'Summary Statistics'),
  ('HGLININJ',	'HGLINE', 'DEFAULT',  'Injection Statistics'),
  ('FFACCTTSUM',	'FFACCTT', '3COLTBL',  'Transmitter Transducer Test'),
  ('FFACCTTSTAT',	'FFACCTT', 'DEFAULT',  'Transmitter Transducer Statistics'),
  ('PEISUM',	'PEI', '3COLTBL',  'PEI'),
  ('APPESUM',	'APPE', '3COLTBL',  'Appendix E NOx Rate'),
  ('APPEGAS',		'APPE',		'DEFAULT',	'Protocol Gas'),
  ('APPESTAT',	'APPE',		'DEFAULT',	'Summary Statistics'),
  ('APPERUN',	'APPE',		'DEFAULT',	'Run Data')
  ('APPEOIL',	'APPE',		'DEFAULT',	'Heat Input From Oil');
-----------------------------------------------------------------------
TRUNCATE TABLE camdaux.cors_config Restart identity;

INSERT INTO camdaux.cors_config(key, value)
VALUES
    ('method', 'GET'),
    ('method', 'PUT'),
    ('method', 'POST'),
    ('method', 'DELETE'),
    ('method', 'OPTIONS'),
    ('origin', 'https://campd-dev.app.cloud.gov'),
    ('origin', 'https://ecmps-dev.app.cloud.gov'),
    ('origin', 'https://api-easey-dev.app.cloud.gov'),
    ('origin', 'https://campd-tst.app.cloud.gov'),
    ('origin', 'https://ecmps-tst.app.cloud.gov'),
    ('origin', 'https://api-easey-tst.app.cloud.gov'),
    ('origin', 'https://campd-perf.app.cloud.gov'),
    ('origin', 'https://ecmps-perf.app.cloud.gov'),
    ('origin', 'https://api-easey-perf.app.cloud.gov'),
    ('origin', 'https://campd-beta.app.cloud.gov'),
    ('origin', 'https://ecmps-beta.app.cloud.gov'),
    ('origin', 'https://api-easey-beta.app.cloud.gov'),
    ('origin', 'https://campd-stg.app.cloud.gov'),
    ('origin', 'https://ecmps-stg.app.cloud.gov'),
    ('origin', 'https://api-easey-stg.app.cloud.gov'),
    ('origin', 'https://campd.epa.gov'),
    ('origin', 'https://ecmps.epa.gov'),
    ('origin', 'https://api-easey.app.cloud.gov'),
    ('origin', 'https://cam-api.app.cloud.gov'),
    ('origin', 'https://usepa.github.io'),
    ('origin', 'https://api.epa.gov'),
    ('origin', 'https://www.epa.gov'),
    ('header', 'authorization'),
    ('header', 'content-type'),
    ('header', 'content-disposition'),
    ('header', 'x-excludable-columns'),
    ('header', 'x-field-mappings'),
    ('header', 'x-total-count'),
    ('header', 'x-api-key'),
    ('header', 'x-client-id'),    
    ('header', 'x-secret-token'),
    ('header', 'Bearer');

DELETE FROM camdecmpsaux.program_parameter WHERE prg_id = 12999 AND parameter_cd = 'PM';
INSERT INTO camdecmpsaux.program_parameter(
	prg_param_id, prg_id, parameter_cd, required_ind, begin_rpt_period_id, end_rpt_period_id, userid, add_date, update_date
) VALUES ((select max(prg_param_id)+1 from camdecmpsaux.program_parameter), 12999, 'PM', 1, 125, null, 'ERGLOAD', current_timestamp, null);

--System Type to Component Type
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Component Type'), 'CPMS', 'CPM', 'Yes');

--System Type to Fuel Group
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='System Type to Fuel Group'), 'CPMS', 'NFS', null);

--Program Parameter to Method Parameter
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Program Parameter to Method Parameter'), 'PM', 'PMRE,PMRH,PMPMA,PMPMC,MATSSUP,PM', 'PMRE (or PMRH, PMPMA, PMPMC version for heat input based method or PM Supplemental Method)');

update camdecmpsmd.system_parameter
set param_name3 = 'Mats2.0Date', param_value3 = '01/01/2024'
where sys_param_id = 12 and sys_param_name = 'MATS_RULE';

UPDATE camdecmpsmd.cross_check_catalog_value
SET value2 = 'HCLRE,HCLRH,SO2RE,SO2RH,MATSSUP,HCL'
WHERE value1 = 'HCL' and cross_chk_catalog_id = (select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Program Parameter to Method Parameter');

UPDATE camdecmpsmd.cross_check_catalog_value
SET value2 = 'HGRE,HGRH,MATSSUP,HG'
WHERE value1 = 'HG' and cross_chk_catalog_id = (select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Program Parameter to Method Parameter');

UPDATE camdecmpsmd.cross_check_catalog_value
SET value2 = 'NOX,NOXM,CALC'
WHERE value1 = 'NOX' and cross_chk_catalog_id = (select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Program Parameter to Method Parameter');