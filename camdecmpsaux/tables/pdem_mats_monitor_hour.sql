CREATE TABLE IF NOT EXISTS camdecmpsaux.pdem_mats_monitor_hour
(
    pdem_mats_mon_hour_id   bigserial,
	pdem_report_id          bigint NOT NULL,
    mon_loc_id              varchar(45) NOT NULL,
    op_date                 date NOT NULL,
    op_hour                 numeric(2) NOT NULL,
    op_time                 numeric(3,2),
    gload                   numeric(8,2),
    sload                   numeric(8,2),
    tload                   numeric(8,2),
    hit                     numeric(15,3),
    hit_hour_measure_cd     varchar(7),
	hit_From_Fuel_Flow      numeric(14, 4) NULL,
    hg_rate_eo              varchar(35),
    hg_rate_hi              varchar(35),
    hg_mass                 numeric(22,10),
    hg_hour_measure_cd      varchar(7),
    hcl_rate_eo             varchar(35),
    hcl_rate_hi             varchar(35),
    hcl_mass                numeric(22,10),
    hcl_hour_measure_cd     varchar(7),
    hf_rate_eo              varchar(35),
    hf_rate_hi              varchar(35),
    hf_mass                 numeric(22,10),
    hf_hour_measure_cd      varchar(7),
    mon_plan_id             varchar(45) NOT NULL,
    rpt_period_id           numeric(38) NOT NULL,
    op_year                 numeric(4) NOT NULL,
    add_date                timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Table Comment
COMMENT ON TABLE camdecmpsaux.pdem_mats_monitor_hour IS 'Progam Data Emissions (PDEM) MATS working hourly data for individual monitor locations.';

-- Column Comments
COMMENT ON COLUMN camdecmpsaux.pdem_mats_monitor_hour.pdem_mats_mon_hour_id IS 'Primary key.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_monitor_hour.pdem_report_id IS 'Foreign key into the PDEM_REPORT table that identifies the latest ECMPS Program Data for an emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_monitor_hour.mon_loc_id IS 'Foreign key into the MONITOR_LOCATION table that uniquely identifies the monitor location of the emissions data.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_monitor_hour.op_date IS 'The operating date indicating the aggregate time period of the data in the current record.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_monitor_hour.op_hour IS 'The operating hour indicating the aggregate time period of the data in the current record.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_monitor_hour.op_time IS 'The sum of operating time for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_monitor_hour.gload IS 'The Gross Unit Load for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_monitor_hour.sload IS 'The Steam Load for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_monitor_hour.tload IS 'The Thermal Load for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_monitor_hour.hit IS 'The Heat Input Total for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_monitor_hour.hit_hour_measure_cd IS 'Foreign key into the HOUR_MEASURE_CODE table that uniquely indentifies the hour measure code for Heat Input Total.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_monitor_hour.hit_From_Fuel_Flow IS 'The Heat Input Total from Fuel Flow for the indicated time period within the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_monitor_hour.hg_rate_eo IS 'The Electrical Output Based Mercury (Hg) Rate for the time period. (lb/GWh)';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_monitor_hour.hg_rate_hi IS 'The Heat Input Based Mercury (Hg) Rate for the time period. (lb/TBtu)';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_monitor_hour.hg_mass IS 'The Mercury (Hg) Mass for the time period. (lb)';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_monitor_hour.hg_hour_measure_cd IS 'Foreign key into the HOUR_MEASURE_CODE table that uniquely identifies the hour measure code for this parameter.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_monitor_hour.hcl_rate_eo IS 'The Electrical Output Based Hydrogen Chloride (HCl) Rate for the time period. (lb/MWh)';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_monitor_hour.hcl_rate_hi IS 'The Heat Input Based Hydrogen Chloride (HCl) Rate for the time period. (lb/mmBtu)';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_monitor_hour.hcl_mass IS 'The Hydrogen Chloride (HCl) Mass for the time period. (lb)';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_monitor_hour.hcl_hour_measure_cd IS 'Foreign key into the HOUR_MEASURE_CODE table that uniquely identifies the hour measure code for this parameter.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_monitor_hour.hf_rate_eo IS 'The Electrical Output Based Hydrogen Fluoride (HF) Rate for the time period. (lb/MWh)';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_monitor_hour.hf_rate_hi IS 'The Heat Input Based Hydrogen Fluoride (HF) Rate for the time period. (lb/mmBtu)';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_monitor_hour.hf_mass IS 'The Hydrogen Fluoride (HF) Mass for the time period. (lb)';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_monitor_hour.hf_hour_measure_cd IS 'Foreign key into the HOUR_MEASURE_CODE table that uniquely identifies the hour measure code for this parameter.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_monitor_hour.mon_plan_id IS 'Foreign key into the MONITOR_PLAN table that uniquely identifies a monitoring plan of the emissions data.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_monitor_hour.rpt_period_id IS 'Foreign key into the REPORTING_PERIOD table that uniquely indentifies the reporting period of the emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_monitor_hour.op_year IS 'The year of the operating date of the record.';
COMMENT ON COLUMN camdecmpsaux.pdem_mats_monitor_hour.add_date IS 'The date this record was inserted into the table.';
