ALTER TABLE camdecmpswks.monitor_plan
    ADD COLUMN eval_status_cd character varying(7) NOT NULL DEFAULT 'EVAL';

ALTER TABLE camdecmpswks.qa_cert_event
    ADD COLUMN eval_status_cd character varying(7) NOT NULL DEFAULT 'EVAL';

ALTER TABLE camdecmpswks.test_extension_exemption
    ADD COLUMN eval_status_cd character varying(7) NOT NULL DEFAULT 'EVAL';

ALTER TABLE camdecmpswks.test_summary
    ADD COLUMN eval_status_cd character varying(7) NOT NULL DEFAULT 'EVAL';


ALTER TABLE IF EXISTS camdecmpswks.monitor_plan
    ADD CONSTRAINT fk_monitor_plan_eval_status_code FOREIGN KEY (eval_status_cd)
    REFERENCES camdecmpsmd.eval_status_code (eval_status_cd) MATCH SIMPLE;

ALTER TABLE IF EXISTS camdecmpswks.qa_cert_event
    ADD CONSTRAINT fk_qa_cert_event_eval_status_code FOREIGN KEY (eval_status_cd)
    REFERENCES camdecmpsmd.eval_status_code (eval_status_cd) MATCH SIMPLE;

ALTER TABLE IF EXISTS camdecmpswks.test_extension_exemption
    ADD CONSTRAINT fk_test_extension_exemption_eval_status_code FOREIGN KEY (eval_status_cd)
    REFERENCES camdecmpsmd.eval_status_code (eval_status_cd) MATCH SIMPLE;

ALTER TABLE IF EXISTS camdecmpswks.test_summary
    ADD CONSTRAINT fk_test_summary_eval_status_code FOREIGN KEY (eval_status_cd)
    REFERENCES camdecmpsmd.eval_status_code (eval_status_cd) MATCH SIMPLE;