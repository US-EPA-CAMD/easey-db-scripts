CREATE TABLE IF NOT EXISTS camd.program_phase
(
    program_phase_id numeric(38,0) NOT NULL,
    prg_id numeric(38,0) NOT NULL,
    phase character varying(10) COLLATE pg_catalog."default",
    prog_phase_begin_date date NOT NULL,
    prog_phase_end_date date,
    phase_monitor_cert_deadline date NOT NULL,
    description character varying(4000) COLLATE pg_catalog."default",
    userid character varying(8) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
);

COMMENT ON TABLE camd.program_phase
    IS 'Links program and phase and stores dates associated with the program phase.';

COMMENT ON COLUMN camd.program_phase.program_phase_id
    IS 'Identity key for PROGRAM_PHASE table.';

COMMENT ON COLUMN camd.program_phase.prg_id
    IS 'PROGRAM identity key.';

COMMENT ON COLUMN camd.program_phase.phase
    IS 'Program-specific segment of time.';

COMMENT ON COLUMN camd.program_phase.prog_phase_begin_date
    IS 'Regulatory begin date for a program.';

COMMENT ON COLUMN camd.program_phase.prog_phase_end_date
    IS 'Regulatory end date for a program.';

COMMENT ON COLUMN camd.program_phase.phase_monitor_cert_deadline
    IS 'Initial monitoring certification deadline that applies to a program phase.';

COMMENT ON COLUMN camd.program_phase.description
    IS 'Notes for a program phase.';

COMMENT ON COLUMN camd.program_phase.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty.  Otherwise this is the user name of the person or process that made the last update.';

COMMENT ON COLUMN camd.program_phase.add_date
    IS 'Date the record was created.';

COMMENT ON COLUMN camd.program_phase.update_date
    IS 'Date of the last record update.';
