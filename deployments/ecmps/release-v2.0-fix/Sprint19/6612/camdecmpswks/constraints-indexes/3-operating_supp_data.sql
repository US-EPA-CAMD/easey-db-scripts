ALTER TABLE IF EXISTS camdecmpswks.operating_supp_data
    DROP CONSTRAINT fk_operating_supp_data_monitor_location;

ALTER TABLE IF EXISTS camdecmpswks.operating_supp_data
    ADD CONSTRAINT fk_operating_supp_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON DELETE CASCADE;

