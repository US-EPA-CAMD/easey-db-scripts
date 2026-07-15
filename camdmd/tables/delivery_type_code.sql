CREATE TABLE IF NOT EXISTS camdmd.delivery_type_code
(
    delivery_type_cd varchar(7) NOT NULL,
    delivery_type_description varchar(1000) NOT NULL,
    PRIMARY KEY (delivery_type_cd)
);
COMMENT ON TABLE camdmd.delivery_type_code
    IS 'Lookup table containing codes that indicates the delivery type for emails.';
COMMENT ON COLUMN camdmd.delivery_type_code.delivery_type_cd
    IS 'The code that indicates the delivery type for emails.';
COMMENT ON COLUMN camdmd.delivery_type_code.delivery_type_description
    IS 'The description of the delivery type.';