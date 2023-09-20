ALTER TABLE IF EXISTS camdecmpsmd.rule_check_condition
    ADD CONSTRAINT pk_rule_check_condition PRIMARY KEY (rule_check_condition_id),
    ADD CONSTRAINT fk_rule_check_condition_check_operator_code FOREIGN KEY (check_operator_cd)
        REFERENCES camdecmpsmd.check_operator_code (check_operator_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_rule_check_condition_check_parameter_code FOREIGN KEY (check_param_id)
        REFERENCES camdecmpsmd.check_parameter_code (check_param_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_rule_check_condition_rule_check FOREIGN KEY (rule_check_id)
        REFERENCES camdecmpsmd.rule_check (rule_check_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_rule_check_condition_check_operator_cd
    ON camdecmpsmd.rule_check_condition USING btree
    (check_operator_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_rule_check_condition_check_param_id
    ON camdecmpsmd.rule_check_condition USING btree
    (check_param_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_rule_check_condition_rule_check_id
    ON camdecmpsmd.rule_check_condition USING btree
    (rule_check_id ASC NULLS LAST);