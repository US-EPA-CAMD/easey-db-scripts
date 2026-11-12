-----------------
-- Constraints --
-----------------

alter table camddmw.DM_REFRESH_LOG add constraint DM_REFRESH_LOG_PK primary key ( DM_REFRESH_LOG_ID );
alter table camddmw.DM_REFRESH_LOG add constraint DM_REFRESH_LOG_UQ unique ( STARTED_TIME );
alter table camddmw.DM_REFRESH_LOG add constraint DM_REFRESH_LOG_DTS_CK check ( not ( ( COMPLETED_TIME is not null ) and ( NOTE_TIME is not null ) ) );
alter table camddmw.DM_REFRESH_LOG add constraint DM_REFRESH_LOG_ERR_CK check ( ( NOTE_TIME is not null ) = ( NOTE_JSON is not null ) );
