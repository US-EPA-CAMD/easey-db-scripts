CREATE TABLE IF NOT EXISTS camdecmps.hrly_gas_flow_meter
(
    hrly_gas_flow_meter_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    hour_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    component_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    begin_end_hour_flg character varying(7) COLLATE pg_catalog."default",
    gfm_reading numeric(13,2),
    avg_sampling_rate numeric(13,2),
    sampling_rate_uom character varying(7) COLLATE pg_catalog."default",
    flow_to_sampling_ratio numeric(4,1),
    calc_flow_to_sampling_ratio numeric(4,1),
    calc_flow_to_sampling_mult numeric(10,0),
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
) PARTITION BY RANGE (rpt_period_id);

COMMENT ON TABLE camdecmps.hrly_gas_flow_meter
    IS 'Hourly fuel flow data for Appendix D.  Record Type 302 and 303.';

COMMENT ON COLUMN camdecmps.hrly_gas_flow_meter.hrly_gas_flow_meter_id
    IS 'Unique identifier of an hourly fuel flow record. ';

COMMENT ON COLUMN camdecmps.hrly_gas_flow_meter.hour_id
    IS 'Unique identifier of an hourly operating data record. ';

COMMENT ON COLUMN camdecmps.hrly_gas_flow_meter.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmps.hrly_gas_flow_meter.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmps.hrly_gas_flow_meter.component_id
    IS 'Unique identifier of a component record. ';

COMMENT ON COLUMN camdecmps.hrly_gas_flow_meter.begin_end_hour_flg
    IS 'Marks transition hour. ';

COMMENT ON COLUMN camdecmps.hrly_gas_flow_meter.gfm_reading
    IS 'Monitored value of Gas Flow Meter. ';

COMMENT ON COLUMN camdecmps.hrly_gas_flow_meter.avg_sampling_rate
    IS 'Average sample flow rate. ';

COMMENT ON COLUMN camdecmps.hrly_gas_flow_meter.sampling_rate_uom
    IS 'Unit of Measure for average sample flow rate. ';

COMMENT ON COLUMN camdecmps.hrly_gas_flow_meter.flow_to_sampling_ratio
    IS 'Reported hourly SFSR Ratio. ';

COMMENT ON COLUMN camdecmps.hrly_gas_flow_meter.calc_flow_to_sampling_ratio
    IS 'Calculated hourly SFSR Ratio. ';

COMMENT ON COLUMN camdecmps.hrly_gas_flow_meter.calc_flow_to_sampling_mult
    IS 'Calculated ';

COMMENT ON COLUMN camdecmps.hrly_gas_flow_meter.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.hrly_gas_flow_meter.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.hrly_gas_flow_meter.update_date
    IS 'Date and time in which record was last updated. ';
