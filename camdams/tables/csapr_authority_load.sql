CREATE TABLE IF NOT EXISTS camdams.csapr_authority_load
(
    state_cd varchar(2) NOT NULL,
    sgenres numeric NOT NULL,
    sprmres numeric NOT NULL,
    snsares numeric NOT NULL,
    snsaresic numeric,
    sothres105 numeric,
    prg_cd varchar(7) NOT NULL,
    vintage_year numeric NOT NULL,
    PRIMARY KEY (state_cd, prg_cd, vintage_year)
);
COMMENT ON TABLE camdams.csapr_authority_load
    IS 'Stores information used to load CSAPR authority amounts.';
COMMENT ON COLUMN camdams.csapr_authority_load.state_cd
    IS 'Abbreviation for the state.';
COMMENT ON COLUMN camdams.csapr_authority_load.sgenres
    IS 'Total number of allowances the general reserve account can allocate for the specific year.';
COMMENT ON COLUMN camdams.csapr_authority_load.sprmres
    IS 'Total number of allowances the primary reserve account can allocate for the specific year. year.';
COMMENT ON COLUMN camdams.csapr_authority_load.snsares
    IS 'Total number of allowances the NUSA reserve account can allocate for the specific year.';
COMMENT ON COLUMN camdams.csapr_authority_load.snsaresic
    IS 'Total number of allowances the IC NUSA reserve account can allocate for the specific year.';
COMMENT ON COLUMN camdams.csapr_authority_load.sothres105
    IS 'Total number of allowances the supplemental reserve account can allocate for the specific year.';
COMMENT ON COLUMN camdams.csapr_authority_load.prg_cd
    IS 'Code used to identify regulatory program applicable to allowance vintage.';
COMMENT ON COLUMN camdams.csapr_authority_load.vintage_year
    IS 'Vintage year.';