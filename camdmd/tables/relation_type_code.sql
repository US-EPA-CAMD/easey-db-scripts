CREATE TABLE IF NOT EXISTS camdmd.relation_type_code
(
    relation_type_cd varchar(7) NOT NULL,
    relation_description varchar(100),
    ecmps_access_type varchar(1),
    ecmps_access_level numeric,
    PRIMARY KEY (relation_type_cd)
);
COMMENT ON TABLE camdmd.relation_type_code
    IS 'Lookup table that identifies the relationship type between two PEOPLE.';
COMMENT ON COLUMN camdmd.relation_type_code.relation_type_cd
    IS 'Lookup code which defines the scope of the relationship or agent responsibilities.';
COMMENT ON COLUMN camdmd.relation_type_code.relation_description
    IS 'Text description of responsibility type for agents.';
COMMENT ON COLUMN camdmd.relation_type_code.ecmps_access_type
    IS 'ECMPS agent type (retrieve or submit).';
COMMENT ON COLUMN camdmd.relation_type_code.ecmps_access_level
    IS 'Hierarchy of ECMPS agent levels.';