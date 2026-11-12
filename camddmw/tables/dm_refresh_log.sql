create table if not exists camddmw.DM_REFRESH_LOG
(
    dm_refresh_log_id           int generated always as         identity,
    is_full_refresh             boolean,
    incremental_refresh_date    date,
    started_time                timestamp without time zone     default now() not null,
    completed_time              timestamp without time zone,
    note_time                   timestamp without time zone,
    note_json                   json,
    status_cd                   varchar(8) generated always as  ( 
                                                                    case 
                                                                        when ( completed_time is null ) and ( note_time is null )
                                                                        then 'WIP'
                                                                        when ( note_time is not null )
                                                                        then 'FAILED'
                                                                        when ( completed_time is not null )
                                                                        then 'COMPLETE'
                                                                        else 'UNKNOWN'
                                                                    end
                                                                ) stored
);


COMMENT ON TABLE camddmw.DM_REFRESH_LOG is 'Logs information about the Data Mart Refresh process.';


comment on column camddmw.DM_REFRESH_LOG.dm_refresh_log_id is 'Identity key for DM_REFRESH_LOG table.';
comment on column camddmw.DM_REFRESH_LOG.is_full_refresh is 'Indicates whether the refresh is a full refresh (or an incremental refresh).';
comment on column camddmw.DM_REFRESH_LOG.incremental_refresh_date is 'The lookback date to use for an incremental refresh.';
comment on column camddmw.DM_REFRESH_LOG.started_time is 'Timestamp when the refresh task started.';
comment on column camddmw.DM_REFRESH_LOG.completed_time is 'Timestamp when the refresh task successfully completed.';
comment on column camddmw.DM_REFRESH_LOG.note_time is 'Timestamp when the refresh task failed.';
comment on column camddmw.DM_REFRESH_LOG.note_json is 'Json containing information when the refresh task fails.';
