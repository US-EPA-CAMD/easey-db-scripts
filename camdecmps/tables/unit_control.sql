CREATE TABLE IF NOT EXISTS camdecmps.unit_control
(
    ctl_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    unit_id numeric(38,0) NOT NULL,
    control_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    ce_param character varying(7) COLLATE pg_catalog."default" NOT NULL,
    install_date date,
    opt_date date,
    orig_cd character varying(1) COLLATE pg_catalog."default",
    seas_cd character varying(1) COLLATE pg_catalog."default",
    retire_date date,
    indicator_cd character varying(7) COLLATE pg_catalog."default",
    userid character varying(160) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
);

COMMENT ON TABLE camdecmps.unit_control
    IS 'Control equipment planned to be used or is used to reduce emissions at a unit.';

COMMENT ON COLUMN camdecmps.unit_control.ctl_id
    IS 'Unique identifier of a unit control record.';

COMMENT ON COLUMN camdecmps.unit_control.unit_id
    IS 'Unique identifier of a unit record.';

COMMENT ON COLUMN camdecmps.unit_control.control_cd
    IS 'Codes used to identify the type of control equipment.';

COMMENT ON COLUMN camdecmps.unit_control.ce_param
    IS 'Code used to identify the parameter which is controlled by the control equipment.';

COMMENT ON COLUMN camdecmps.unit_control.install_date
    IS 'Approximate date the original control equipment was or will be installed.';

COMMENT ON COLUMN camdecmps.unit_control.opt_date
    IS 'The approximate date on which optimization of control equipment was completed and the equipment made fully operational if the control equipment was not part of the original installation.';

COMMENT ON COLUMN camdecmps.unit_control.orig_cd
    IS 'Code used to identify that the control equipment was installed and operational as part of the original unit design.';

COMMENT ON COLUMN camdecmps.unit_control.seas_cd
    IS 'Code used to identify if the NOx control equipment was used during the ozone season.';

COMMENT ON COLUMN camdecmps.unit_control.retire_date
    IS 'Date control equipment was retired.';

COMMENT ON COLUMN camdecmps.unit_control.indicator_cd
    IS 'Code used to identify the fuel or control type.';

COMMENT ON COLUMN camdecmps.unit_control.userid
    IS 'User account or source of data that added or updated record.';

COMMENT ON COLUMN camdecmps.unit_control.add_date
    IS 'Date and time in which record was added.';

COMMENT ON COLUMN camdecmps.unit_control.update_date
    IS 'Date and time in which record was last updated.';
