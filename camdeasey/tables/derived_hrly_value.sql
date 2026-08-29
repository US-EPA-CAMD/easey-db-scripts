CREATE TABLE IF NOT EXISTS camdeasey.derived_hrly_value
(
    derv_id varchar(45) NOT NULL,
    hour_id varchar(45) NOT NULL,
    parameter_cd varchar(7) NOT NULL,
    adjusted_hrly_value numeric(14,4),
    modc_cd varchar(7),
    rpt_period_id numeric NOT NULL,
    mon_loc_id varchar(45) NOT NULL,
    PRIMARY KEY (derv_id)
);
COMMENT ON TABLE camdeasey.derived_hrly_value
    IS 'The derived hourly value for a parameter (e.g., SO2 lbs/hr) as calculated from measured values and reported by the source.  Record Types 300, 310, 320, 328, 330.';
COMMENT ON COLUMN camdeasey.derived_hrly_value.derv_id
    IS 'Unique identifier of a derived hourly value record. ';
COMMENT ON COLUMN camdeasey.derived_hrly_value.hour_id
    IS 'Unique identifier of an hourly operating data record. ';
COMMENT ON COLUMN camdeasey.derived_hrly_value.parameter_cd
    IS 'Code used to identify the parameter. ';
COMMENT ON COLUMN camdeasey.derived_hrly_value.adjusted_hrly_value
    IS 'Adjusted parameter value for the hour, as calculated from measured values and then adjusted for bias, or the substitute value for missing data hours. ';
COMMENT ON COLUMN camdeasey.derived_hrly_value.modc_cd
    IS 'Code used to identify the method of determination. ';
COMMENT ON COLUMN camdeasey.derived_hrly_value.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';
COMMENT ON COLUMN camdeasey.derived_hrly_value.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';