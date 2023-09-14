CREATE TABLE IF NOT EXISTS camdecmpswks.qa_supp_attribute
(
    qa_supp_attribute_id character varying(45) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v4(),
    qa_supp_data_id character varying(45) COLLATE pg_catalog."default",
    attribute_name character varying(30) COLLATE pg_catalog."default",
    attribute_value character varying(30) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);
