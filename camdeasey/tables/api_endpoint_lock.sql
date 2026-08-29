CREATE TABLE IF NOT EXISTS camdeasey.api_endpoint_lock
(
    api_endpoint_lock_id numeric(38,0) NOT NULL DEFAULT "CAMDEASEY"."API_ENDPOINT_LOCK_SQ"."NEXTVAL",
    api_endpoint_path varchar(100) NOT NULL,
    PRIMARY KEY (api_endpoint_lock_id)
);
COMMENT ON TABLE camdeasey.api_endpoint_lock
    IS 'Used to produce locks for API endpoints that prevent simultaneous calls to the endpoint when refreshing data.';
COMMENT ON COLUMN camdeasey.api_endpoint_lock.api_endpoint_lock_id
    IS 'Primary Key for a API_ENDPOINT_LOCK row.';
COMMENT ON COLUMN camdeasey.api_endpoint_lock.api_endpoint_path
    IS 'The path of the endpoint for which the use is being locked.';