-- Table: camdecmpsmd.qa_cert_event_code

-- DROP TABLE camdecmpsmd.qa_cert_event_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.qa_cert_event_code
(
    qa_cert_event_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    qa_cert_event_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    qa_cert_category character varying(7) COLLATE pg_catalog."default",
    CONSTRAINT pk_qa_cert_event_code PRIMARY KEY (qa_cert_event_cd)
);

COMMENT ON TABLE camdecmpsmd.qa_cert_event_code
    IS 'Lookup table of QA and certification event codes.';

COMMENT ON COLUMN camdecmpsmd.qa_cert_event_code.qa_cert_event_cd
    IS 'Code used to identify QA and certification event. ';

COMMENT ON COLUMN camdecmpsmd.qa_cert_event_code.qa_cert_event_cd_description
    IS 'Description of QA cert event code. ';

COMMENT ON COLUMN camdecmpsmd.qa_cert_event_code.qa_cert_category
    IS 'Identifies the groups of event codes that make up an Initial or Recertification event. ';