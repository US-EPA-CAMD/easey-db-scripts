CREATE TABLE IF NOT EXISTS camdmd.program_code
(
    prg_cd varchar(8) NOT NULL,
    prg_description varchar(1000) NOT NULL,
    allow_comp_ind numeric(1,0) NOT NULL DEFAULT 0,
    comp_parameter_cd varchar(7),
    first_comp_year numeric(4,0),
    os_ind numeric(1,0) NOT NULL DEFAULT 0,
    penalty_factor numeric(1,0),
    trading_end_date timestamp without time zone,
    generator_ind numeric(1,0) NOT NULL DEFAULT 0,
    prg_group_cd varchar(8),
    fed_ind numeric(1,0) NOT NULL DEFAULT 0,
    indian_country_ind numeric(1,0) NOT NULL DEFAULT 0,
    egu_only_ind numeric(1,0) NOT NULL DEFAULT 0,
    rep_required_ind numeric(1,0) NOT NULL DEFAULT 0,
    unit_allocation_ind numeric(1,0) NOT NULL DEFAULT 0,
    allocation_check_year numeric(4,0),
    PRIMARY KEY (prg_cd)
);
COMMENT ON TABLE camdmd.program_code
    IS 'Lookup code values for program.';
COMMENT ON COLUMN camdmd.program_code.prg_cd
    IS 'Code used to identify regulatory PROGRAM applicable to UNIT.';
COMMENT ON COLUMN camdmd.program_code.prg_description
    IS 'Name of regulatory PROGRAM.';
COMMENT ON COLUMN camdmd.program_code.allow_comp_ind
    IS 'Indicates whether the PROGRAM has allowance based compliance.';
COMMENT ON COLUMN camdmd.program_code.comp_parameter_cd
    IS 'The parameter code reported for a compliance program.';
COMMENT ON COLUMN camdmd.program_code.first_comp_year
    IS 'First compliance year for the PROGRAM.';
COMMENT ON COLUMN camdmd.program_code.os_ind
    IS 'Indicates whether the PROGRAM is an Ozone PROGRAM.';
COMMENT ON COLUMN camdmd.program_code.penalty_factor
    IS 'Ratio applied to excess emissions for penalty deductions for the PROGRAM.';
COMMENT ON COLUMN camdmd.program_code.trading_end_date
    IS 'The date that allowance trading ended for the program.';
COMMENT ON COLUMN camdmd.program_code.generator_ind
    IS 'Indicates whether the PROGRAM requires generator data.';
COMMENT ON COLUMN camdmd.program_code.prg_group_cd
    IS 'Code used to identify regulatory PROGRAM group.';
COMMENT ON COLUMN camdmd.program_code.fed_ind
    IS 'Indicates whether the PROGRAM is federal or state.';
COMMENT ON COLUMN camdmd.program_code.indian_country_ind
    IS 'Indicator that PROGRAM has Indian Country land.';
COMMENT ON COLUMN camdmd.program_code.egu_only_ind
    IS 'Indicates whether the PROGRAM only applies for EGU units.';
COMMENT ON COLUMN camdmd.program_code.rep_required_ind
    IS 'Indicates whether the PROGRAM requires a rep, regardless of allowance data.';
COMMENT ON COLUMN camdmd.program_code.unit_allocation_ind
    IS 'Indicates whether the PROGRAM uses unit level allocation.';
COMMENT ON COLUMN camdmd.program_code.allocation_check_year
    IS 'Indicates the first year for which two consecutive non-operating years triggers the loss of existing unit allocations for the unit beginning in the 5th year after the first non-operating year.';