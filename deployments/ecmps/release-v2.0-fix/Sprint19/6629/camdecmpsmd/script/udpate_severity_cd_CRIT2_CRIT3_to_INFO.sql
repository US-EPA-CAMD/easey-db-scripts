UPDATE camdecmpsmd.severity_code
SET eval_status_cd = 'INFO'
WHERE severity_cd IN ('CRIT2', 'CRIT3');
