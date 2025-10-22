--BEGIN;
    
    ---------------------------------------------------------------
    -- Drop Constraints to be Updated for Hourly Emission Tables --
    ---------------------------------------------------------------
    
    -- Drop Parent FK Constraints for Hourly Emission Tables
    ALTER TABLE camdecmps.derived_hrly_value      DROP CONSTRAINT IF EXISTS fk_derived_hrly_value_hrly_op_data;
    ALTER TABLE camdecmps.hrly_fuel_flow          DROP CONSTRAINT IF EXISTS fk_hrly_fuel_flow_hrly_op_data;
    ALTER TABLE camdecmps.hrly_gas_flow_meter     DROP CONSTRAINT IF EXISTS fk_hrly_gas_flow_meter_hrly_op_data;
    ALTER TABLE camdecmps.hrly_param_fuel_flow    DROP CONSTRAINT IF EXISTS fk_hrly_param_fuel_flow_hrly_fuel_flow;
    ALTER TABLE camdecmps.mats_derived_hrly_value DROP CONSTRAINT IF EXISTS fk_mats_derived_hrly_value_hrly_op_data;
    ALTER TABLE camdecmps.mats_monitor_hrly_value DROP CONSTRAINT IF EXISTS fk_mats_monitor_hrly_value_hrly_op_data;
    ALTER TABLE camdecmps.monitor_hrly_value      DROP CONSTRAINT IF EXISTS fk_monitor_hrly_value_hrly_op_data;
    
    -- Drop PK Constraints for Hourly Emission Tables
    ALTER TABLE camdecmps.derived_hrly_value      DROP CONSTRAINT IF EXISTS pk_derived_hrly_value;
    ALTER TABLE camdecmps.hrly_fuel_flow          DROP CONSTRAINT IF EXISTS pk_hrly_fuel_flow;
    ALTER TABLE camdecmps.hrly_gas_flow_meter     DROP CONSTRAINT IF EXISTS pk_hrly_gas_flow_meter;
    ALTER TABLE camdecmps.hrly_op_data            DROP CONSTRAINT IF EXISTS pk_hrly_op_data;
    
    
    -- Add Parent New PK Constraints for Hourly Emission Tables
    ALTER TABLE camdecmps.hrly_op_data
        ADD CONSTRAINT pk_hrly_op_data
                       PRIMARY KEY (rpt_period_id, hour_id);
    
    ALTER TABLE camdecmps.derived_hrly_value
        ADD CONSTRAINT pk_derived_hrly_value
                       PRIMARY KEY (rpt_period_id, derv_id);
    
    ALTER TABLE camdecmps.hrly_fuel_flow      
        ADD CONSTRAINT pk_hrly_fuel_flow
                       PRIMARY KEY (rpt_period_id, hrly_fuel_flow_id);
    
    ALTER TABLE camdecmps.hrly_gas_flow_meter
        ADD CONSTRAINT pk_hrly_gas_flow_meter
                       PRIMARY KEY (rpt_period_id, hrly_gas_flow_meter_id);
    
    ALTER TABLE camdecmps.mats_derived_hrly_value
        ADD CONSTRAINT pk_mats_derived_hrly_value
                       PRIMARY KEY (rpt_period_id, mats_dhv_id);
    
    ALTER TABLE camdecmps.mats_monitor_hrly_value
        ADD CONSTRAINT pk_mats_monitor_hrly_value
                       PRIMARY KEY (rpt_period_id, mats_mhv_id);
    
    ALTER TABLE camdecmps.monitor_hrly_value
        ADD CONSTRAINT pk_monitor_hrly_value
                       PRIMARY KEY (rpt_period_id, monitor_hrly_val_id);
    
    ALTER TABLE camdecmps.hrly_param_fuel_flow
        ADD CONSTRAINT pk_hrly_param_fuel_flow
                       PRIMARY KEY (rpt_period_id, hrly_param_ff_id);
    
    
    --------------------------------------------------------------
    -- Add Parent New FK Constraints for Hourly Emission Tables --
    --------------------------------------------------------------
    
    ALTER TABLE camdecmps.derived_hrly_value      
        ADD CONSTRAINT fk_derived_hrly_value_hrly_op_data
                       FOREIGN KEY (rpt_period_id, hour_id)
                       REFERENCES camdecmps.hrly_op_data (rpt_period_id, hour_id) MATCH SIMPLE;
    
    ALTER TABLE camdecmps.hrly_fuel_flow          
        ADD CONSTRAINT fk_hrly_fuel_flow_hrly_op_data
                       FOREIGN KEY (rpt_period_id, hour_id)
                       REFERENCES camdecmps.hrly_op_data (rpt_period_id, hour_id) MATCH SIMPLE;
    
    ALTER TABLE camdecmps.hrly_gas_flow_meter     
        ADD CONSTRAINT fk_hrly_gas_flow_meter_hrly_op_data
                       FOREIGN KEY (rpt_period_id, hour_id)
                       REFERENCES camdecmps.hrly_op_data (rpt_period_id, hour_id) MATCH SIMPLE;
    
    ALTER TABLE camdecmps.mats_derived_hrly_value 
        ADD CONSTRAINT fk_mats_derived_hrly_value_hrly_op_data
                       FOREIGN KEY (rpt_period_id, hour_id)
                       REFERENCES camdecmps.hrly_op_data (rpt_period_id, hour_id) MATCH SIMPLE;
    
    ALTER TABLE camdecmps.mats_monitor_hrly_value 
        ADD CONSTRAINT fk_mats_monitor_hrly_value_hrly_op_data
                       FOREIGN KEY (rpt_period_id, hour_id)
                       REFERENCES camdecmps.hrly_op_data (rpt_period_id, hour_id) MATCH SIMPLE;
    
    ALTER TABLE camdecmps.monitor_hrly_value      
        ADD CONSTRAINT fk_monitor_hrly_value_hrly_op_data
                       FOREIGN KEY (rpt_period_id, hour_id)
                       REFERENCES camdecmps.hrly_op_data (rpt_period_id, hour_id) MATCH SIMPLE;
    
    ALTER TABLE camdecmps.hrly_param_fuel_flow    
        ADD CONSTRAINT fk_hrly_param_fuel_flow_hrly_fuel_flow
                       FOREIGN KEY (rpt_period_id, hrly_fuel_flow_id)
                       REFERENCES camdecmps.hrly_fuel_flow (rpt_period_id, hrly_fuel_flow_id) MATCH SIMPLE;
    

    --------------------------
    -- Add Parent FK Indexs --
    --------------------------

    -- DERIVED_HRLY_VALUE
    CREATE INDEX IF NOT EXISTS idx_derived_hrly_value_rpt_period_id_hour_id
        ON camdecmps.derived_hrly_value USING btree
        (rpt_period_id ASC NULLS LAST, hour_id COLLATE pg_catalog."default" ASC NULLS LAST);

    -- HRLY_FUEL_FLOW
    CREATE INDEX IF NOT EXISTS idx_hrly_fuel_flow_rpt_period_id_hour_id
        ON camdecmps.hrly_fuel_flow USING btree
        (rpt_period_id ASC NULLS LAST, hour_id COLLATE pg_catalog."default" ASC NULLS LAST);

    -- HRLY_GAS_FLOW_METER
    CREATE INDEX IF NOT EXISTS idx_hrly_gas_flow_meter_rpt_period_id_hour_id
        ON camdecmps.hrly_gas_flow_meter USING btree
        (rpt_period_id ASC NULLS LAST, hour_id COLLATE pg_catalog."default" ASC NULLS LAST);

    -- MATS_DERIVED_HRLY_VALUE
    CREATE INDEX IF NOT EXISTS idx_mats_derived_hrly_value_rpt_period_id_hour_id
        ON camdecmps.mats_derived_hrly_value USING btree
        (rpt_period_id ASC NULLS LAST, hour_id COLLATE pg_catalog."default" ASC NULLS LAST);

    -- MATS_MONITOR_HRLY_VALUE
    CREATE INDEX IF NOT EXISTS idx_mats_monitor_hrly_value_rpt_period_id_hour_id
        ON camdecmps.mats_monitor_hrly_value USING btree
        (rpt_period_id ASC NULLS LAST, hour_id COLLATE pg_catalog."default" ASC NULLS LAST);

    -- MONITOR_HRLY_VALUE
    CREATE INDEX IF NOT EXISTS idx_monitor_hrly_value_rpt_period_id_hour_id
        ON camdecmps.monitor_hrly_value USING btree
        (rpt_period_id ASC NULLS LAST, hour_id COLLATE pg_catalog."default" ASC NULLS LAST);

    -- HRLY_PARAM_FUEL_FLOW
    CREATE INDEX IF NOT EXISTS idx_hrly_param_fuel_flow_rpt_period_id_hrly_fuel_flow_id
        ON camdecmps.hrly_param_fuel_flow USING btree
        (rpt_period_id ASC NULLS LAST, hrly_fuel_flow_id COLLATE pg_catalog."default" ASC NULLS LAST);

    
    -------------------------------------------------------------
    -- Drop Constraints to be Updated for Emission View Tables --
    -------------------------------------------------------------
    
    -- Drop Parent HOUR_ID FK Constraints for Emission View Tables
    ALTER TABLE camdecmps.emission_view_all       DROP CONSTRAINT IF EXISTS fk_emission_view_all_hrly_op_data;
    ALTER TABLE camdecmps.emission_view_hicems    DROP CONSTRAINT IF EXISTS fk_emission_view_hicems_hrly_op_data;
    ALTER TABLE camdecmps.emission_view_lme       DROP CONSTRAINT IF EXISTS fk_emission_view_lme_hrly_op_data;
    
    
    -------------------------------------------------------------
    -- Add New HOUR_ID FK Constraints for Emission View Tables --
    -------------------------------------------------------------
    
    ALTER TABLE camdecmps.emission_view_all     
        ADD CONSTRAINT fk_emission_view_all_hrly_op_data
                       FOREIGN KEY (rpt_period_id, hour_id)
                       REFERENCES camdecmps.hrly_op_data (rpt_period_id, hour_id) MATCH SIMPLE;
    
    ALTER TABLE camdecmps.emission_view_hicems     
        ADD CONSTRAINT fk_emission_view_hicems_hrly_op_data
                       FOREIGN KEY (rpt_period_id, hour_id)
                       REFERENCES camdecmps.hrly_op_data (rpt_period_id, hour_id) MATCH SIMPLE;
    
    ALTER TABLE camdecmps.emission_view_lme     
        ADD CONSTRAINT fk_emission_view_lme_hrly_op_data
                       FOREIGN KEY (rpt_period_id, hour_id)
                       REFERENCES camdecmps.hrly_op_data (rpt_period_id, hour_id) MATCH SIMPLE;


    -------------------------------
    -- Add New HOUR_ID FK Indexs --
    -------------------------------
    
    -- EMISSION_VIEW_ALL
    CREATE INDEX IF NOT EXISTS idx_emission_view_all_rpt_period_id_hour_id
		ON camdecmps.emission_view_all USING btree
		(rpt_period_id ASC NULLS LAST, hour_id COLLATE pg_catalog."default" ASC NULLS LAST);

    -- EMISSION_VIEW_HICEMS
    CREATE INDEX IF NOT EXISTS idx_emission_view_hicems_rpt_period_id_hour_id
		ON camdecmps.emission_view_hicems USING btree
		(rpt_period_id ASC NULLS LAST, hour_id COLLATE pg_catalog."default" ASC NULLS LAST);

    -- EMISSION_VIEW_LME
    CREATE INDEX IF NOT EXISTS idx_emission_view_lme_rpt_period_id_hour_id
		ON camdecmps.emission_view_lme USING btree
		(rpt_period_id ASC NULLS LAST, hour_id COLLATE pg_catalog."default" ASC NULLS LAST);

    
--COMMIT;
