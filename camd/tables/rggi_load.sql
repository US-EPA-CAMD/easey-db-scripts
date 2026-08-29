CREATE TABLE IF NOT EXISTS camd.rggi_load
(
    state_cd varchar(2),
    facility_name varchar(100),
    oris_code numeric(6,0),
    unitid varchar(6),
    fac_id numeric(38,0),
    unit_id numeric(38,0)
);