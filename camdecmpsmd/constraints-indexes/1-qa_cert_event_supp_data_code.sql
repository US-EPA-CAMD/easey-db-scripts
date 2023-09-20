ALTER TABLE IF EXISTS camdecmpsmd.qa_cert_event_supp_data_code
    ADD CONSTRAINT pk_qa_cert_event_supp_data_code PRIMARY KEY (qa_cert_event_supp_data_cd),
    ADD CONSTRAINT uq_qa_cert_event_supp_data_code_description UNIQUE (qa_cert_event_supp_data_desc);
