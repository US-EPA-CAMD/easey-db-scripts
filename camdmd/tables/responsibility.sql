CREATE TABLE IF NOT EXISTS camdmd.responsibility
(
    responsibility_id varchar(7) NOT NULL,
    responsibility_description varchar(400),
    group_type_cd varchar(7) NOT NULL,
    PRIMARY KEY (responsibility_id)
);
COMMENT ON TABLE camdmd.responsibility
    IS 'Lookup table of CONTACT responsibility codes.';
COMMENT ON COLUMN camdmd.responsibility.responsibility_id
    IS 'Responsibility key.';
COMMENT ON COLUMN camdmd.responsibility.responsibility_description
    IS 'Description of RESPONSIBILITY relationship.';
COMMENT ON COLUMN camdmd.responsibility.group_type_cd
    IS 'Identifies the type of group for this responsibility.';