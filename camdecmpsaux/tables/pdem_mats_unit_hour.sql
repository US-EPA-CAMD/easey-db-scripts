CREATE TABLE IF NOT EXISTS camdecmpsaux.pdem_mats_unit_hour
(
    pdem_mats_unit_hour_id  bigserial,
	pdem_report_id          bigint NOT NULL,
    unit_id                 numeric(38) NOT NULL,
    op_date                 date NOT NULL,
    op_hour                 numeric(2) NOT NULL,
    op_time                 numeric(3,2),
    gload                   numeric(8,2),
    sload                   numeric(8,2),
    tload                   numeric(8,2),
    hit                     numeric(15,3),
    hit_hour_measure_cd     varchar(7),
    hg_rate_eo              numeric(22,10),
    hg_rate_hi              numeric(22,10),
    hg_mass                 numeric(22,10),
    hg_hour_measure_cd      varchar(7),
    hcl_rate_eo             numeric(22,10),
    hcl_rate_hi             numeric(22,10),
    hcl_mass                numeric(22,10),
    hcl_hour_measure_cd     varchar(7),
    hf_rate_eo              numeric(22,10),
    hf_rate_hi              numeric(22,10),
    hf_mass                 numeric(22,10),
    hf_hour_measure_cd      varchar(7),
    mon_plan_id             varchar(45) NOT NULL,
    rpt_period_id           numeric(38) NOT NULL,
    op_year                 numeric(4) NOT NULL,
    userid                  varchar(160) NOT NULL,
    add_date                timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    
    CONSTRAINT pdem_mats_unit_hour_pk PRIMARY KEY ( pdem_mats_unit_hour_id ),
    CONSTRAINT pdem_mats_unit_hour_uq UNIQUE ( unit_id, op_date, op_hour ),
    CONSTRAINT pdem_mats_unit_hour_rpt_fk FOREIGN KEY ( pdem_report_id ) REFERENCES camdecmpsaux.pdem_report ( pdem_report_id ) ON DELETE CASCADE,
    CONSTRAINT pdem_mats_unit_hour_loc_fk FOREIGN KEY ( unit_id ) REFERENCES camd.unit ( unit_id ),
    CONSTRAINT pdem_mats_unit_hour_pln_fk FOREIGN KEY ( mon_plan_id ) REFERENCES camdecmps.monitor_plan ( mon_plan_id ),
    CONSTRAINT pdem_mats_unit_hour_prd_fk FOREIGN KEY ( rpt_period_id ) REFERENCES camdecmpsmd.reporting_period ( rpt_period_id ),
    CONSTRAINT pdem_mats_unit_hour_meas_hc_fk FOREIGN KEY ( hcl_hour_measure_cd ) REFERENCES camdecmpsmd.hour_measure_code ( hour_measure_cd ),
    CONSTRAINT pdem_mats_unit_hour_meas_hf_fk FOREIGN KEY ( hf_hour_measure_cd ) REFERENCES camdecmpsmd.hour_measure_code ( hour_measure_cd ),
    CONSTRAINT pdem_mats_unit_hour_meas_hg_fk FOREIGN KEY ( hg_hour_measure_cd ) REFERENCES camdecmpsmd.hour_measure_code ( hour_measure_cd ),
    CONSTRAINT pdem_mats_unit_hour_meas_hi_fk FOREIGN KEY ( hit_hour_measure_cd ) REFERENCES camdecmpsmd.hour_measure_code ( hour_measure_cd )
);

CREATE INDEX pdem_mats_unit_hour_rpt_ix ON camdecmpsaux.pdem_mats_unit_hour USING btree ( pdem_report_id );
CREATE INDEX pdem_mats_unit_hour_pln_ix ON camdecmpsaux.pdem_mats_unit_hour USING btree ( mon_plan_id );
CREATE INDEX pdem_mats_unit_hour_plc_ix ON camdecmpsaux.pdem_mats_unit_hour USING btree ( rpt_period_id, unit_id );

-- Table Comment
COMMENT ON TABLE camdecmpsaux.pdem_mats_unit_hour IS 'Progam Data Emissions (PDEM) MATS working hourly data for individual units.';
  
-- Column Comments
COMMENT ON COLUMN camdecmpsaux.pdem_mats_unit_hour.pdem_mats_unit_hour_id IS 'Primary key.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_unit_hour.pdem_report_id IS 'Foreign key into the PDEM_REPORT table that identifies the latest ECMPS Program Data for an emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_unit_hour.unit_id IS 'Foreign key into the UNIT table that uniquely identifies the unit of the emissions data.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_unit_hour.op_date IS 'The operating date indicating the aggregate time period of the data in the current record.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_unit_hour.op_hour IS 'The operating hour indicating the aggregate time period of the data in the current record.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_unit_hour.op_time IS 'The sum of operating time for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_unit_hour.gload IS 'The Gross Unit Load for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_unit_hour.sload IS 'The Steam Load for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_unit_hour.tload IS 'The Thermal Load for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_unit_hour.hit IS 'The Heat Input Total for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_unit_hour.hit_hour_measure_cd IS 'Foreign key into the HOUR_MEASURE_CODE table that uniquely indentifies the hour measure code for Heat Input Total.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_unit_hour.hg_rate_eo IS 'The Electrical Output Based Mercury (Hg) Rate for the time period. (lb/GWh)';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_unit_hour.hg_rate_hi IS 'The Heat Input Based Mercury (Hg) Rate for the time period. (lb/TBtu)';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_unit_hour.hg_mass IS 'The Mercury (Hg) Mass for the time period. (lb)';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_unit_hour.hg_hour_measure_cd IS 'Foreign key into the HOUR_MEASURE_CODE table that uniquely identifies the hour measure code for this parameter.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_unit_hour.hcl_rate_eo IS 'The Electrical Output Based Hydrogen Chloride (HCl) Rate for the time period. (lb/MWh)';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_unit_hour.hcl_rate_hi IS 'The Heat Input Based Hydrogen Chloride (HCl) Rate for the time period. (lb/mmBtu)';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_unit_hour.hcl_mass IS 'The Hydrogen Chloride (HCl) Mass for the time period. (lb)';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_unit_hour.hcl_hour_measure_cd IS 'Foreign key into the HOUR_MEASURE_CODE table that uniquely identifies the hour measure code for this parameter.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_unit_hour.hf_rate_eo IS 'The Electrical Output Based Hydrogen Fluoride (HF) Rate for the time period. (lb/MWh)';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_unit_hour.hf_rate_hi IS 'The Heat Input Based Hydrogen Fluoride (HF) Rate for the time period. (lb/mmBtu)';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_unit_hour.hf_mass IS 'The Hydrogen Fluoride (HF) Mass for the time period. (lb)';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_unit_hour.hf_hour_measure_cd IS 'Foreign key into the HOUR_MEASURE_CODE table that uniquely identifies the hour measure code for this parameter.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_unit_hour.mon_plan_id IS 'Foreign key into the MONITOR_PLAN table that uniquely identifies a monitoring plan of the emissions data.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_unit_hour.rpt_period_id IS 'Foreign key into the REPORTING_PERIOD table that uniquely indentifies the reporting period of the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_unit_hour.op_year IS 'The year of the operating date of the record.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_unit_hour.userid IS 'The user id of the submitter of the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_unit_hour.add_date IS 'The date this record was inserted into the table.';
