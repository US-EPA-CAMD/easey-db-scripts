CREATE TABLE IF NOT EXISTS camd.cdx_role
(
    cdx_role_id numeric(38,0) NOT NULL,
    cdx_role_description varchar(1000) NOT NULL,
    active_ind numeric(1,0) NOT NULL DEFAULT 1,
    userid varchar(160) NOT NULL,
    add_date timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone,
    cdx_role_cd varchar(1000),
    open_ind numeric(1,0) DEFAULT 1,
    PRIMARY KEY (cdx_role_id)
);
COMMENT ON TABLE camd.cdx_role
    IS 'The CDX_ORG table stores necessary information on all CDX organizations.';
COMMENT ON COLUMN camd.cdx_role.cdx_role_id
    IS 'CDX_ROLE table identity key.';
COMMENT ON COLUMN camd.cdx_role.cdx_role_description
    IS 'The description of the CDX role.';
COMMENT ON COLUMN camd.cdx_role.active_ind
    IS 'the active status of the CDX role';
COMMENT ON COLUMN camd.cdx_role.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty. Otherwise this is the user name of the person or process that made the last update.';
COMMENT ON COLUMN camd.cdx_role.add_date
    IS 'The add date of the cdx role record.';
COMMENT ON COLUMN camd.cdx_role.update_date
    IS 'The update date of the cdx role record.';
COMMENT ON COLUMN camd.cdx_role.cdx_role_cd
    IS 'The role code of the CDX role.';
COMMENT ON COLUMN camd.cdx_role.open_ind
    IS 'the open/close status indicator of the CDX role';