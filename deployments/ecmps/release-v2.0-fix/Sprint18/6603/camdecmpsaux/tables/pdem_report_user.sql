CREATE TABLE IF NOT EXISTS camdecmpsaux.pdem_report_user
(
    pdem_report_user_id     bigserial,
	pdem_report_id          bigint NOT NULL,
    pdem_report_user_cd     varchar(7) NOT NULL,
    process_date            timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    complete_date           timestamp,
    note                    varchar(1000),
    note_date               timestamp
);

-- Add comments to the table 
comment on table camdecmpsaux.pdem_report_user IS 'Contains Progam Data Emissions (PDEM) working data users who have used or attempted to use the data.  The table IS a child of PDEM_REPORT_USER and contains a PDEM_REPORT_USER_CD to indicate the user, a process date indicating an attempt to use the emissions data, a complete date indicated successful use of the data, and a note and note date indicating a failure in using the data.';

-- Add comments to the columns 
COMMENT ON COLUMN camdecmpsaux.pdem_report_user.pdem_report_user_id IS 'Primary Key';
COMMENT ON COLUMN camdecmpsaux.pdem_report_user.pdem_report_id IS 'Foreign key into the PDEM_REPORT table that identifies the latest ECMPS Program Data for an emissions report.';
COMMENT ON COLUMN camdecmpsaux.pdem_report_user.pdem_report_user_cd IS 'Foreign Key into Progam Data Emissions (PDEM) User Code table';
COMMENT ON COLUMN camdecmpsaux.pdem_report_user.process_date IS 'The date/time processing of the DM_Emissions row started for the DM_Emmissions_User_Cd';
COMMENT ON COLUMN camdecmpsaux.pdem_report_user.complete_date IS 'The date/time processing of the DM_Emissions row successfully complete for the DM_Emmissions_User_Cd';
COMMENT ON COLUMN camdecmpsaux.pdem_report_user.note IS 'Note mainly indicating why processing did not complete successfully';
COMMENT ON COLUMN camdecmpsaux.pdem_report_user.note_date IS 'The date/time the note was updated.';
