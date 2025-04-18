CREATE TABLE IF NOT EXISTS camdecmpsmd.pdem_report_user_code
(
  pdem_report_user_cd           varchar(7) NOT NULL,
  pdem_report_user_description  varchar(1000) NOT NULL,
  active_flg                    varchar(1) NOT NULL,
    
    CONSTRAINT pdem_report_user_code_pk PRIMARY KEY ( pdem_report_user_cd ),
    CONSTRAINT pdem_report_user_code_uq UNIQUE ( pdem_report_user_description )
);

-- Table Comment
comment on table camdecmpsmd.pdem_report_user_code IS 'Lookup table of codes that indicate a user of Progam Data Emissions (PDEM) working data.';

-- Column Comments
COMMENT ON COLUMN camdecmpsmd.pdem_report_user_code.pdem_report_user_cd IS 'Code indicating a user of Progam Data Emissions (PDEM) working data.';
COMMENT ON COLUMN camdecmpsmd.pdem_report_user_code.pdem_report_user_description IS 'Description of Progam Data Emissions (PDEM) User Code.';
COMMENT ON COLUMN camdecmpsmd.pdem_report_user_code.active_flg IS 'Flag indicating whether the Progam Data Emissions (PDEM) User is currently an active user.';
