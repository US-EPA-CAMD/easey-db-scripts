CREATE TABLE IF NOT EXISTS camdmd.nox_comp_plan_type_code
(
    comp_plan_type_cd varchar(7) NOT NULL,
    comp_plan_type_cd_description varchar(1000) NOT NULL,
    PRIMARY KEY (comp_plan_type_cd)
);
COMMENT ON TABLE camdmd.nox_comp_plan_type_code
    IS 'Lookup table for NOx compliance plan type cd.';
COMMENT ON COLUMN camdmd.nox_comp_plan_type_code.comp_plan_type_cd
    IS 'ARP NOx compliance plan type code.';
COMMENT ON COLUMN camdmd.nox_comp_plan_type_code.comp_plan_type_cd_description
    IS 'Full description of ARP NOx compliance plan type code.';