-- Table: camdecmps.hrly_gas_flow_meter

-- DROP TABLE IF EXISTS camdecmps.hrly_gas_flow_meter;

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
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_hrly_gas_flow_meter PRIMARY KEY (hrly_gas_flow_meter_id),
    CONSTRAINT fk_gfm_component_id FOREIGN KEY (component_id)
        REFERENCES camdecmps.component (component_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_gfm_hour_id FOREIGN KEY (hour_id)
        REFERENCES camdecmps.hrly_op_data (hour_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_gfm_mon_loc_id FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_gfm_rpt_period_id FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

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
-- Index: idx_component_id

-- DROP INDEX IF EXISTS camdecmps.idx_component_id;

CREATE INDEX IF NOT EXISTS idx_component_id
    ON camdecmps.hrly_gas_flow_meter USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_hrlygfm_001

-- DROP INDEX IF EXISTS camdecmps.idx_hrlygfm_001;

CREATE INDEX IF NOT EXISTS idx_hrlygfm_001
    ON camdecmps.hrly_gas_flow_meter USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_hrlygfm_add_date

-- DROP INDEX IF EXISTS camdecmps.idx_hrlygfm_add_date;

CREATE INDEX IF NOT EXISTS idx_hrlygfm_add_date
    ON camdecmps.hrly_gas_flow_meter USING btree
    (add_date ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_hrlygfm_hour_id

-- DROP INDEX IF EXISTS camdecmps.idx_hrlygfm_hour_id;

CREATE INDEX IF NOT EXISTS idx_hrlygfm_hour_id
    ON camdecmps.hrly_gas_flow_meter USING btree
    (hour_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;