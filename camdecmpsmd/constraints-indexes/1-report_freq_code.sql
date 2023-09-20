ALTER TABLE IF EXISTS camdecmpsmd.report_freq_code
    ADD CONSTRAINT pk_report_freq_code PRIMARY KEY (report_freq_cd),
    ADD CONSTRAINT uq_report_freq_code_description UNIQUE (report_freq_cd_description);
