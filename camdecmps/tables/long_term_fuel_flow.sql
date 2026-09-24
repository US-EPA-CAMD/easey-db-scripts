CREATE TABLE IF NOT EXISTS camdecmps.long_term_fuel_flow
(
    ltff_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0),
    mon_loc_id character varying(45) COLLATE pg_catalog."default",
    mon_sys_id character varying(45) COLLATE pg_catalog."default",
    fuel_flow_period_cd character varying(7) COLLATE pg_catalog."default",
    long_term_fuel_flow_value numeric(10,0),
    ltff_uom_cd character varying(7) COLLATE pg_catalog."default",
    gross_calorific_value numeric(10,1),
    gcv_uom_cd character varying(7) COLLATE pg_catalog."default",
    total_heat_input numeric(10,0),
    calc_total_heat_input numeric(10,0),
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
) PARTITION BY RANGE (rpt_period_id);

COMMENT ON TABLE camdecmps.long_term_fuel_flow
    IS 'Long term fuel flow data for LME reporting.';

COMMENT ON COLUMN camdecmps.long_term_fuel_flow.ltff_id
    IS 'Unique identifier of a long term fuel flow record. ';

COMMENT ON COLUMN camdecmps.long_term_fuel_flow.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmps.long_term_fuel_flow.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmps.long_term_fuel_flow.mon_sys_id
    IS 'Unique identifier of a monitoring system record. ';

COMMENT ON COLUMN camdecmps.long_term_fuel_flow.fuel_flow_period_cd
    IS 'Code used to identify the long term fuel flow period. ';

COMMENT ON COLUMN camdecmps.long_term_fuel_flow.long_term_fuel_flow_value
    IS 'Long term fuel flow value ';

COMMENT ON COLUMN camdecmps.long_term_fuel_flow.ltff_uom_cd
    IS 'Code used to identify the units of measure for the long term fuel flow value. ';

COMMENT ON COLUMN camdecmps.long_term_fuel_flow.gross_calorific_value
    IS 'Gross Calorific Value. ';

COMMENT ON COLUMN camdecmps.long_term_fuel_flow.gcv_uom_cd
    IS 'Code used to identify the units of measure for the GCV. ';

COMMENT ON COLUMN camdecmps.long_term_fuel_flow.total_heat_input
    IS 'Total heat input from this long term fuel flow value. ';

COMMENT ON COLUMN camdecmps.long_term_fuel_flow.calc_total_heat_input
    IS 'Calculated total heat input from this long term fuel flow value. ';

COMMENT ON COLUMN camdecmps.long_term_fuel_flow.userid
    IS 'User account or source of data that added or updated record.';

COMMENT ON COLUMN camdecmps.long_term_fuel_flow.add_date
    IS 'Date and time in which record was added.';

COMMENT ON COLUMN camdecmps.long_term_fuel_flow.update_date
    IS 'Date and time in which record was last updated.';
