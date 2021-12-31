CREATE TABLE IF NOT EXISTS camdecmpsmd.apportionment_type_code(
    apportionment_type_cd CHARACTER VARYING(7) NOT NULL,
    apportionment_type_description CHARACTER VARYING(100) NOT NULL
)
        WITH (
        OIDS=FALSE
        );
COMMENT ON TABLE camdecmpsmd.apportionment_type_code
     IS 'Lookup table of codes that indicate the apportionment type of an emissions report.';
COMMENT ON COLUMN camdecmpsmd.apportionment_type_code.apportionment_type_cd
     IS 'Code used to indicate the apportionment type of an emissions report.';
COMMENT ON COLUMN camdecmpsmd.apportionment_type_code.apportionment_type_description
     IS 'Description of apportionment type code.';


ALTER TABLE camdecmpsmd.apportionment_type_code
ADD CONSTRAINT apportionment_type_code_pk PRIMARY KEY (apportionment_type_cd);

ALTER TABLE camdecmpsmd.apportionment_type_code
ADD CONSTRAINT apportionment_type_code_uq UNIQUE (apportionment_type_description);