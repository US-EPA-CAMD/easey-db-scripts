ALTER TABLE IF EXISTS camdecmpsmd.qa_cert_event_code
    ADD CONSTRAINT pk_qa_cert_event_code PRIMARY KEY (qa_cert_event_cd),
    ADD CONSTRAINT uq_qa_cert_event_code_description UNIQUE (qa_cert_event_cd_description);
