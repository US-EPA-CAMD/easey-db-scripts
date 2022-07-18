-- Table: camdecmpsmd.nsps4t_electrical_load_code

-- DROP TABLE IF EXISTS camdecmpsmd.nsps4t_electrical_load_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.nsps4t_electrical_load_code
(
    electrical_load_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    electrical_load_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_nsps4t_electrical_load PRIMARY KEY (electrical_load_cd),
    CONSTRAINT uq_nsps4t_electrical_load UNIQUE (electrical_load_description)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS camdecmpsmd.nsps4t_electrical_load_code
    OWNER to "uImcwuf4K9dyaxeL";

COMMENT ON TABLE camdecmpsmd.nsps4t_electrical_load_code
    IS 'NSPS4T (quarterly) Summary Information. ';

COMMENT ON COLUMN camdecmpsmd.nsps4t_electrical_load_code.electrical_load_cd
    IS 'Code used to identify the NSPS4T Energy Output.';

COMMENT ON COLUMN camdecmpsmd.nsps4t_electrical_load_code.electrical_load_description
    IS 'Description of the NSPS4T  Energy Output.';