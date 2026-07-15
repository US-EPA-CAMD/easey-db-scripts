CREATE TABLE IF NOT EXISTS camdaux.temp_archive_cromerr_file
(
    submission_id numeric,
    cromerr_file_blob blob
);
COMMENT ON TABLE camdaux.temp_archive_cromerr_file
    IS 'Temporary table used to store BLOB data for retrieval from archive database to CSA.';
COMMENT ON COLUMN camdaux.temp_archive_cromerr_file.submission_id
    IS 'Unique identifier of a submission.';
COMMENT ON COLUMN camdaux.temp_archive_cromerr_file.cromerr_file_blob
    IS ' The compressed contents of the XML file.';