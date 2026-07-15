CREATE TABLE IF NOT EXISTS camdmd.person_type_group_code
(
    person_type_group_cd varchar(7) NOT NULL,
    person_type_group_description varchar(1000) NOT NULL,
    PRIMARY KEY (person_type_group_cd)
);
COMMENT ON TABLE camdmd.person_type_group_code
    IS 'Lookup table containing codes that indicates the person type group for person type.';
COMMENT ON COLUMN camdmd.person_type_group_code.person_type_group_cd
    IS 'The code that indicates the person type group for person type.';
COMMENT ON COLUMN camdmd.person_type_group_code.person_type_group_description
    IS 'The description of the person type group.';