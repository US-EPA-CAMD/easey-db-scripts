CREATE TABLE IF NOT EXISTS camdecmpsaux.pdem_p75_unit_day
(
    pdem_p75_unit_day_id    bigserial,
	pdem_report_id          bigint NOT NULL,
    unit_id                 numeric(38) not null,
    op_date                 date not null,
    op_hours                numeric(4),
    op_time                 numeric(6,2),
    gload                   numeric(12,2),
    sload                   numeric(12,2),
    tload                   numeric(12,2),
    hit                     numeric(15,3),
    so2m                    numeric(15,3),
    so2r_sum                numeric(15,3),
    so2r_count              numeric(4),
    co2m                    numeric(15,3),
    co2r_sum                numeric(15,3),
    co2r_count              numeric(4),
    noxm                    numeric(15,3),
    noxr_sum                numeric(15,3),
    noxr_count              numeric(4),
    mon_plan_id             varchar(45) NOT NULL,
    rpt_period_id           numeric(38) NOT NULL,
    op_year                 numeric(4) NOT NULL,
    op_month                numeric(2) NOT NULL,
    add_date                timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    
    CONSTRAINT pdem_p75_unit_day_pk PRIMARY KEY ( pdem_p75_unit_day_id ),
    CONSTRAINT pdem_p75_unit_day_uq UNIQUE ( pdem_report_id, unit_id, op_date ),
    CONSTRAINT pdem_p75_unit_day_rpt_fk FOREIGN KEY ( pdem_report_id ) REFERENCES camdecmpsaux.pdem_report ( pdem_report_id ) ON DELETE CASCADE,
    CONSTRAINT pdem_p75_unit_day_loc_fk FOREIGN KEY ( unit_id ) REFERENCES camd.unit ( unit_id ),
    CONSTRAINT pdem_p75_unit_day_pln_fk FOREIGN KEY ( mon_plan_id ) REFERENCES camdecmps.monitor_plan ( mon_plan_id ),
    CONSTRAINT pdem_p75_unit_day_prd_fk FOREIGN KEY ( rpt_period_id ) REFERENCES camdecmpsmd.reporting_period ( rpt_period_id )
);

CREATE INDEX pdem_p75_unit_day_rpt_ix ON camdecmpsaux.pdem_p75_unit_day USING btree ( pdem_report_id );
CREATE INDEX pdem_p75_unit_day_pln_ix ON camdecmpsaux.pdem_p75_unit_day USING btree ( mon_plan_id );
CREATE INDEX pdem_p75_unit_day_plc_ix ON camdecmpsaux.pdem_p75_unit_day USING btree ( rpt_period_id, unit_id );

-- Table Comment
COMMENT ON TABLE camdecmpsaux.pdem_p75_unit_day IS 'Progam Data Emissions (PDEM) Part 75 working daily data for individual units.';

-- Column Comments
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_day.pdem_p75_unit_day_id IS 'Primary key.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_day.pdem_report_id IS 'Foreign key into the PDEM_REPORT table that identifies the latest ECMPS Program Data for an emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_day.unit_id IS 'Foreign key into the UNIT table that uniquely identifies the unit of the emissions data.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_day.op_date IS 'The operating date indicating the aggregate time period of the data in the current record.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_day.op_hours IS 'The count of operating hours for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_day.op_time IS 'The sum of operating time for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_day.gload IS 'The Gross Unit Load for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_day.sload IS 'The Steam Load for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_day.tload IS 'The Thermal Load for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_day.hit IS 'The Heat Input Total for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_day.so2m IS 'The SO2 mass value for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_day.so2r_sum IS 'The sum of SO2 rates greater than zero for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_day.so2r_count IS 'The count of SO2 rates greater than zero for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_day.co2m IS 'The CO2 mass value for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_day.co2r_sum IS 'The sum of CO2 rates greater than zero for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_day.co2r_count IS 'The count of CO2 rates greater than zero for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_day.noxm IS 'The NOX mass value for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_day.noxr_sum IS 'The sum of NOX rates greater than zero for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_day.noxr_count IS 'The count of NOX rates greater than zero for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_day.mon_plan_id IS 'Foreign key into the MONITOR_PLAN table that uniquely identifies a monitoring plan of the emissions data.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_day.rpt_period_id IS 'Foreign key into the REPORTING_PERIOD table that uniquely indentifies the reporting period of the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_day.op_year IS 'The year of the operating date of the record.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_day.op_month IS 'The month of the operating date of the record.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_day.add_date IS 'The date this record was inserted into the table.';
