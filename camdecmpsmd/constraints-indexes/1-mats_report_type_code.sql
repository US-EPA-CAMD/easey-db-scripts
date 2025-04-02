ALTER TABLE IF EXISTS camdecmpsmd.mats_report_type_code
    ADD CONSTRAINT pk_mats_report_type_code PRIMARY KEY (mats_rpt_type_cd),
    ADD CONSTRAINT uq_mats_report_type_code_1 UNIQUE (mats_rpt_type_description),
    ADD CONSTRAINT uq_mats_report_type_code_2 UNIQUE (metadata_rpt_type_cd);

