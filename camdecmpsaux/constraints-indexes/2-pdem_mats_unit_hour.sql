ALTER TABLE IF EXISTS camdecmpsaux.pdem_mats_unit_hour
    ADD CONSTRAINT pdem_mats_unit_hour_pk PRIMARY KEY ( pdem_mats_unit_hour_id ),
    ADD CONSTRAINT pdem_mats_unit_hour_uq UNIQUE ( pdem_report_id, unit_id, op_date, op_hour ),
    ADD CONSTRAINT pdem_mats_unit_hour_rpt_fk FOREIGN KEY ( pdem_report_id ) REFERENCES camdecmpsaux.pdem_report ( pdem_report_id ) ON DELETE CASCADE,
    ADD CONSTRAINT pdem_mats_unit_hour_loc_fk FOREIGN KEY ( unit_id ) REFERENCES camd.unit ( unit_id ),
    ADD CONSTRAINT pdem_mats_unit_hour_pln_fk FOREIGN KEY ( mon_plan_id ) REFERENCES camdecmps.monitor_plan ( mon_plan_id ),
    ADD CONSTRAINT pdem_mats_unit_hour_prd_fk FOREIGN KEY ( rpt_period_id ) REFERENCES camdecmpsmd.reporting_period ( rpt_period_id ),
    ADD CONSTRAINT pdem_mats_unit_hour_meas_hc_fk FOREIGN KEY ( hcl_hour_measure_cd ) REFERENCES camdecmpsmd.hour_measure_code ( hour_measure_cd ),
    ADD CONSTRAINT pdem_mats_unit_hour_meas_hf_fk FOREIGN KEY ( hf_hour_measure_cd ) REFERENCES camdecmpsmd.hour_measure_code ( hour_measure_cd ),
    ADD CONSTRAINT pdem_mats_unit_hour_meas_hg_fk FOREIGN KEY ( hg_hour_measure_cd ) REFERENCES camdecmpsmd.hour_measure_code ( hour_measure_cd ),
    ADD CONSTRAINT pdem_mats_unit_hour_meas_hi_fk FOREIGN KEY ( hit_hour_measure_cd ) REFERENCES camdecmpsmd.hour_measure_code ( hour_measure_cd );

CREATE INDEX pdem_mats_unit_hour_rpt_ix ON camdecmpsaux.pdem_mats_unit_hour USING btree ( pdem_report_id );
CREATE INDEX pdem_mats_unit_hour_pln_ix ON camdecmpsaux.pdem_mats_unit_hour USING btree ( mon_plan_id );
CREATE INDEX pdem_mats_unit_hour_plc_ix ON camdecmpsaux.pdem_mats_unit_hour USING btree ( rpt_period_id, unit_id );
