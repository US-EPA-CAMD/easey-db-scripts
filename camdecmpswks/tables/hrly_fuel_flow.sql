CREATE TABLE IF NOT EXISTS camdecmpswks.hrly_fuel_flow
(
    hrly_fuel_flow_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    hour_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_sys_id character varying(45) COLLATE pg_catalog."default",
    fuel_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    fuel_usage_time numeric(3,2),
    volumetric_flow_rate numeric(10,1),
    sod_volumetric_cd character varying(7) COLLATE pg_catalog."default",
    mass_flow_rate numeric(10,1),
    calc_mass_flow_rate numeric(10,1),
    sod_mass_cd character varying(7) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    volumetric_uom_cd character varying(7) COLLATE pg_catalog."default",
    calc_volumetric_flow_rate numeric(10,1),
    calc_appd_status character varying(75) COLLATE pg_catalog."default",
    rpt_period_id numeric(38,0) NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpswks.hrly_fuel_flow
    IS 'Hourly fuel flow data for Appendix D.  Record Type 302 and 303.';

COMMENT ON COLUMN camdecmpswks.hrly_fuel_flow.hrly_fuel_flow_id
    IS 'Unique identifier of an hourly fuel flow record. ';

COMMENT ON COLUMN camdecmpswks.hrly_fuel_flow.hour_id
    IS 'Unique identifier of an hourly operating data record. ';

COMMENT ON COLUMN camdecmpswks.hrly_fuel_flow.mon_sys_id
    IS 'Unique identifier of a monitoring system record. ';

COMMENT ON COLUMN camdecmpswks.hrly_fuel_flow.fuel_cd
    IS 'Code used to identify the type of fuel. ';

COMMENT ON COLUMN camdecmpswks.hrly_fuel_flow.fuel_usage_time
    IS 'Fuel usage time. ';

COMMENT ON COLUMN camdecmpswks.hrly_fuel_flow.volumetric_flow_rate
    IS 'Volumetric flow rate during combustion. ';

COMMENT ON COLUMN camdecmpswks.hrly_fuel_flow.sod_volumetric_cd
    IS 'Code used to identify the source of volumetric flow rate. ';

COMMENT ON COLUMN camdecmpswks.hrly_fuel_flow.mass_flow_rate
    IS 'Mass flow rate during combustion. ';

COMMENT ON COLUMN camdecmpswks.hrly_fuel_flow.calc_mass_flow_rate
    IS 'Mass flow rate during combustion. ';

COMMENT ON COLUMN camdecmpswks.hrly_fuel_flow.sod_mass_cd
    IS 'Code used to identify the source of mass flow rate. ';

COMMENT ON COLUMN camdecmpswks.hrly_fuel_flow.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmpswks.hrly_fuel_flow.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmpswks.hrly_fuel_flow.update_date
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmpswks.hrly_fuel_flow.volumetric_uom_cd
    IS 'Code used to identify the units of measure for volumetric fuel flow. ';

COMMENT ON COLUMN camdecmpswks.hrly_fuel_flow.calc_volumetric_flow_rate
    IS 'Volumetric flow rate during combustion. ';

COMMENT ON COLUMN camdecmpswks.hrly_fuel_flow.calc_appd_status
    IS 'QA Status for Appendix D Check determined by EPA. ';

COMMENT ON COLUMN camdecmpswks.hrly_fuel_flow.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmpswks.hrly_fuel_flow.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';
