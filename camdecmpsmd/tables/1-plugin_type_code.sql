-- Table: camdecmpsmd.plugin_type_code

-- DROP TABLE camdecmpsmd.plugin_type_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.plugin_type_code
(
    plugin_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    plugin_type_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_plugin_type_code PRIMARY KEY (plugin_type_cd)
);