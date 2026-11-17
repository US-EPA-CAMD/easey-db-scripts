create table if not exists camddmw.DM_REFRESH_LOG
(
    DM_REFRESH_LOG_ID           bigserial                       not null,
    STARTED_TIME                timestamp without time zone     default now() not null,
    COMPLETED_TIME              timestamp without time zone,
    NOTE_TIME                   timestamp without time zone,
    NOTE_JSON                   json,
    STATUS_CD                   varchar(8) generated always as  ( 
                                                                    case 
                                                                        when ( COMPLETED_TIME is null ) and ( NOTE_TIME is null )
                                                                        then 'WIP'
                                                                        when ( NOTE_TIME is not null )
                                                                        then 'FAILED'
                                                                        when ( COMPLETED_TIME is not null )
                                                                        then 'COMPLETE'
                                                                        else 'UNKNOWN'
                                                                    end
                                                                ) stored
);


COMMENT ON TABLE camddmw.DM_REFRESH_LOG is 'Logs information about the Data Mart Refresh process.';


comment on column camddmw.DM_REFRESH_LOG.DM_REFRESH_LOG_ID is 'Identity key for DM_REFRESH_LOG table.';
comment on column camddmw.DM_REFRESH_LOG.STARTED_TIME is 'Timestamp when the refresh task started.';
comment on column camddmw.DM_REFRESH_LOG.COMPLETED_TIME is 'Timestamp when the refresh task successfully completed.';
comment on column camddmw.DM_REFRESH_LOG.NOTE_TIME is 'Timestamp when the refresh task failed.';
comment on column camddmw.DM_REFRESH_LOG.NOTE_JSON is 'Json containing information when the refresh task fails.';
