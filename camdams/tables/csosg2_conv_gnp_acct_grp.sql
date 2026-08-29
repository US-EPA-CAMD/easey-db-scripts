CREATE TABLE IF NOT EXISTS camdams.csosg2_conv_gnp_acct_grp
(
    g2_conv_gnp_acct_grp_id numeric(38,0) NOT NULL,
    g2_conv_gnp_acct_grp_name varchar(100) NOT NULL,
    userid varchar(160) NOT NULL,
    add_date timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone,
    PRIMARY KEY (g2_conv_gnp_acct_grp_id)
);
COMMENT ON TABLE camdams.csosg2_conv_gnp_acct_grp
    IS 'Stores general account grouping information related to the GNP conversion of banked CSOSG2 allowances.';
COMMENT ON COLUMN camdams.csosg2_conv_gnp_acct_grp.g2_conv_gnp_acct_grp_id
    IS 'Identity key for CSOSG2 conversion account group table.';
COMMENT ON COLUMN camdams.csosg2_conv_gnp_acct_grp.g2_conv_gnp_acct_grp_name
    IS 'Name of CSOSG2 conversion account group.';
COMMENT ON COLUMN camdams.csosg2_conv_gnp_acct_grp.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty.  Otherwise this is the user name of the person or process that made the last update.';
COMMENT ON COLUMN camdams.csosg2_conv_gnp_acct_grp.add_date
    IS 'Date the record was created.';
COMMENT ON COLUMN camdams.csosg2_conv_gnp_acct_grp.update_date
    IS 'Date of the last record update.';