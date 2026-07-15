CREATE TABLE IF NOT EXISTS camd.mv_job_last_run
(
    owner varchar(128),
    job_name varchar(128),
    last_start_date timestamp(6) with time zone,
    last_run_duration interval day(9) to second(6),
    next_run_date timestamp(6) with time zone,
    state varchar(15),
    log_id numeric,
    log_date timestamp(6) with time zone,
    operation varchar(30),
    status varchar(30),
    user_name varchar(128),
    client_id varchar(64),
    global_uid varchar(32),
    req_start_date timestamp(6) with time zone,
    actual_start_date timestamp(6) with time zone,
    run_duration interval day(3) to second(0),
    instance_id numeric,
    session_id varchar(128),
    slave_pid varchar(30),
    cpu_used interval day(3) to second(2),
    additional_info clob
);