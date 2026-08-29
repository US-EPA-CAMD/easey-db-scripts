ALTER TABLE IF EXISTS camdecmpsaux.pdem_p75_monitor_hour
    ADD CONSTRAINT pdem_p75_monitor_hour_pk PRIMARY KEY ( pdem_p75_mon_hour_id ),
    ADD CONSTRAINT pdem_p75_monitor_hour_uq UNIQUE ( pdem_report_id, mon_loc_id, op_date, op_hour ),
    ADD CONSTRAINT pdem_p75_monitor_hour_rpt_fk FOREIGN KEY ( pdem_report_id ) REFERENCES camdecmpsaux.pdem_report ( pdem_report_id ) ON DELETE CASCADE,
    ADD CONSTRAINT pdem_p75_monitor_hour_loc_fk FOREIGN KEY ( mon_loc_id ) REFERENCES camdecmps.monitor_location ( mon_loc_id ),
    ADD CONSTRAINT pdem_p75_monitor_hour_pln_fk FOREIGN KEY ( mon_plan_id ) REFERENCES camdecmps.monitor_plan ( mon_plan_id ),
    ADD CONSTRAINT pdem_p75_monitor_hour_prd_fk FOREIGN KEY ( rpt_period_id ) REFERENCES camdecmpsmd.reporting_period ( rpt_period_id ),
    ADD CONSTRAINT pdem_p75_monitor_hour_meas_cm_fk FOREIGN KEY ( co2m_hour_measure_cd ) REFERENCES camdecmpsmd.hour_measure_code ( hour_measure_cd ),
    ADD CONSTRAINT pdem_p75_monitor_hour_meas_cr_fk FOREIGN KEY ( co2r_hour_measure_cd ) REFERENCES camdecmpsmd.hour_measure_code ( hour_measure_cd ),
    ADD CONSTRAINT pdem_p75_monitor_hour_meas_ht_fk FOREIGN KEY ( hit_hour_measure_cd ) REFERENCES camdecmpsmd.hour_measure_code ( hour_measure_cd ),
    ADD CONSTRAINT pdem_p75_monitor_hour_meas_nm_fk FOREIGN KEY ( noxm_hour_measure_cd ) REFERENCES camdecmpsmd.hour_measure_code ( hour_measure_cd ),
    ADD CONSTRAINT pdem_p75_monitor_hour_meas_nr_fk FOREIGN KEY ( noxr_hour_measure_cd ) REFERENCES camdecmpsmd.hour_measure_code ( hour_measure_cd ),
    ADD CONSTRAINT pdem_p75_monitor_hour_meas_sm_fk FOREIGN KEY ( so2m_hour_measure_cd ) REFERENCES camdecmpsmd.hour_measure_code ( hour_measure_cd ),
    ADD CONSTRAINT pdem_p75_monitor_hour_meas_sr_fk FOREIGN KEY ( so2r_hour_measure_cd ) REFERENCES camdecmpsmd.hour_measure_code ( hour_measure_cd );

CREATE INDEX pdem_p75_monitor_hour_rpt_ix ON camdecmpsaux.pdem_p75_monitor_hour USING btree ( pdem_report_id );
CREATE INDEX pdem_p75_monitor_hour_pln_ix ON camdecmpsaux.pdem_p75_monitor_hour USING btree ( mon_plan_id );
CREATE INDEX pdem_p75_monitor_hour_plc_ix ON camdecmpsaux.pdem_p75_monitor_hour USING btree ( rpt_period_id, mon_loc_id );
