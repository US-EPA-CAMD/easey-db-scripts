--Creates the easey_replication role used for DMAP logical replication
REVOKE ALL PRIVILEGES ON SCHEMA camd, camddmw, camddmw_arch, camdecmps, camdecmpsmd, camdaux, camdecmpsaux FROM easey_replication;
DROP ROLE IF EXISTS easey_replication;
CREATE ROLE easey_replication;
GRANT USAGE ON SCHEMA camd, camddmw, camddmw_arch, camdecmps, camdecmpsmd, camdaux, camdecmpsaux TO easey_replication;
GRANT rds_replication TO easey_replication;