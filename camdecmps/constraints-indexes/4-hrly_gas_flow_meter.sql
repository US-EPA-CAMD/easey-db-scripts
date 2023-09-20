SELECT '4-hrly_gas_flow_meter.sql';

ALTER TABLE IF EXISTS camdecmps.hrly_gas_flow_meter
    ADD CONSTRAINT pk_hrly_gas_flow_meter PRIMARY KEY (hrly_gas_flow_meter_id),
    ADD CONSTRAINT fk_hrly_gas_flow_meter_component FOREIGN KEY (component_id)
        REFERENCES camdecmps.component (component_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_hrly_gas_flow_meter_hrly_op_data FOREIGN KEY (hour_id)
        REFERENCES camdecmps.hrly_op_data (hour_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_hrly_gas_flow_meter_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_hrly_gas_flow_meter_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
  	ADD CONSTRAINT fk_hrly_gas_flow_meter_begin_end_hour_flg FOREIGN KEY (begin_end_hour_flg)
        REFERENCES camdecmpsmd.begin_end_hour_flag (begin_end_hour_flg) MATCH SIMPLE,
	  ADD CONSTRAINT fk_hrly_gas_flow_meter_sampling_rate_uom FOREIGN KEY (sampling_rate_uom)
        REFERENCES camdecmpsmd.units_of_measure_code (uom_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_hrly_gas_flow_meter_hour_id
    ON camdecmps.hrly_gas_flow_meter USING btree
    (hour_id COLLATE pg_catalog."default" ASC NULLS LAST);
	
CREATE INDEX IF NOT EXISTS idx_hrly_gas_flow_meter_mon_loc_id
    ON camdecmps.hrly_gas_flow_meter USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_gas_flow_meter_rpt_period_id
    ON camdecmps.hrly_gas_flow_meter USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_gas_flow_meter_component_id
    ON camdecmps.hrly_gas_flow_meter USING btree
    (component_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_gas_flow_meter_begin_end_hour_flg
    ON camdecmps.hrly_gas_flow_meter USING btree
    (begin_end_hour_flg COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_gas_flow_meter_sampling_rate_uom
    ON camdecmps.hrly_gas_flow_meter USING btree
    (sampling_rate_uom COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_hrly_gas_flow_meter_rpt_period_id_mon_loc_id
    ON camdecmps.hrly_gas_flow_meter USING btree
    (rpt_period_id ASC NULLS LAST, mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);
