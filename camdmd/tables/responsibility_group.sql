CREATE TABLE IF NOT EXISTS camdmd.responsibility_group
(
    responsibility_group_id numeric(38,0) NOT NULL,
    responsibility_id varchar(7) NOT NULL,
    person_type_group_cd varchar(7) NOT NULL,
    active_ind numeric(1,0) NOT NULL DEFAULT 1,
    PRIMARY KEY (responsibility_group_id)
);
COMMENT ON TABLE camdmd.responsibility_group
    IS 'Cross check table of responsibility and person type group values.';
COMMENT ON COLUMN camdmd.responsibility_group.responsibility_group_id
    IS 'Responsibility Group id.';
COMMENT ON COLUMN camdmd.responsibility_group.responsibility_id
    IS 'Responsibility key.';
COMMENT ON COLUMN camdmd.responsibility_group.person_type_group_cd
    IS 'The code that indicates the person type group for person type.';
COMMENT ON COLUMN camdmd.responsibility_group.active_ind
    IS 'Indicates whether the responsibility is active.';