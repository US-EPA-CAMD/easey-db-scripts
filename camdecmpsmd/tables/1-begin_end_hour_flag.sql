-- Table: camdecmpsmd.begin_end_hour_flag

-- DROP TABLE camdecmpsmd.begin_end_hour_flag;

CREATE TABLE camdecmpsmd.begin_end_hour_flag
(
    begin_end_hour_flg character varying(7) COLLATE pg_catalog."default" NOT NULL,
    begin_end_hour_description character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT pk_begin_end_hour_flag PRIMARY KEY (begin_end_hour_flg)
);