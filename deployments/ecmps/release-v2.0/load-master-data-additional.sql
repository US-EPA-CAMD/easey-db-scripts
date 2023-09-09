INSERT INTO camdecmpsmd.analytical_principle_code(
  analytical_principle_cd, analytical_principle_cd_description
) VALUES
  ('BA', 'Beta Attenuation'),
  ('ELS', 'Extractive Light Scatter'), 
  ('ILS', 'In-stack Light Scatter'), 
  ('LS', 'Light Scintillation'), 
  ('MAD', 'Mass Accumulation Detection');
-----------------------------------------------------------------------
INSERT INTO camdecmpsmd.control_equip_param_code(
	control_equip_param_cd, control_equip_param_desc
) VALUES ('PM', 'Particulate Matter');
-----------------------------------------------------------------------
UPDATE camdecmpsmd.control_code
SET control_equip_param_cd = null
WHERE control_cd IN ('B', 'ESP', 'HESP', 'WESP');
-----------------------------------------------------------------------
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
INSERT INTO camdecmpsmd.component_type_code(
	component_type_cd, component_type_cd_description, span_indicator, parameter_cd
)	VALUES ('CPM', 'PM Continuous Parametric Monitor', null, 'PMCO');

UPDATE camdecmpsmd.component_type_code
SET component_type_cd_description = 'Particulate Matter',
  span_indicator = null,
  parameter_cd = 'PMC'
WHERE component_type_cd = 'PM';
-----------------------------------------------------------------------
INSERT INTO camdecmpsmd.method_code(
	method_cd, method_cd_description
) VALUES ('CPMS', 'PM Continuous Parametric Monitoring System');
-----------------------------------------------------------------------
INSERT INTO camdecmpsmd.qual_type_code(
	qual_type_cd, qual_type_cd_description, qual_type_group_cd
)	VALUES ('CPMS', 'PM CPMS System operating limit', 'CPMS');
-----------------------------------------------------------------------
INSERT INTO camdecmpsmd.system_type_code(
	sys_type_cd, sys_type_description, parameter_cd
) VALUES ('CPMS', 'Particulate Matter Parametric Monitoring System', 'PMCO');
-----------------------------------------------------------------------
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
    ('MISC', 'Miscellaneous', 1)
/*
    ('PS11CT', 'PS11 Correlation Test', 3),
    ('RCA', 'Response Correlation Audit', 3),
    ('RRA', 'Relative Response Audit', 3),
    ('SVA', 'Sample Volume Audit', 3),
    ('ACA', 'Absolute Correlation Audit', 3),
    ('3ME', 'Three-Level Measurement Error', 3),
    ('IBI', 'Beam Intensity Test', 2),
    ('RAA', 'Relative Accuracy Audit', 3),
    ('CGA', 'Cylinder Gas Audit', 3),
    ('QGA', 'Quarterly Gas Audit', 2),
    ('DSA', 'Dynamic Spiking Audit', 3)
*/
;
-----------------------------------------------------------------------
INSERT INTO camdecmpsaux.email_template(
  template_id, template_location, template_subject
) VALUES
  (150,	'templates/submission-confirmation.html', 'Submission Completion Notification')
  (151,	'templates/submission-151.html', 'Emissions Submission Reminder'),
  (152,	'templates/submission-152.html', 'Emissions Submission Reminder'),
  (155,	'templates/submission-155.html', 'Submission Window Open for Quarterly Emission File'),
  (156,	'templates/submission-156.html', 'Outstanding Emissions Submission Reminder'),
  (157,	'templates/submission-157.html', 'Emissions Resubmission Window Closed');
-----------------------------------------------------------------------
