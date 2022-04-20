-- Table: camdecmpsmd.report_freq_code

-- DROP TABLE camdecmpsmd.report_freq_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.report_freq_code
(
    report_freq_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    report_freq_cd_description character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT pk_reporting_freq_code PRIMARY KEY (report_freq_cd)
);

COMMENT ON TABLE camdecmpsmd.report_freq_code
    IS 'Reporting Frequency lookup table.';

COMMENT ON COLUMN camdecmpsmd.report_freq_code.report_freq_cd
    IS 'Code/frequency on which data are submitted. ';

COMMENT ON COLUMN camdecmpsmd.report_freq_code.report_freq_cd_description
    IS 'Description of lookup code. ';