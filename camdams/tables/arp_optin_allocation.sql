CREATE TABLE IF NOT EXISTS camdams.arp_optin_allocation
(
    unit_id numeric(38,0) NOT NULL,
    first_optin_year numeric(4,0) NOT NULL,
    first_year_value numeric(6,0) NOT NULL,
    subsequent_year_value numeric(6,0) NOT NULL,
    userid varchar(160) NOT NULL,
    add_date timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone,
    PRIMARY KEY (unit_id)
);
COMMENT ON TABLE camdams.arp_optin_allocation
    IS 'Identifies the unit details for ARP optin allocation.';
COMMENT ON COLUMN camdams.arp_optin_allocation.unit_id
    IS 'Identity key for UNIT table.';
COMMENT ON COLUMN camdams.arp_optin_allocation.first_optin_year
    IS 'First Year a unit participated in a program as an opt in unit.';
COMMENT ON COLUMN camdams.arp_optin_allocation.first_year_value
    IS 'Number of allowances allocated to the unit for its first opt in year.';
COMMENT ON COLUMN camdams.arp_optin_allocation.subsequent_year_value
    IS 'Number of allowances allocated to the unit during subsequent years.';
COMMENT ON COLUMN camdams.arp_optin_allocation.userid
    IS 'User account or source of data that added or updated record.';
COMMENT ON COLUMN camdams.arp_optin_allocation.add_date
    IS 'Date and time in which record was added.';
COMMENT ON COLUMN camdams.arp_optin_allocation.update_date
    IS 'Date and time in which record was last updated.';