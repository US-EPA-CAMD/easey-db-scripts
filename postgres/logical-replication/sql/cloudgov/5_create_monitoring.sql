--Creates the objects and cron to store the logical replication monitoring data 
--See https://shipt.tech/monitoring-postgres-logical-replication-12e54599d16a for an explanation of the approach
DROP TABLE IF EXISTS camdaux.pg_stat_replication_historical; 
CREATE TABLE camdaux.pg_stat_replication_historical (
	id INT PRIMARY KEY, 
	date_time TIMESTAMP WITH TIME ZONE,
	application_name TEXT, 
	CLIENT_ADDR INET, 
	CLIENT_PORT INT, 
	BACKEND_START TIMESTAMP WITH TIME ZONE, 
	STATE TEXT, 
	CURRENT_LSN PG_LSN, 
	SENT_LSN PG_LSN, 
	WRITE_LSN PG_LSN, 
	FLUSH_LSN PG_LSN,
	REPLAY_LSN PG_LSN,
	TOTAL_LAG_BYTES INT,
	SYNC_STATE TEXT);
COMMENT ON TABLE camdaux.pg_stat_replication_historical IS 'This table is updated by PG_CRON with data from the pg_stat_replication view.';
DROP SEQUENCE IF EXISTS pg_stat_replication_historical_seq;
CREATE SEQUENCE pg_stat_replication_historical_seq;
select current_catalog as database_for_job;
\gset
--Connect to the postgres database to schedule the job
\connect postgres
--Schedule a cron to write to the heartbeat table every five minutes
\set job_name 'Logical replication historical data'
DELETE FROM cron.job WHERE jobname = :'job_name';
SELECT cron.schedule(:'job_name', '*/5 * * * *', E'INSERT INTO camdaux.pg_stat_replication_historical(id, date_time, application_name, client_addr, client_port, backend_start, state, current_lsn, sent_lsn, write_lsn, flush_lsn, replay_lsn, total_lag_bytes, sync_state)
SELECT NEXTVAL(\'pg_stat_replication_historical_seq\'),
	now(),
	APPLICATION_NAME,
	CLIENT_ADDR,
	CLIENT_PORT,
	BACKEND_START,
	STATE,
	PG_CURRENT_WAL_LSN() AS CURRENT_LSN,
	SENT_LSN,
	WRITE_LSN,
	FLUSH_LSN,
	REPLAY_LSN,
	PG_WAL_LSN_DIFF(PG_CURRENT_WAL_LSN(),
	REPLAY_LSN)::numeric AS TOTAL_LAG_BYTES,
	SYNC_STATE
FROM PG_STAT_REPLICATION
WHERE APPLICATION_NAME <> \'walreceiver\';') as job_id;
\gset
UPDATE cron.job SET database = :'database_for_job' WHERE jobid = :'job_id';
\connect :"database_for_job"