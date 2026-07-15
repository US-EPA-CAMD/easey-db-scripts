CREATE TABLE IF NOT EXISTS camdmd.eta_period_type_code
(
    eta_period_type_cd varchar(7) NOT NULL,
    eta_period_type_description varchar(1000) NOT NULL,
    display_order numeric DEFAULT null,
    PRIMARY KEY (eta_period_type_cd)
);
COMMENT ON TABLE camdmd.eta_period_type_code
    IS 'Contains codes indicating periods to which ETA data applies.';
COMMENT ON COLUMN camdmd.eta_period_type_code.eta_period_type_cd
    IS 'Primary key that indicates the period type to which ETA data applies.';
COMMENT ON COLUMN camdmd.eta_period_type_code.eta_period_type_description
    IS 'Description of the period to which ETA data applies.';
COMMENT ON COLUMN camdmd.eta_period_type_code.display_order
    IS 'Indicates both that the period type is used as a report type, and the display order when selected as a report type.';