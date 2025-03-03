CREATE TABLE IF NOT EXISTS camdecmpsaux.pdem_p75_unit_quarter
(
    pdem_p75_unit_quarter_id    bigserial,
	pdem_report_id              bigint NOT NULL,
    unit_id                     numeric(38) NOT NULL,
    op_year                     numeric(4) NOT NULL,
    op_quarter                  numeric(1) NOT NULL,
    op_hours                    numeric(4),
    op_time                     numeric(6,2),
    gload                       numeric(12,2),
    sload                       numeric(12,2),
    tload                       numeric(12,2),
    hit                         numeric(15,3),
    so2m                        numeric(15,3),
    so2r_sum                    numeric(15,3),
    so2r_count                  numeric(4),
    co2m                        numeric(15,3),
    co2r_sum                    numeric(15,3),
    co2r_count                  numeric(4),
    noxm                        numeric(15,3),
    noxr_sum                    numeric(15,3),
    noxr_count                  numeric(4),
    reported_months             numeric(1) NOT NULL,
    mon_plan_id                 varchar(45) NOT NULL,
    rpt_period_id               numeric(38) NOT NULL,
    add_date                    timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    
    CONSTRAINT pdem_p75_unit_quarter_pk PRIMARY KEY ( pdem_p75_unit_quarter_id ),
    CONSTRAINT pdem_p75_unit_quarter_uq UNIQUE ( pdem_report_id, unit_id, op_year, op_quarter ),
    CONSTRAINT pdem_p75_unit_quarter_rpt_fk FOREIGN KEY ( pdem_report_id ) REFERENCES camdecmpsaux.pdem_report ( pdem_report_id ) ON DELETE CASCADE,
    CONSTRAINT pdem_p75_unit_quarter_loc_fk FOREIGN KEY ( unit_id ) REFERENCES camd.unit ( unit_id ),
    CONSTRAINT pdem_p75_unit_quarter_pln_fk FOREIGN KEY ( mon_plan_id ) REFERENCES camdecmps.monitor_plan ( mon_plan_id ),
    CONSTRAINT pdem_p75_unit_quarter_prd_fk FOREIGN KEY ( rpt_period_id ) REFERENCES camdecmpsmd.reporting_period ( rpt_period_id )
);

CREATE INDEX pdem_p75_unit_quarter_rpt_ix ON camdecmpsaux.pdem_p75_unit_quarter USING btree ( pdem_report_id );
CREATE INDEX pdem_p75_unit_quarter_pln_ix ON camdecmpsaux.pdem_p75_unit_quarter USING btree ( mon_plan_id );
CREATE INDEX pdem_p75_unit_quarter_plc_ix ON camdecmpsaux.pdem_p75_unit_quarter USING btree ( rpt_period_id, unit_id );

-- Table Comment
COMMENT ON TABLE camdecmpsaux.pdem_p75_unit_quarter IS 'Progam Data Emissions (PDEM) Part 75 working quarterly data for individual units.';

-- Column Comments
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_quarter.pdem_p75_unit_quarter_id IS 'Primary key.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_quarter.pdem_report_id IS 'Foreign key into the PDEM_REPORT table that identifies the latest ECMPS Program Data for an emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_quarter.unit_id IS 'Foreign key into the UNIT table that uniquely identifies the unit of the emissions data.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_quarter.op_year IS 'The operating year of the record.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_quarter.op_quarter IS 'The operating quarter of the record.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_quarter.op_hours IS 'The count of operating hours for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_quarter.op_time IS 'The sum of operating time for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_quarter.gload IS 'The Gross Unit Load for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_quarter.sload IS 'The Steam Load for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_quarter.tload IS 'The Thermal Load for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_quarter.hit IS 'The Heat Input Total for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_quarter.so2m IS 'The SO2 mass value for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_quarter.so2r_sum IS 'The sum of SO2 rates greater than zero for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_quarter.so2r_count IS 'The count of SO2 rates greater than zero for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_quarter.co2m IS 'The CO2 mass value for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_quarter.co2r_sum IS 'The sum of CO2 rates greater than zero for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_quarter.co2r_count IS 'The count of CO2 rates greater than zero for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_quarter.noxm IS 'The NOX mass value for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_quarter.noxr_sum IS 'The sum of NOX rates greater than zero for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_quarter.noxr_count IS 'The count of NOX rates greater than zero for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_quarter.reported_months IS 'The numeric of months reported in the emissions data.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_quarter.mon_plan_id IS 'Foreign key into the MONITOR_PLAN table that uniquely identifies a monitoring plan of the emissions data.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_quarter.rpt_period_id IS 'Foreign key into the REPORTING_PERIOD table that uniquely indentifies the reporting period of the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_p75_unit_quarter.add_date IS 'The date this record was inserted into the table.';
