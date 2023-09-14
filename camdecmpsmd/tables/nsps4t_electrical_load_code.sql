CREATE TABLE IF NOT EXISTS camdecmpsmd.nsps4t_electrical_load_code
(
    electrical_load_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    electrical_load_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.nsps4t_electrical_load_code
    IS 'NSPS4T (quarterly) Summary Information. ';

COMMENT ON COLUMN camdecmpsmd.nsps4t_electrical_load_code.electrical_load_cd
    IS 'Code used to identify the NSPS4T Energy Output.';

COMMENT ON COLUMN camdecmpsmd.nsps4t_electrical_load_code.electrical_load_description
    IS 'Description of the NSPS4T  Energy Output.';