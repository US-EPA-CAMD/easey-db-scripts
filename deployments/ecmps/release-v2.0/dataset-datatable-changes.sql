ALTER TABLE IF EXISTS camdaux.dataset
	ADD COLUMN IF NOT EXISTS group_cd character varying(7),
	ADD CONSTRAINT ck_group_cd CHECK(
		group_cd = ANY(ARRAY['MDM', 'MDMREL', 'REPORT', 'EMVIEW'])
	);

UPDATE camdaux.dataset SET group_cd =
	CASE
		WHEN template_cd = 'SUMRPT' OR template_cd = 'DTLRPT' THEN 'REPORT'
		ELSE template_cd
	END;

ALTER TABLE IF EXISTS camdaux.dataset
	ALTER COLUMN group_cd SET NOT NULL;


CREATE TABLE IF NOT EXISTS camdaux.template_code(
	template_cd character varying(25) NOT NULL,
	group_cd character varying(25) NOT NULL,
	template_type character varying(25) NOT NULL,
	display_name character varying(1000) NOT NULL,
	CONSTRAINT pk_template_code PRIMARY KEY (template_cd),
	CONSTRAINT ck_template_type CHECK(
		template_type = ANY(ARRAY['1COLTBL', '2COLTBL', '3COLTBL', 'DEFAULT'])
	)
);

INSERT INTO camdaux.template_code(template_cd, group_cd, template_type, display_name)
VALUES
	('EVAL',				'EVAL',		'DEFAULT',	'Evaluation Results'),
	('QCE',					'QCE',		'DEFAULT',	'QA Certification Events Details'),
	('FACINFO',			'ALL',		'1COLTBL',	'Facility Information'),
	('RPTFREQ',			'MPP',		'DEFAULT',	'Reporting Frequency'),
	('LOCATTR',			'MPP',		'DEFAULT',	'Location Attributes'),
	('UNTOPCAP',		'MPP',		'DEFAULT',	'Unit Operation/Capacity'),
	('UNTPRG',			'MPP',		'DEFAULT',	'Unit Programs'),
	('UNTFUEL',			'MPP',		'DEFAULT',	'Unit Fuels'),
	('MONMTHD',			'MPP',		'DEFAULT',	'Monitoring Methods'),
	('MONSYSCMP',		'MPP',		'DEFAULT',	'Monitoring System/Analytical Components'),
	('ANLYZRNG',		'MPP',		'DEFAULT',	'Analyzer Ranges'),
	('SYSFUELFLW',	'MPP',		'DEFAULT',	'System Fuel Flows'),
	('MONFORM',			'MPP',		'DEFAULT',	'Emissions Formula'),
	('MONSPAN',			'MPP',		'DEFAULT',	'Span Values'),
	('MONLOAD',			'MPP',		'DEFAULT',	'Unit/Stack Loads & Operating Levels'),
	('MONDFLT',			'MPP',		'DEFAULT',	'Monitoring Defaults'),
	('QUALPCT',			'MPP',		'DEFAULT',	'Qualification Percentages'),
	('QUALLME',			'MPP',		'DEFAULT',	'LME Qualifications'),
	('QUALLEE',			'MPP',		'DEFAULT',	'LEE Qualifications'),
	('LINSUM',			'LINE',		'3COLTBL',	'Linearity Check'),
	('LINGAS',			'LINE',		'DEFAULT',	'Protocol Gas'),
	('LINSTAT',			'LINE',		'DEFAULT',	'Summary Statistics'),
	('LININJ',			'LINE', 	'DEFAULT',	'Injection Statistics'),
	('CYCSUM',			'CYCLE',	'3COLTBL',	'Cycle Time Test'),
	('CYCINJ',			'CYCLE', 	'DEFAULT',	'Injections');

ALTER TABLE IF EXISTS camdaux.datatable
	ALTER COLUMN display_name DROP NOT NULL,
	DROP CONSTRAINT uq_datatable,
	ADD CONSTRAINT uq_datatable UNIQUE (dataset_cd, group_cd, table_order),
	ADD COLUMN IF NOT EXISTS template_cd character varying(25),
	DROP CONSTRAINT fk_datatable_template_code,
	ADD CONSTRAINT fk_datatable_template_code FOREIGN KEY (template_cd)
		REFERENCES camdaux.template_code (template_cd) MATCH SIMPLE;