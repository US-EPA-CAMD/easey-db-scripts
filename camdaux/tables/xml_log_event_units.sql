CREATE TABLE IF NOT EXISTS camdaux.xml_log_event_units
(
    key raw(1000),
    rid rowid,
    pkey raw(1000) NOT NULL,
    unit_id numeric
);