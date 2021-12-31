CREATE TABLE IF NOT EXISTS camdecmps.dm_emissions_user(
    dm_emissions_user_id CHARACTER VARYING(45) NOT NULL DEFAULT aws_oracle_ext.sys_guid(),
    dm_emissions_id CHARACTER VARYING(45) NOT NULL,
    dm_emissions_user_cd CHARACTER VARYING(7) NOT NULL,
    process_date TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT aws_oracle_ext.SYSDATE(),
    complete_date TIMESTAMP WITHOUT TIME ZONE,
    note CHARACTER VARYING(1000),
    note_date TIMESTAMP WITHOUT TIME ZONE
)
        WITH (
        OIDS=FALSE
        );
COMMENT ON TABLE camdecmps.dm_emissions_user
     IS 'Contains ECMPS D&M emissions users who have used or attempted to use the data.  The table is a child of DM_EMISSIONS and contains a DM_EMISSIONS_USER_CD to indicate the user, a process date indicating an attempt to use the emissions data, a complete date indicated successful use of the data, and a note and note date indicating a failure in using the data.';
COMMENT ON COLUMN camdecmps.dm_emissions_user.dm_emissions_user_id
     IS 'Primary Key';
COMMENT ON COLUMN camdecmps.dm_emissions_user.dm_emissions_id
     IS 'Parent Key into DM_Emissions table';
COMMENT ON COLUMN camdecmps.dm_emissions_user.dm_emissions_user_cd
     IS 'Foreign Key into DM_Emissions_User_Code table';
COMMENT ON COLUMN camdecmps.dm_emissions_user.process_date
     IS 'The date/time processing of the DM_Emissions row started for the DM_Emmissions_User_Cd';
COMMENT ON COLUMN camdecmps.dm_emissions_user.complete_date
     IS 'The date/time processing of the DM_Emissions row successfully complete for the DM_Emmissions_User_Cd';
COMMENT ON COLUMN camdecmps.dm_emissions_user.note
     IS 'Note mainly indicating why processing did not complete successfully';
COMMENT ON COLUMN camdecmps.dm_emissions_user.note_date
     IS 'The date/time the note was updated.';


ALTER TABLE camdecmps.dm_emissions_user
ADD CONSTRAINT dm_emissions_user_pk PRIMARY KEY (dm_emissions_user_id);

ALTER TABLE camdecmps.dm_emissions_user
ADD CONSTRAINT dm_emissions_user_em__cd_uq UNIQUE (dm_emissions_id, dm_emissions_user_cd);

ALTER TABLE camdecmps.dm_emissions_user
ADD CONSTRAINT dm_emissions_user_cd_fk FOREIGN KEY (dm_emissions_user_cd) 
REFERENCES camdecmpsmd.dm_emissions_user_code (dm_emissions_user_cd);

ALTER TABLE camdecmps.dm_emissions_user
ADD CONSTRAINT dm_emissions_user_em_fk FOREIGN KEY (dm_emissions_id) 
REFERENCES camdecmps.dm_emissions (dm_emissions_id);