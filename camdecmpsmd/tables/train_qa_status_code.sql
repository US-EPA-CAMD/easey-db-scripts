CREATE TABLE IF NOT EXISTS camdecmpsmd.train_qa_status_code
(
    train_qa_status_cd character varying(10) COLLATE pg_catalog.default NOT NULL,
    train_qa_status_description character varying(1000) COLLATE pg_catalog.default NOT NULL
);

COMMENT ON TABLE camdecmpsmd.train_qa_status_code
    IS 'Lookup table of sampling train QA status. ';

COMMENT ON COLUMN camdecmpsmd.train_qa_status_code.train_qa_status_cd
    IS 'Code used to identify sampling train QA status. ';

COMMENT ON COLUMN camdecmpsmd.train_qa_status_code.train_qa_status_description
    IS 'Description of a sampling train QA status. ';