CREATE TABLE IF NOT EXISTS camdeasey.api_endpoint_next_timestamp
(
    api_endpoint_path varchar(100) NOT NULL,
    api_endpoint_next_timestamp timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (api_endpoint_path)
);
COMMENT ON TABLE camdeasey.api_endpoint_next_timestamp
    IS 'Contains the &quot;lastupdated&quot; timestamp to use in the next call to the API endpoint.';
COMMENT ON COLUMN camdeasey.api_endpoint_next_timestamp.api_endpoint_path
    IS 'The "name" of the API endpoint.';
COMMENT ON COLUMN camdeasey.api_endpoint_next_timestamp.api_endpoint_next_timestamp
    IS 'The next "lastupdated" timestamp.';