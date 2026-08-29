CREATE TABLE IF NOT EXISTS camdmd.eta_characteristic_code
(
    eta_characteristic_cd varchar(7) NOT NULL,
    eta_characteristic_description varchar(1000) NOT NULL,
    eta_characteristic_alias varchar(30) NOT NULL,
    value_list_ind numeric(1,0) NOT NULL,
    grouping_display_order numeric(2,0),
    filtering_display_order numeric(2,0),
    PRIMARY KEY (eta_characteristic_cd)
);
COMMENT ON TABLE camdmd.eta_characteristic_code
    IS 'Contains codes indicating unit characteristics supported by ETA and how they are supported.';
COMMENT ON COLUMN camdmd.eta_characteristic_code.eta_characteristic_cd
    IS 'Primary key indicating unit characteristics supported by ETA.';
COMMENT ON COLUMN camdmd.eta_characteristic_code.eta_characteristic_description
    IS 'Description of a unit characteristics supported by ETA.';
COMMENT ON COLUMN camdmd.eta_characteristic_code.eta_characteristic_alias
    IS 'Table alias of a unit characteristics supported by ETA.';
COMMENT ON COLUMN camdmd.eta_characteristic_code.value_list_ind
    IS 'Indicates whether the characteristic can contain multiple values for a unique unit and quarter combination.';
COMMENT ON COLUMN camdmd.eta_characteristic_code.grouping_display_order
    IS 'Determines the display order of a characteristic when displayed for groupiing.  A null results in not displaying the characteristic.';
COMMENT ON COLUMN camdmd.eta_characteristic_code.filtering_display_order
    IS 'Determines the display order of a characteristic when displayed for filtering.  A null results in not displaying the characteristic.';