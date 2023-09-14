CREATE TABLE IF NOT EXISTS camdecmpsmd.system_designation_code
(
    sys_designation_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    sys_designation_cd_description character varying(1000) COLLATE pg_catalog."default"
);

COMMENT ON TABLE camdecmpsmd.system_designation_code
    IS 'Types of monitoring systems as defined in the EDR instruction.  Primary/ Secondary Designation';

COMMENT ON COLUMN camdecmpsmd.system_designation_code.sys_designation_cd
    IS 'Code used to indicate designation of monitoring system as primary, backup etc. ';

COMMENT ON COLUMN camdecmpsmd.system_designation_code.sys_designation_cd_description
    IS 'Description of lookup code. ';