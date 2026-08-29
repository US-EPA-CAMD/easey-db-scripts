CREATE TABLE IF NOT EXISTS camdmd.payment_method_code
(
    payment_method_cd varchar(7) NOT NULL,
    payment_method_cd_description varchar(1000) NOT NULL,
    PRIMARY KEY (payment_method_cd)
);
COMMENT ON TABLE camdmd.payment_method_code
    IS 'Lookup table for auction payment method cds.';
COMMENT ON COLUMN camdmd.payment_method_code.payment_method_cd
    IS 'Auction payment code.';
COMMENT ON COLUMN camdmd.payment_method_code.payment_method_cd_description
    IS 'Full description of auction payment code.';