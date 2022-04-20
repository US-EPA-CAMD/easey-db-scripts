-- Table: camdecmpsmd.monitoring_plan_status_code

-- DROP TABLE camdecmpsmd.monitoring_plan_status_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.monitoring_plan_status_code
(
    mon_plan_status_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    mon_plan_status_cd_description character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT pk_monitoring_plan_status_code PRIMARY KEY (mon_plan_status_cd)
);

COMMENT ON TABLE camdecmpsmd.monitoring_plan_status_code
    IS 'Status of monitoring plan.';

COMMENT ON COLUMN camdecmpsmd.monitoring_plan_status_code.mon_plan_status_cd
    IS 'Code used to identify the monitoring plan status. ';

COMMENT ON COLUMN camdecmpsmd.monitoring_plan_status_code.mon_plan_status_cd_description
    IS 'Description of lookup code. ';