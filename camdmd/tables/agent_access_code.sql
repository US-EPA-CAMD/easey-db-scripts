CREATE TABLE IF NOT EXISTS camdmd.agent_access_code
(
    relation_type_cd varchar(7) NOT NULL,
    ecmps_access_type varchar(1) NOT NULL,
    ecmps_access_level numeric NOT NULL,
    access_code_description varchar(100) NOT NULL,
    PRIMARY KEY (relation_type_cd)
);
COMMENT ON TABLE camdmd.agent_access_code
    IS 'Lookup table for relation_type_cds associated with ECMPS.';
COMMENT ON COLUMN camdmd.agent_access_code.relation_type_cd
    IS 'Lookup code which defines the scope of the relationship or agent responsibilities.';
COMMENT ON COLUMN camdmd.agent_access_code.ecmps_access_type
    IS 'ECMPS agent type (retrieve or submit).';
COMMENT ON COLUMN camdmd.agent_access_code.ecmps_access_level
    IS 'Hierarchy of ECMPS agent levels.';
COMMENT ON COLUMN camdmd.agent_access_code.access_code_description
    IS 'Text description of rights granted to ECMPS RELATION_TYPE_CODES.';