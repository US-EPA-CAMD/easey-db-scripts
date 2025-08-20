UPDATE camdecmpsmd.mats_report_type_code
SET mats_rpt_type_description = 'Absolute Correlation Audit'
WHERE mats_rpt_type_cd = 'ACA';

UPDATE camdecmpsmd.mats_report_type_code
SET mats_rpt_type_description = 'Sample Volume Audit'
WHERE mats_rpt_type_cd = 'SVA';
