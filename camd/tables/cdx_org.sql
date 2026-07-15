CREATE TABLE IF NOT EXISTS camd.cdx_org
(
    cdx_org_id numeric(38,0) NOT NULL,
    cdx_org_name varchar(100) NOT NULL,
    userid varchar(160) NOT NULL,
    add_date timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone,
    PRIMARY KEY (cdx_org_id)
);
COMMENT ON TABLE camd.cdx_org
    IS 'The CDX_ORG table stores necessary information on all CDX organizations.';
COMMENT ON COLUMN camd.cdx_org.cdx_org_id
    IS 'CDX_ORG table identity key.';
COMMENT ON COLUMN camd.cdx_org.cdx_org_name
    IS 'The name of the CDX organization.';
COMMENT ON COLUMN camd.cdx_org.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty. Otherwise this is the user name of the person or process that made the last update.';
COMMENT ON COLUMN camd.cdx_org.add_date
    IS 'The add date of the cdx organization record.';
COMMENT ON COLUMN camd.cdx_org.update_date
    IS 'The update date of the cdx organization record.';