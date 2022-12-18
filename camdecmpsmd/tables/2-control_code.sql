-- Table: camdecmpsmd.control_code

-- DROP TABLE camdecmpsmd.control_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.control_code
(
    control_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    control_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    control_equip_param_cd character varying(7) COLLATE pg_catalog."default",
    CONSTRAINT pk_control_code PRIMARY KEY (control_cd),
    CONSTRAINT uq_control_desc UNIQUE (control_description),
    CONSTRAINT fk_control_code_equip_param FOREIGN KEY (control_equip_param_cd)
        REFERENCES camdecmpsmd.control_equip_param_code (control_equip_param_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmpsmd.control_code
    IS 'Lookup table of control types.';

COMMENT ON COLUMN camdecmpsmd.control_code.control_cd
    IS 'Codes for identifying type of control equipment.';

COMMENT ON COLUMN camdecmpsmd.control_code.control_description
    IS 'Description of control equipment codes.';

COMMENT ON COLUMN camdecmpsmd.control_code.control_equip_param_cd
    IS 'Identifies control type.';

-- Index: idx_control_code_equip_param

-- DROP INDEX camdecmpsmd.idx_control_code_equip_param;

CREATE INDEX IF NOT EXISTS idx_control_code_equip_param
    ON camdecmpsmd.control_code USING btree
    (control_equip_param_cd COLLATE pg_catalog."default" ASC NULLS LAST);
