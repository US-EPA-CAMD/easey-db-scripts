CREATE TABLE IF NOT EXISTS camdecmpsaux.program_parameter
(
    prg_param_id numeric(38,0) NOT NULL,
    prg_id numeric(38,0) NOT NULL,
    parameter_cd character varying(8) COLLATE pg_catalog."default" NOT NULL,
    required_ind numeric(1,0) NOT NULL DEFAULT 0,
    begin_rpt_period_id numeric(38,0) NOT NULL,
    end_rpt_period_id numeric(38,0),
    userid character varying(160) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
);

COMMENT ON TABLE camdecmpsaux.program_parameter
    IS 'Stores the relationship between a program and the pollutant parameters that are required to be reported for that program.';

COMMENT ON COLUMN camdecmpsaux.program_parameter.prg_param_id
    IS 'PROGRAM PARAMETER identity key.';

COMMENT ON COLUMN camdecmpsaux.program_parameter.prg_id
    IS 'PROGRAM identity key.';

COMMENT ON COLUMN camdecmpsaux.program_parameter.parameter_cd
    IS 'Code used to identify the parameter.';

COMMENT ON COLUMN camdecmpsaux.program_parameter.required_ind
    IS 'Parameter is required if 1.';

COMMENT ON COLUMN camdecmpsaux.program_parameter.begin_rpt_period_id
    IS 'Unique identifier of a reporting period record.';

COMMENT ON COLUMN camdecmpsaux.program_parameter.end_rpt_period_id
    IS 'Unique identifier of a reporting period record.';

COMMENT ON COLUMN camdecmpsaux.program_parameter.userid
    IS 'User account or source of data that added or updated record.';

COMMENT ON COLUMN camdecmpsaux.program_parameter.add_date
    IS 'Date and time in which record was added.';

COMMENT ON COLUMN camdecmpsaux.program_parameter.update_date
    IS 'Date and time in which record was last updated.';
