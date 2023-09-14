CREATE TABLE IF NOT EXISTS camdmd.tribal_land_code
    ADD CONSTRAINT pk_tribal_land_code PRIMARY KEY (tribal_land_cd),
    ADD CONSTRAINT uq_tribal_land_code_description UNIQUE (tribal_land_description);