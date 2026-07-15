CREATE TABLE IF NOT EXISTS camdmd.country_code
(
    country_cd varchar(7) NOT NULL,
    country_name varchar(1000) NOT NULL,
    display_order numeric(3,0),
    PRIMARY KEY (country_cd)
);
COMMENT ON TABLE camdmd.country_code
    IS 'Lookup table containing codes of countries in our system. ISO-3166-1 alpha-3 List from http://en.wikipedia.org/wiki/ISO_3166-1_alpha-3';
COMMENT ON COLUMN camdmd.country_code.country_cd
    IS 'The country.';
COMMENT ON COLUMN camdmd.country_code.country_name
    IS 'The name of the country.';
COMMENT ON COLUMN camdmd.country_code.display_order
    IS 'The display order of the country in lists.';