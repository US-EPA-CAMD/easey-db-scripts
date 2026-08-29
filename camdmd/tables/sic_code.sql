CREATE TABLE IF NOT EXISTS camdmd.sic_code
(
    sic_code numeric(4,0) NOT NULL,
    sic_code_description varchar(50),
    PRIMARY KEY (sic_code)
);
COMMENT ON COLUMN camdmd.sic_code.sic_code_description
    IS 'Description of SIC Code.';