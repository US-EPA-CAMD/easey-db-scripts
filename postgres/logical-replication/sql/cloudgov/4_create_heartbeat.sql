--Creates the heartbeat process to keep the WAL files from piling up on the db server
--See https://wolfman.dev/posts/pg-logical-heartbeats/ for a detailed explaination
DROP TABLE IF EXISTS camdaux._heartbeat;
CREATE TABLE camdaux._heartbeat (id INT PRIMARY KEY, heartbeat TIMESTAMP NOT NULL);
COMMENT ON TABLE camdaux._heartbeat IS 'This table is updated by PG_CRON so WAL files associated with logical replication are cleaned up on the server.';
select current_catalog as database_for_job;
\gset
--Connect to the postgres database to schedule the job
\connect postgres
--Schedule a cron to write to the heartbeat table every five minutes
\set job_name 'Logical replication heartbeat'
DELETE FROM cron.job WHERE jobname = :'job_name';
SELECT cron.schedule(:'job_name', '*/5 * * * *', 'INSERT INTO camdaux._heartbeat VALUES(1, current_timestamp) ON CONFLICT(id) DO UPDATE SET heartbeat = current_timestamp;');
UPDATE cron.job SET database = :'database_for_job' WHERE jobname = :'job_name';
\connect :"database_for_job"