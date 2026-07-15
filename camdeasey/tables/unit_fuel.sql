CREATE TABLE IF NOT EXISTS camdeasey.unit_fuel
(
    uf_id varchar(45) NOT NULL,
    unit_id numeric(38,0) NOT NULL,
    fuel_type varchar(7) NOT NULL,
    begin_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone,
    indicator_cd varchar(7),
    act_or_proj_cd varchar(7),
    ozone_seas_ind numeric(1,0),
    dem_so2 varchar(7),
    dem_gcv varchar(7),
    sulfur_content numeric(5,4),
    PRIMARY KEY (uf_id)
);
COMMENT ON TABLE camdeasey.unit_fuel
    IS 'Identifies the actual or projected fuel type a UNIT is capable of combusting at a specified time.';
COMMENT ON COLUMN camdeasey.unit_fuel.uf_id
    IS 'Identity key for UNIT_FUEL table.';
COMMENT ON COLUMN camdeasey.unit_fuel.unit_id
    IS 'Identity key for UNIT table.';
COMMENT ON COLUMN camdeasey.unit_fuel.fuel_type
    IS 'The type of fuel which a UNIT is capable or will be capable of combusting.';
COMMENT ON COLUMN camdeasey.unit_fuel.begin_date
    IS 'Date on which a relationship or an activity began.';
COMMENT ON COLUMN camdeasey.unit_fuel.end_date
    IS 'Date on which a relationship or an activity ended.';
COMMENT ON COLUMN camdeasey.unit_fuel.indicator_cd
    IS 'Code that indicates fuel or control type.';
COMMENT ON COLUMN camdeasey.unit_fuel.act_or_proj_cd
    IS 'Indicator of whether the begin date for the fuel type is an actual date or a projected date.';
COMMENT ON COLUMN camdeasey.unit_fuel.ozone_seas_ind
    IS 'Indicator that FUEL is used during ozone season.';
COMMENT ON COLUMN camdeasey.unit_fuel.dem_so2
    IS 'Demonstration method to qualify for daily fuel sampling for percent sulfur.';
COMMENT ON COLUMN camdeasey.unit_fuel.dem_gcv
    IS 'Demonstration method to qualify for monthly GCV fuel sampling.';
COMMENT ON COLUMN camdeasey.unit_fuel.sulfur_content
    IS 'The percent sulfur content of the fuel, by weight.';