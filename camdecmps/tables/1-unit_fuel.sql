CREATE TABLE IF NOT EXISTS camdecmps.unit_fuel
(
    uf_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    unit_id numeric(38,0) NOT NULL,
    fuel_type character varying(7) COLLATE pg_catalog."default" NOT NULL,
    begin_date date NOT NULL,
    end_date date,
    indicator_cd character varying(7) COLLATE pg_catalog."default",
    act_or_proj_cd character varying(7) COLLATE pg_catalog."default",
    ozone_seas_ind numeric(1,0),
    dem_so2 character varying(7) COLLATE pg_catalog."default",
    dem_gcv character varying(7) COLLATE pg_catalog."default",
    sulfur_content numeric(5,4),
    userid character varying(25) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone,
    CONSTRAINT pk_unit_fuel PRIMARY KEY (uf_id),
    CONSTRAINT uq_unit_fuel UNIQUE (unit_id, fuel_type, begin_date),
    CONSTRAINT fk_unit_fuel_dem_method_code_gcv FOREIGN KEY (dem_gcv)
        REFERENCES camdecmpsmd.dem_method_code (dem_method_cd) MATCH SIMPLE,
    CONSTRAINT fk_unit_fuel_dem_method_code_so2 FOREIGN KEY (dem_so2)
        REFERENCES camdecmpsmd.dem_method_code (dem_method_cd) MATCH SIMPLE,
    CONSTRAINT fk_unit_fuel_fuel_indicator_code FOREIGN KEY (indicator_cd)
        REFERENCES camdecmpsmd.fuel_indicator_code (fuel_indicator_cd) MATCH SIMPLE,
    CONSTRAINT fk_unit_fuel_fuel_type_code FOREIGN KEY (fuel_type)
        REFERENCES camdecmpsmd.fuel_type_code (fuel_type_cd) MATCH SIMPLE,
    CONSTRAINT fk_unit_fuel_unit FOREIGN KEY (unit_id)
        REFERENCES camd.unit (unit_id) MATCH SIMPLE,
    CONSTRAINT ck_unit_fuel_act_or_proj_cd CHECK (act_or_proj_cd::text = ANY (ARRAY['A'::character varying::text, 'P'::character varying::text, NULL::character varying::text]))
);

COMMENT ON TABLE camdecmps.unit_fuel
    IS 'Identifies the actual or projected fuel type a UNIT is capable of combusting at a specified time.';

COMMENT ON COLUMN camdecmps.unit_fuel.uf_id
    IS 'Identity key for UNIT_FUEL table.';

COMMENT ON COLUMN camdecmps.unit_fuel.unit_id
    IS 'Identity key for UNIT table.';

COMMENT ON COLUMN camdecmps.unit_fuel.fuel_type
    IS 'The type of fuel which a UNIT is capable or will be capable of combusting.';

COMMENT ON COLUMN camdecmps.unit_fuel.begin_date
    IS 'Date on which a relationship or an activity began.';

COMMENT ON COLUMN camdecmps.unit_fuel.end_date
    IS 'Date on which a relationship or an activity ended.';

COMMENT ON COLUMN camdecmps.unit_fuel.indicator_cd
    IS 'Code that indicates fuel or control type.';

COMMENT ON COLUMN camdecmps.unit_fuel.act_or_proj_cd
    IS 'Indicator of whether the begin date for the fuel type is an actual date or a projected date.';

COMMENT ON COLUMN camdecmps.unit_fuel.ozone_seas_ind
    IS 'Indicator that FUEL is used during ozone season.';

COMMENT ON COLUMN camdecmps.unit_fuel.dem_so2
    IS 'Demonstration method to qualify for daily fuel sampling for percent sulfur.';

COMMENT ON COLUMN camdecmps.unit_fuel.dem_gcv
    IS 'Demonstration method to qualify for monthly GCV fuel sampling.';

COMMENT ON COLUMN camdecmps.unit_fuel.sulfur_content
    IS 'The percent sulfur content of the fuel, by weight.';

COMMENT ON COLUMN camdecmps.unit_fuel.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty.  Otherwise this is the user name of the person or process that made the last update.';

COMMENT ON COLUMN camdecmps.unit_fuel.add_date
    IS 'Date the record was created.';

COMMENT ON COLUMN camdecmps.unit_fuel.update_date
    IS 'Date of the last record update.';
