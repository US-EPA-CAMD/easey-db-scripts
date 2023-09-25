CREATE TABLE IF NOT EXISTS camdaux.qrtz_job_details
(
    sched_name TEXT NOT NULL,
	  job_name  TEXT NOT NULL,
    job_group TEXT NOT NULL,
    description TEXT NULL,
    job_class_name   TEXT NOT NULL, 
    is_durable BOOL NOT NULL,
    is_nonconcurrent BOOL NOT NULL,
    is_update_data BOOL NOT NULL,
	  requests_recovery BOOL NOT NULL,
    job_data BYTEA NULL
);

CREATE TABLE IF NOT EXISTS camdaux.qrtz_triggers
(
    sched_name TEXT NOT NULL,
	  trigger_name TEXT NOT NULL,
    trigger_group TEXT NOT NULL,
    job_name  TEXT NOT NULL, 
    job_group TEXT NOT NULL,
    description TEXT NULL,
    next_fire_time BIGINT NULL,
    prev_fire_time BIGINT NULL,
    priority INTEGER NULL,
    trigger_state TEXT NOT NULL,
    trigger_type TEXT NOT NULL,
    start_time BIGINT NOT NULL,
    end_time BIGINT NULL,
    calendar_name TEXT NULL,
    misfire_instr SMALLINT NULL,
    job_data BYTEA NULL
);

CREATE TABLE IF NOT EXISTS camdaux.qrtz_simple_triggers
(
    sched_name TEXT NOT NULL,
	  trigger_name TEXT NOT NULL,
    trigger_group TEXT NOT NULL,
    repeat_count BIGINT NOT NULL,
    repeat_interval BIGINT NOT NULL,
    times_triggered BIGINT NOT NULL
);

CREATE TABLE IF NOT EXISTS camdaux.qrtz_simprop_triggers 
(
    sched_name TEXT NOT NULL,
    trigger_name TEXT NOT NULL,
    trigger_group TEXT NOT NULL,
    str_prop_1 TEXT NULL,
    str_prop_2 TEXT NULL,
    str_prop_3 TEXT NULL,
    int_prop_1 INTEGER NULL,
    int_prop_2 INTEGER NULL,
    long_prop_1 BIGINT NULL,
    long_prop_2 BIGINT NULL,
    dec_prop_1 NUMERIC NULL,
    dec_prop_2 NUMERIC NULL,
    bool_prop_1 BOOL NULL,
    bool_prop_2 BOOL NULL,
  	time_zone_id TEXT NULL
);

CREATE TABLE IF NOT EXISTS camdaux.qrtz_cron_triggers
(
    sched_name TEXT NOT NULL,
    trigger_name TEXT NOT NULL,
    trigger_group TEXT NOT NULL,
    cron_expression TEXT NOT NULL,
    time_zone_id TEXT
);

CREATE TABLE IF NOT EXISTS camdaux.qrtz_blob_triggers
(
    sched_name TEXT NOT NULL,
    trigger_name TEXT NOT NULL,
    trigger_group TEXT NOT NULL,
    blob_data BYTEA NULL
);

CREATE TABLE IF NOT EXISTS camdaux.qrtz_calendars
(
    sched_name TEXT NOT NULL,
    calendar_name  TEXT NOT NULL, 
    calendar BYTEA NOT NULL
);

CREATE TABLE IF NOT EXISTS camdaux.qrtz_paused_trigger_grps
(
    sched_name TEXT NOT NULL,
    trigger_group TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS camdaux.qrtz_fired_triggers 
(
    sched_name TEXT NOT NULL,
    entry_id TEXT NOT NULL,
    trigger_name TEXT NOT NULL,
    trigger_group TEXT NOT NULL,
    instance_name TEXT NOT NULL,
    fired_time BIGINT NOT NULL,
	  sched_time BIGINT NOT NULL,
    priority INTEGER NOT NULL,
    state TEXT NOT NULL,
    job_name TEXT NULL,
    job_group TEXT NULL,
    is_nonconcurrent BOOL NOT NULL,
    requests_recovery BOOL NULL
);

CREATE TABLE IF NOT EXISTS camdaux.qrtz_scheduler_state 
(
    sched_name TEXT NOT NULL,
    instance_name TEXT NOT NULL,
    last_checkin_time BIGINT NOT NULL,
    checkin_interval BIGINT NOT NULL
);

CREATE TABLE IF NOT EXISTS camdaux.qrtz_locks
(
    sched_name TEXT NOT NULL,
    lock_name  TEXT NOT NULL
);
