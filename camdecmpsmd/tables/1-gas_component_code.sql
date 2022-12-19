-- Table: camdecmpsmd.gas_component_code

-- DROP TABLE camdecmpsmd.gas_component_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.gas_component_code
(
    gas_component_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    gas_component_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    can_combine_ind smallint NOT NULL,
    balance_component_ind smallint NOT NULL DEFAULT 0,
    CONSTRAINT pk_gas_component_code PRIMARY KEY (gas_component_cd)
);