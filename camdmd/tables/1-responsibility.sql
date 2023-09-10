CREATE TABLE IF NOT EXISTS camdmd.responsibility
(
    responsibility_id character varying(7) COLLATE pg_catalog."default" NOT NULL,
    responsibility_description character varying(400) COLLATE pg_catalog."default",
    group_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_responsibility PRIMARY KEY (responsibility_id)
);

COMMENT ON TABLE camdmd.responsibility
    IS 'Lookup table of CONTACT responsibility codes.';

COMMENT ON COLUMN camdmd.responsibility.responsibility_id
    IS 'Responsibility key.';

COMMENT ON COLUMN camdmd.responsibility.responsibility_description
    IS 'Description of RESPONSIBILITY relationship.';

COMMENT ON COLUMN camdmd.responsibility.group_type_cd
    IS 'Identifies the type of group for this responsibility.';