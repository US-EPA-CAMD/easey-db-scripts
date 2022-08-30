-- Table: camdecmpsaux.report_parameter

-- DROP TABLE camdecmpsaux.report_parameter;

CREATE TABLE camdecmpsaux.report_parameter
(
    report_parameter_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    sequence_number integer NOT NULL,
    name text COLLATE pg_catalog."default" NOT NULL,
    default_value text COLLATE pg_catalog."default",
    report_detail_id integer NOT NULL,
    CONSTRAINT pk_report_parameter PRIMARY KEY (report_parameter_id),
    CONSTRAINT fk_report_parameter_report_detail FOREIGN KEY (report_detail_id)
        REFERENCES camdecmpsaux.report_detail (report_detail_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);