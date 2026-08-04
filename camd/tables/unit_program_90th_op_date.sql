CREATE TABLE IF NOT EXISTS CAMD.UNIT_PROGRAM_90TH_OP_DATE
(
    UNIT_ID             NUMERIC(38)                     NOT NULL,
    PRG_CD              VARCHAR(7)                      NOT NULL,
    NINTIETH_OP_DATE    DATE                            NOT NULL,
    LOAD_DATE           TIMESTAMP WITHOUT TIME ZONE     DEFAULT NOW()::timestamp NOT NULL
);


COMMENT ON TABLE CAMD.UNIT_PROGRAM_90TH_OP_DATE is 'Contains the 90th operating date for a unit and program combination.';


COMMENT ON COLUMN CAMD.UNIT_PROGRAM_90TH_OP_DATE.UNIT_ID IS 'Identity key for UNIT table.';
COMMENT ON COLUMN CAMD.UNIT_PROGRAM_90TH_OP_DATE.PRG_CD IS 'The path of the endpoint for which the use is being locked.';
COMMENT ON COLUMN CAMD.UNIT_PROGRAM_90TH_OP_DATE.NINTIETH_OP_DATE is 'The 90th operating date for a unit and program combination.';
COMMENT ON COLUMN CAMD.UNIT_PROGRAM_90TH_OP_DATE.LOAD_DATE IS 'The timestamp for when the 90th operating date was loaded.';
