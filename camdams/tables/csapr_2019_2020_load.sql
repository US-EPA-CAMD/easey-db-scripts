CREATE TABLE IF NOT EXISTS camdams.csapr_2019_2020_load
(
    state_cd varchar(2) NOT NULL,
    sgenres numeric NOT NULL,
    sprmres numeric NOT NULL,
    snsares numeric NOT NULL,
    snsaresic numeric,
    prg_cd varchar(7) NOT NULL,
    vintage_year numeric NOT NULL,
    PRIMARY KEY (state_cd, prg_cd, vintage_year)
);