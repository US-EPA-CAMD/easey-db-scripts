CREATE TABLE IF NOT EXISTS camdecmps.stack_pipe
(
    stack_pipe_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    fac_id numeric(38,0) NOT NULL,
    stack_name character varying(6) COLLATE pg_catalog."default" NOT NULL,
    active_date date NOT NULL,
    retire_date date,
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);

COMMENT ON TABLE camdecmps.stack_pipe
    IS 'Stack characteristic data applicable for the configuration type identified in the monitoring plan.  Name of stack must being with "CS" followed by up to four alphanumeric characters.';

COMMENT ON COLUMN camdecmps.stack_pipe.stack_pipe_id
    IS 'Unique identifier of a stack or pipe record. ';

COMMENT ON COLUMN camdecmps.stack_pipe.fac_id
    IS 'Unique identifier of a facility record which is generated by the EPA Host System. ';

COMMENT ON COLUMN camdecmps.stack_pipe.stack_name
    IS 'Three to six alphanumeric character code which is assigned by the source to identify a stack or pipe. ';

COMMENT ON COLUMN camdecmps.stack_pipe.active_date
    IS 'The date that emissions first went through the stack or the effective date for data reporting. ';

COMMENT ON COLUMN camdecmps.stack_pipe.retire_date
    IS 'The actual date that the stack or pipe was last used for emissions measurement or estimation purposes. ';

COMMENT ON COLUMN camdecmps.stack_pipe.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.stack_pipe.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.stack_pipe.update_date
    IS 'Date and time in which record was last updated. ';