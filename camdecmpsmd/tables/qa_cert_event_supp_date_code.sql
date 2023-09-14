CREATE TABLE IF NOT EXISTS camdecmpsmd.qa_cert_event_supp_date_code
(
    qa_cert_event_supp_date_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    qa_cert_event_supp_date_desc character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.qa_cert_event_supp_date_code
    IS 'Lookup table for QA certification event supplemental datehour column and whether to use date or date/hour..';

COMMENT ON COLUMN camdecmpsmd.qa_cert_event_supp_date_code.qa_cert_event_supp_date_cd
    IS 'Code used to identify between date or date/hour.';

COMMENT ON COLUMN camdecmpsmd.qa_cert_event_supp_date_code.qa_cert_event_supp_date_desc
    IS 'Description of lookup code.';