CREATE TABLE IF NOT EXISTS camdeasey.synchronization_detail
(
    synchronization_detail_id numeric(38,0) NOT NULL,
    mon_plan_id varchar(45) NOT NULL,
    userid varchar(160) NOT NULL,
    add_date timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    detail varchar(4000) NOT NULL,
    PRIMARY KEY (synchronization_detail_id)
);
COMMENT ON TABLE camdeasey.synchronization_detail
    IS 'Maintains the details for current state of monitor plans for synchronization.';
COMMENT ON COLUMN camdeasey.synchronization_detail.synchronization_detail_id
    IS ' Unique identifier of a synchronization detail record.';
COMMENT ON COLUMN camdeasey.synchronization_detail.mon_plan_id
    IS ' Unique identifier of a monitoring plan record. ';
COMMENT ON COLUMN camdeasey.synchronization_detail.userid
    IS ' User account or source of data that added or updated record.';
COMMENT ON COLUMN camdeasey.synchronization_detail.add_date
    IS ' Date and time in which record was added.';
COMMENT ON COLUMN camdeasey.synchronization_detail.detail
    IS ' Description for synchronization record update . ';