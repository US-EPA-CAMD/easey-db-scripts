CREATE TABLE IF NOT EXISTS camd.cdx_user
(
    cdx_user_id varchar(160) NOT NULL,
    first_name varchar(25) NOT NULL,
    last_name varchar(25) NOT NULL,
    ppl_id numeric(38,0),
    middle_initial varchar(1),
    suffix varchar(8),
    userid varchar(160) NOT NULL,
    add_date timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone,
    PRIMARY KEY (cdx_user_id)
);
COMMENT ON TABLE camd.cdx_user
    IS 'The CDX_USER table stores necessary information on all CDX Users who visited CBS.';
COMMENT ON COLUMN camd.cdx_user.cdx_user_id
    IS 'CDX_USER user identity key.';
COMMENT ON COLUMN camd.cdx_user.first_name
    IS 'The first name of the cdx user.';
COMMENT ON COLUMN camd.cdx_user.last_name
    IS 'The last name of the cdx user.';
COMMENT ON COLUMN camd.cdx_user.ppl_id
    IS 'The corresponding PPL_ID of the cdx user.';
COMMENT ON COLUMN camd.cdx_user.middle_initial
    IS 'The middle initial of the cdx user.';
COMMENT ON COLUMN camd.cdx_user.suffix
    IS 'The suffix of the cdx user name.';
COMMENT ON COLUMN camd.cdx_user.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty. Otherwise this is the user name of the person or process that made the last update.';
COMMENT ON COLUMN camd.cdx_user.add_date
    IS 'The add date of the cdx user record.';
COMMENT ON COLUMN camd.cdx_user.update_date
    IS 'The update date of the cdx user record.';