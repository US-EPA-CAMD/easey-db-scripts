ALTER TABLE IF EXISTS camdecmps.monitor_qualification_pct
    ADD CONSTRAINT pk_monitor_qualification_pct PRIMARY KEY (mon_pct_id),
    ADD CONSTRAINT fk_monitor_qualification_pct_monitor_qualification FOREIGN KEY (mon_qual_id)
        REFERENCES camdecmps.monitor_qualification (mon_qual_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_monitor_qualification_pct_qual_data_type_code_yr1 FOREIGN KEY (yr1_qual_data_type_cd)
        REFERENCES camdecmpsmd.qual_data_type_code (qual_data_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_qualification_pct_qual_data_type_code_yr2 FOREIGN KEY (yr2_qual_data_type_cd)
        REFERENCES camdecmpsmd.qual_data_type_code (qual_data_type_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_monitor_qualification_pct_qual_data_type_code_yr3 FOREIGN KEY (yr3_qual_data_type_cd)
        REFERENCES camdecmpsmd.qual_data_type_code (qual_data_type_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_monitor_qualification_pct_mon_qual_id
    ON camdecmps.monitor_qualification_pct USING btree
    (mon_qual_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_qualification_pct_yr1_qual_data_type_cd
    ON camdecmps.monitor_qualification_pct USING btree
    (yr1_qual_data_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_qualification_pct_yr2_qual_data_type_cd
    ON camdecmps.monitor_qualification_pct USING btree
    (yr2_qual_data_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_monitor_qualification_pct_yr3_qual_data_type_cd
    ON camdecmps.monitor_qualification_pct USING btree
    (yr3_qual_data_type_cd COLLATE pg_catalog."default" ASC NULLS LAST);
