-- Table: camdecmpsmd.acquisition_method_code

-- DROP TABLE camdecmpsmd.acquisition_method_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.acquisition_method_code
(
    acq_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    acq_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_acquisition_method_code PRIMARY KEY (acq_cd)
);

COMMENT ON TABLE camdecmpsmd.acquisition_method_code
    IS 'Lookup table of methods used by the component to acquire samples of the measured parameter. Record Type 510.';

COMMENT ON COLUMN camdecmpsmd.acquisition_method_code.acq_cd
    IS 'Code used to identify the sample acquisition method. ';

COMMENT ON COLUMN camdecmpsmd.acquisition_method_code.acq_cd_description
    IS 'Description of lookup code. ';