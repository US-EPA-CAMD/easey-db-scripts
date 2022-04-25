-- Ensure drop order is reversed from the order in which the tables are created
-- Tables are created in the proper order 1-N based on the number at the beginning of the file name

DROP TABLE IF EXISTS camdaux.qrtz_fired_triggers;
DROP TABLE IF EXISTS camdaux.qrtz_paused_trigger_grps;
DROP TABLE IF EXISTS camdaux.qrtz_scheduler_state;
DROP TABLE IF EXISTS camdaux.qrtz_locks;
DROP TABLE IF EXISTS camdaux.qrtz_simprop_triggers;
DROP TABLE IF EXISTS camdaux.qrtz_simple_triggers;
DROP TABLE IF EXISTS camdaux.qrtz_cron_triggers;
DROP TABLE IF EXISTS camdaux.qrtz_blob_triggers;
DROP TABLE IF EXISTS camdaux.qrtz_triggers;
DROP TABLE IF EXISTS camdaux.qrtz_job_details;
DROP TABLE IF EXISTS camdaux.qrtz_calendars;

DROP TABLE IF EXISTS camdaux.bookmark;
DROP TABLE camdaux.cors_to_api;
DROP TABLE camdaux.cors;
DROP TABLE camdaux.api;
