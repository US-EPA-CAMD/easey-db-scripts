ALTER TABLE IF EXISTS camdecmpsmd.train_qa_status_code
    ADD CONSTRAINT pk_train_qa_status_code PRIMARY KEY (train_qa_status_cd),
    ADD CONSTRAINT uq_train_qa_status_code_description UNIQUE (train_qa_status_description);
