CREATE TABLE IF NOT EXISTS camdeasey.activity_log
(
    activity_id varchar(45) NOT NULL,
    user_name varchar(60) NOT NULL,
    add_date timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    process varchar(75),
    login varchar(8),
    PRIMARY KEY (activity_id)
);
COMMENT ON TABLE camdeasey.activity_log
    IS 'Logs client requests to the host.';
COMMENT ON COLUMN camdeasey.activity_log.activity_id
    IS ' Unique identifier of an activity.';
COMMENT ON COLUMN camdeasey.activity_log.user_name
    IS ' The CBS user name.';
COMMENT ON COLUMN camdeasey.activity_log.add_date
    IS ' Date and time in which record was added.';
COMMENT ON COLUMN camdeasey.activity_log.process
    IS ' The activity process.';
COMMENT ON COLUMN camdeasey.activity_log.login
    IS ' The CBS login.';