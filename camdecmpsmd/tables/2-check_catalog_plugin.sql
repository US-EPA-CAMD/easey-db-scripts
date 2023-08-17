-- Table: camdecmpsmd.check_catalog_plugin

-- DROP TABLE camdecmpsmd.check_catalog_plugin;

CREATE TABLE IF NOT EXISTS camdecmpsmd.check_catalog_plugin
(
    check_catalog_plugin_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    plugin_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    check_catalog_id integer NOT NULL,
    plugin_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    check_param_id integer,
    field_name character varying(100) COLLATE pg_catalog."default",
    CONSTRAINT pk_check_catalog_plugin PRIMARY KEY (check_catalog_plugin_id),
    CONSTRAINT fk_check_catalog_plugin_check_catalog FOREIGN KEY (check_catalog_id)
        REFERENCES camdecmpsmd.check_catalog (check_catalog_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_check_catalog_plugin_plugin_type_code FOREIGN KEY (plugin_type_cd)
        REFERENCES camdecmpsmd.plugin_type_code (plugin_type_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- Index: uq_check_catalog_plugin_check_catalog_plugin_name

-- DROP INDEX camdecmpsmd.uq_check_catalog_plugin_check_catalog_plugin_name;

CREATE UNIQUE INDEX IF NOT EXISTS uq_check_catalog_plugin_check_catalog_plugin_name
    ON camdecmpsmd.check_catalog_plugin USING btree
    (check_catalog_id ASC NULLS LAST, plugin_name COLLATE pg_catalog."default" ASC NULLS LAST);
