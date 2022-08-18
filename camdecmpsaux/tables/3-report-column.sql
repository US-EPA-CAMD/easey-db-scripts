-- Table: camdecmpsaux.report_column

-- DROP TABLE camdecmpsaux.report_column;

CREATE TABLE camdecmpsaux.report_column
(
    report_column_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "position" integer NOT NULL,
    name text COLLATE pg_catalog."default" NOT NULL,
    display_name text COLLATE pg_catalog."default" NOT NULL,
    report_detail_id integer NOT NULL,
    CONSTRAINT pk_report_column PRIMARY KEY (report_column_id),
    CONSTRAINT fk_report_column_report_detail FOREIGN KEY (report_detail_id)
        REFERENCES camdecmpsaux.report_detail (report_detail_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);