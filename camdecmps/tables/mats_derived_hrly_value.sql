CREATE TABLE IF NOT EXISTS camdecmps.mats_derived_hrly_value
(
    mats_dhv_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    hour_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    parameter_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    unadjusted_hrly_value character varying(30) COLLATE pg_catalog."default",
    modc_cd character varying(7) COLLATE pg_catalog."default",
    mon_form_id character varying(45) COLLATE pg_catalog."default",
    calc_unadjusted_hrly_value character varying(30) COLLATE pg_catalog."default",
    calc_pct_diluent numeric(5,1),
    calc_pct_moisture numeric(5,1),
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);

COMMENT ON TABLE camdecmps.mats_derived_hrly_value
    IS 'The derived hourly value for a parameter as calculated from measured values and reported by the source. ';

COMMENT ON COLUMN camdecmps.mats_derived_hrly_value.mats_dhv_id
    IS 'Unique identifier of a MATS derived hourly value record. ';

COMMENT ON COLUMN camdecmps.mats_derived_hrly_value.hour_id
    IS 'Unique identifier of an hourly operating data record. ';

COMMENT ON COLUMN camdecmps.mats_derived_hrly_value.parameter_cd
    IS 'Code used to identify the parameter. ';

COMMENT ON COLUMN camdecmps.mats_derived_hrly_value.unadjusted_hrly_value
    IS 'Unadjusted value calculated from measured values for the hour in scientific notation. ';

COMMENT ON COLUMN camdecmps.mats_derived_hrly_value.modc_cd
    IS 'Code used to identify the method of determination. ';

COMMENT ON COLUMN camdecmps.mats_derived_hrly_value.mon_form_id
    IS 'Unique identifier of a monitoring formula record. ';

COMMENT ON COLUMN camdecmps.mats_derived_hrly_value.calc_unadjusted_hrly_value
    IS 'Unadjusted value calculated from measured values for the hour in scientific notation. ';

COMMENT ON COLUMN camdecmps.mats_derived_hrly_value.calc_pct_diluent
    IS 'The percent CO2 or O2 used in the calculation of emission rate.  (It may be the reported value, the diluent cap, or the recalculated CO2 concentration from an O2 monitor).';

COMMENT ON COLUMN camdecmps.mats_derived_hrly_value.calc_pct_moisture
    IS 'The percent H2O used in various calculations.  (It may be the reported value, a moisture default, the recalculated H2O from an O2 wet and dry monitor.)';

COMMENT ON COLUMN camdecmps.mats_derived_hrly_value.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmps.mats_derived_hrly_value.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmps.mats_derived_hrly_value.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.mats_derived_hrly_value.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.mats_derived_hrly_value.update_date
    IS 'Date and time in which record was last updated. ';
