-- Table: camdaux.template_code

-- DROP TABLE IF EXISTS camdaux.template_code;

CREATE TABLE IF NOT EXISTS camdaux.template_code
(
    template_cd character varying(25) COLLATE pg_catalog."default" NOT NULL,
    group_cd character varying(25) COLLATE pg_catalog."default" NOT NULL,
    template_type character varying(25) COLLATE pg_catalog."default" NOT NULL,
    display_name character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_template_code PRIMARY KEY (template_cd),
    CONSTRAINT ck_template_type CHECK (template_type::text = ANY (ARRAY['1COLTBL'::text, '2COLTBL'::text, '3COLTBL'::text, 'DEFAULT'::text]))
);

INSERT INTO camdaux.template_code(template_cd, group_cd, template_type, display_name)
VALUES
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
	('CYCINJ',		'CYCLE', 	'DEFAULT',	'Injections');
