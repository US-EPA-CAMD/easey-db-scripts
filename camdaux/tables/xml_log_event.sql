CREATE TABLE IF NOT EXISTS camdaux.xml_log_event
(
    key raw(1000) NOT NULL,
    rid rowid,
    account_id varchar(4000),
    account_number varchar(4000),
    issued_amount numeric,
    person_id numeric,
    plant_id numeric,
    submission_id numeric,
    trans_id numeric,
    PRIMARY KEY (key)
);