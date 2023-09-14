ALTER TABLE IF EXISTS camdmd.exemption_type_code
    ADD CONSTRAINT pk_exemption_type_code PRIMARY KEY (exemption_type_cd),
    ADD CONSTRAINT uq_exemption_type_code_description UNIQUE (exemption_type_description);
