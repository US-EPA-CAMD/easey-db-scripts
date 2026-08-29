CREATE TABLE IF NOT EXISTS camdams.scheduler$_job_arg
(
    job_name varchar(128),
    arg_name varchar(128),
    arg_position numeric,
    value sys.anydata,
    flags numeric,
    enabled varchar(1)
);