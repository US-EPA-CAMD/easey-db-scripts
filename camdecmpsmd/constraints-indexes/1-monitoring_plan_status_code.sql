ALTER TABLE IF EXISTS camdecmpsmd.monitoring_plan_status_code
    ADD CONSTRAINT pk_monitoring_plan_status_code PRIMARY KEY (mon_plan_status_cd),
    ADD CONSTRAINT uq_monitoring_plan_status_code_description UNIQUE (mon_plan_status_cd_description);
