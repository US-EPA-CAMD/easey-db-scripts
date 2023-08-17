-- Table: camdecmpsmd.rule_check_condition

-- DROP TABLE camdecmpsmd.rule_check_condition;

CREATE TABLE IF NOT EXISTS camdecmpsmd.rule_check_condition
(
    rule_check_condition_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    rule_check_id integer NOT NULL,
    and_group_no integer NOT NULL,
    check_param_id integer NOT NULL,
    check_operator_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    check_condition character varying(100) COLLATE pg_catalog."default",
    negation_ind integer,
    CONSTRAINT pk_rule_check_condition PRIMARY KEY (rule_check_condition_id),
    CONSTRAINT fk_rule_check_condition_check_operator_code FOREIGN KEY (check_operator_cd)
        REFERENCES camdecmpsmd.check_operator_code (check_operator_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_rule_check_condition_check_parameter_code FOREIGN KEY (check_param_id)
        REFERENCES camdecmpsmd.check_parameter_code (check_param_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_rule_check_condition_rule_check FOREIGN KEY (rule_check_id)
        REFERENCES camdecmpsmd.rule_check (rule_check_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);