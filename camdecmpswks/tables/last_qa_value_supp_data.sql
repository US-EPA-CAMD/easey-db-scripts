CREATE TABLE IF NOT EXISTS camdecmpswks.last_qa_value_supp_data
(
    last_qa_value_supp_data_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    parameter_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    moisture_basis character varying(7) COLLATE pg_catalog."default",
    hourly_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    mon_sys_id character varying(45) COLLATE pg_catalog."default",
    component_id character varying(45) COLLATE pg_catalog."default",
    op_datehour timestamp without time zone NOT NULL,
    unadjusted_hrly_value numeric(13,3),
    adjusted_hrly_value numeric(13,3),
    delete_ind numeric(1,0) NOT NULL DEFAULT 0,
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);

COMMENT ON TABLE camdecmpswks.last_qa_value_supp_data
    IS 'Contains the last quality assured value information for a monitor location and reporting period.  Each row may represent the value at a specific system or component at the location, or the value at any system or component.';

COMMENT ON COLUMN camdecmpswks.last_qa_value_supp_data.last_qa_value_supp_data_id
    IS 'Unique identifier.';

COMMENT ON COLUMN camdecmpswks.last_qa_value_supp_data.mon_loc_id
    IS 'Unique identifier of a monitoring location record.';

COMMENT ON COLUMN camdecmpswks.last_qa_value_supp_data.rpt_period_id
    IS 'Unique identifier of a reporting period record.';

COMMENT ON COLUMN camdecmpswks.last_qa_value_supp_data.parameter_cd
    IS 'Code used to identify the parameter.';

COMMENT ON COLUMN camdecmpswks.last_qa_value_supp_data.moisture_basis
    IS 'Moisture basis for measured value.';

COMMENT ON COLUMN camdecmpswks.last_qa_value_supp_data.hourly_type_cd
    IS 'Code used to identify whether the value is monitored or derived.';

COMMENT ON COLUMN camdecmpswks.last_qa_value_supp_data.mon_sys_id
    IS 'Unique identifier of a monitor system record. ';

COMMENT ON COLUMN camdecmpswks.last_qa_value_supp_data.component_id
    IS 'Unique identifier of a component record. ';

COMMENT ON COLUMN camdecmpswks.last_qa_value_supp_data.op_datehour
    IS 'The operating date and hour of the last quality assured hour. ';

COMMENT ON COLUMN camdecmpswks.last_qa_value_supp_data.unadjusted_hrly_value
    IS 'Unadjusted value for the last quality assured hour.';

COMMENT ON COLUMN camdecmpswks.last_qa_value_supp_data.adjusted_hrly_value
    IS 'Adjusted value for the last quality assured hour.';

COMMENT ON COLUMN camdecmpswks.last_qa_value_supp_data.delete_ind
    IS 'Indicates whether the supplemental data is in a deleted state, and that ECMPS client synchronization should delete it from the each client.';

COMMENT ON COLUMN camdecmpswks.last_qa_value_supp_data.userid
    IS 'User account or source of data that added or updated record.';

COMMENT ON COLUMN camdecmpswks.last_qa_value_supp_data.add_date
    IS 'Date and time in which record was added.';

COMMENT ON COLUMN camdecmpswks.last_qa_value_supp_data.update_date
    IS 'Date and time in which record was last updated.';
