CREATE TABLE IF NOT EXISTS camdecmpsmd.equation_code
(
    equation_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    equation_cd_description character varying(1000) COLLATE pg_catalog."default",
    moisture_ind numeric(38,0)
);

COMMENT ON TABLE camdecmpsmd.equation_code
    IS 'The equation number assigned in part 75 to the formula used to calculate the parameter. Record Type 520.';

COMMENT ON COLUMN camdecmpsmd.equation_code.equation_cd
    IS 'Code used to identify the equation defined in part 75. ';

COMMENT ON COLUMN camdecmpsmd.equation_code.equation_cd_description
    IS 'Description of lookup code. ';

COMMENT ON COLUMN camdecmpsmd.equation_code.moisture_ind
    IS 'Indicates whether moisture is a factor in the equation. ';