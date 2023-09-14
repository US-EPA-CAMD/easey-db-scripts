ALTER TABLE IF EXISTS camdecmpsmd.qual_lee_test_type_code
    ADD CONSTRAINT pk_qual_lee_test_type_code PRIMARY KEY (qual_lee_test_type_cd),
    ADD CONSTRAINT uq_qual_lee_test_type_code_description UNIQUE (qual_lee_test_type_description);
