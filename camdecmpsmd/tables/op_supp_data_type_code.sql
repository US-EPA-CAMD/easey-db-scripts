CREATE TABLE IF NOT EXISTS camdecmpsmd.op_supp_data_type_code
(
    op_supp_data_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    op_supp_data_type_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.op_supp_data_type_code
    IS 'Lookup table for operating supplemental data type.';

COMMENT ON COLUMN camdecmpsmd.op_supp_data_type_code.op_supp_data_type_cd
    IS 'Code used to identify the operating supplemental data type.';

COMMENT ON COLUMN camdecmpsmd.op_supp_data_type_code.op_supp_data_type_description
    IS 'Description of lookup code.';