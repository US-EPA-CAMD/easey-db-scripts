CREATE TABLE IF NOT EXISTS camdams.nbp_to_cairos_tmp
(
    nats_account_number varchar(12) NOT NULL,
    nats_account_type_cd varchar(7),
    ams_account_number varchar(12),
    ams_account_type_cd varchar(7),
    nats_account_name varchar(100),
    ams_account_name varchar(100)
);