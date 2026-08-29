CREATE TABLE IF NOT EXISTS camdaux.cdx_user_load
(
    role_id varchar(50),
    program_id varchar(50),
    dataflow varchar(50),
    user_id varchar(160),
    cdx_role varchar(50),
    name_title varchar(50),
    first_name varchar(50),
    last_name varchar(50),
    name_suffix varchar(50),
    organization_name varchar(50),
    address1 varchar(50),
    address2 varchar(50),
    city varchar(50),
    state varchar(50),
    zip_code integer,
    phone integer,
    phone_extension varchar(50),
    email varchar(50),
    epa_registry_id varchar(50)
);