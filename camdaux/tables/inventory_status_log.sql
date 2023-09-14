CREATE TABLE IF EXISTS camdaux.inventory_status_log
(
    inventory_status_log_id numeric(38,0) NOT NULL,
    fac_id numeric(38,0) NOT NULL,
    unit_id numeric(38,0) NOT NULL,
    data_type_cd character varying(160) NOT NULL,
    userid character varying(160) NOT NULL,
    last_updated timestamp without time zone NOT NULL DEFAULT timezone('est'::text, CURRENT_TIMESTAMP) NOT NULL
);
