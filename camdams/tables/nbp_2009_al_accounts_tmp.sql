CREATE TABLE IF NOT EXISTS camdams.nbp_2009_al_accounts_tmp
(
    nats_account_number varchar(12) NOT NULL,
    nats_account_type_cd varchar(7) NOT NULL,
    ams_account_number varchar(12),
    ams_account_type_cd varchar(7),
    nats_account_name varchar(100) NOT NULL,
    ams_account_name varchar(100)
);