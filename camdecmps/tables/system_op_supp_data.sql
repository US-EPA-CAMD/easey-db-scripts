CREATE TABLE IF NOT EXISTS camdecmps.system_op_supp_data
(
    sys_op_supp_data_id character varying(45) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v4(),
    mon_sys_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    op_supp_data_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    days numeric(38,0) NOT NULL,
    hours numeric(38,0) NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    delete_ind numeric(1,0) NOT NULL DEFAULT 0,
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);

COMMENT ON TABLE camdecmps.system_op_supp_data
    IS 'Contains day and hour counts matching the op supp data type for a monitor system and reporting period.';

COMMENT ON COLUMN camdecmps.system_op_supp_data.sys_op_supp_data_id
    IS 'Unique identifier.';

COMMENT ON COLUMN camdecmps.system_op_supp_data.mon_sys_id
    IS 'Unique identifier of a monitor system record. ';

COMMENT ON COLUMN camdecmps.system_op_supp_data.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmps.system_op_supp_data.op_supp_data_type_cd
    IS 'Code used to identify the type of operating supplemental data. ';

COMMENT ON COLUMN camdecmps.system_op_supp_data.days
    IS 'Count of days in the quarter for the monitor system and operating supplemental data type.';

COMMENT ON COLUMN camdecmps.system_op_supp_data.hours
    IS 'Count of hours in the quarter for the monitor system and operating supplemental data type.';

COMMENT ON COLUMN camdecmps.system_op_supp_data.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmps.system_op_supp_data.delete_ind
    IS 'Indicates whether the supplemental data is in a deleted state, and that ECMPS client synchronization should delete it from the each client.';

COMMENT ON COLUMN camdecmps.system_op_supp_data.userid
    IS 'User account or source of data that added or updated record.';

COMMENT ON COLUMN camdecmps.system_op_supp_data.add_date
    IS 'Date and time in which record was added.';

COMMENT ON COLUMN camdecmps.system_op_supp_data.update_date
    IS 'Date and time in which record was last updated.';
