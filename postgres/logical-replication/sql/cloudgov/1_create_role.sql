--Creates the easey_replication role used for DMAP logical replication
REVOKE ALL PRIVILEGES ON SCHEMA camd, camddmw, camddmw_arch, camdecmps, camdecmpsmd, camdaux, camdecmpsaux, camdmd FROM easey_replication;
DROP ROLE IF EXISTS easey_replication;
CREATE ROLE easey_replication;
GRANT USAGE ON SCHEMA camd, camddmw, camddmw_arch, camdecmps, camdecmpsmd, camdaux, camdecmpsaux, camdmd TO easey_replication;
GRANT SELECT ON ALL TABLES IN SCHEMA camd TO easey_replication;
GRANT SELECT ON ALL TABLES IN SCHEMA camdmd TO easey_replication;
GRANT SELECT ON ALL TABLES IN SCHEMA camdaux TO easey_replication;
GRANT SELECT ON ALL TABLES IN SCHEMA camddmw TO easey_replication;
GRANT SELECT ON ALL TABLES IN SCHEMA camddmw_arch TO easey_replication;
GRANT SELECT ON ALL TABLES IN SCHEMA camdecmps TO easey_replication;
GRANT SELECT ON ALL TABLES IN SCHEMA camdecmpsaux TO easey_replication;
GRANT SELECT ON ALL TABLES IN SCHEMA camdecmpsmd TO easey_replication;
GRANT rds_replication TO easey_replication;