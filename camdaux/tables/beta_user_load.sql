CREATE TABLE IF NOT EXISTS camdaux.beta_user_load
(
    first_name varchar(100) NOT NULL,
    last_name varchar(100) NOT NULL,
    user_id varchar(160) NOT NULL,
    organization varchar(100) NOT NULL,
    email varchar(100) NOT NULL,
    flow varchar(10) NOT NULL,
    plant_list varchar(4000),
    ppl_id numeric(38,0),
    PRIMARY KEY (user_id)
);