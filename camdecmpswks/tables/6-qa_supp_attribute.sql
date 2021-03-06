-- Table: camdecmpswks.qa_supp_attribute

-- DROP TABLE camdecmpswks.qa_supp_attribute;

CREATE TABLE IF NOT EXISTS camdecmpswks.qa_supp_attribute
(
    qa_supp_attribute_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    qa_supp_data_id character varying(45) COLLATE pg_catalog."default",
    attribute_name character varying(30) COLLATE pg_catalog."default",
    attribute_value character varying(30) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_qa_supp_attribute PRIMARY KEY (qa_supp_attribute_id),
    CONSTRAINT fk_qa_supp_attribute_qa_supp_data FOREIGN KEY (qa_supp_data_id)
        REFERENCES camdecmpswks.qa_supp_data (qa_supp_data_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- -- Index: qa_supp_attribute_idx001

-- -- DROP INDEX camdecmpswks.qa_supp_attribute_idx001;

-- CREATE INDEX qa_supp_attribute_idx001
--     ON camdecmpswks.qa_supp_attribute USING btree
--     (qa_supp_data_id COLLATE pg_catalog."default" ASC NULLS LAST);
