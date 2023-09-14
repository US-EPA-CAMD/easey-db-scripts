CREATE TABLE IF NOT EXISTS camdecmpsmd.rule_check_condition
(
    rule_check_condition_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    rule_check_id integer NOT NULL,
    and_group_no integer NOT NULL,
    check_param_id integer NOT NULL,
    check_operator_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    check_condition character varying(100) COLLATE pg_catalog."default",
    negation_ind integer
);