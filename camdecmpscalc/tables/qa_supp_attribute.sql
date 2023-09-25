CREATE TABLE IF NOT EXISTS camdecmpscalc.qa_supp_attribute
(
	  pk integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    chk_session_id character varying(45) NOT NULL,
    test_sum_id character varying(45) NOT NULL,
    attribute_name character varying(30),
    attribute_value character varying(30)
);
