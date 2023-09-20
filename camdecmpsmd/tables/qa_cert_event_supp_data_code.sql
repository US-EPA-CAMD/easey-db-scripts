CREATE TABLE IF NOT EXISTS camdecmpsmd.qa_cert_event_supp_data_code
(
    qa_cert_event_supp_data_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    qa_cert_event_supp_data_desc character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.qa_cert_event_supp_data_code
    IS 'Lookup table for QA certification event supplemental data type.';

COMMENT ON COLUMN camdecmpsmd.qa_cert_event_supp_data_code.qa_cert_event_supp_data_cd
    IS 'Code used to identify the QA certification event supplemental data type.';

COMMENT ON COLUMN camdecmpsmd.qa_cert_event_supp_data_code.qa_cert_event_supp_data_desc
    IS 'Description of lookup code.';