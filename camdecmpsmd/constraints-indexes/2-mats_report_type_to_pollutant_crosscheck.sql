ALTER TABLE IF EXISTS camdecmpsmd.mats_report_type_to_pollutant_crosscheck
    ADD CONSTRAINT pk_mats_report_type_to_pollutant_crosscheck PRIMARY KEY (mats_rpt_type_cd, mats_pollutant_cd),
    ADD CONSTRAINT fk_mats_report_type_to_pollutant_crosscheck_mats_report_type_code FOREIGN KEY (mats_rpt_type_cd) REFERENCES camdecmpsaux.mats_report_type_code (mats_rpt_type_cd) MATCH simple,
    ADD CONSTRAINT fk_mats_report_type_to_pollutant_crosscheck_mats_pollutant_code FOREIGN KEY (mats_pollutant_cd) REFERENCES camdecmpsaux.mats_pollutant_code (mats_pollutant_cd) MATCH simple;

