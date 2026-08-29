CREATE TABLE IF NOT EXISTS camdaux.email_plugin
(
    plugin_name varchar(255) NOT NULL,
    xml_property_name varchar(255) NOT NULL,
    PRIMARY KEY (plugin_name)
);
COMMENT ON TABLE camdaux.email_plugin
    IS 'Lookup table containing email plugin substitution values and the name of the corresponding XML property name .';
COMMENT ON COLUMN camdaux.email_plugin.plugin_name
    IS 'The name of the plugin, including brackets, like [CROMERR_REPORT_NAME].';
COMMENT ON COLUMN camdaux.email_plugin.xml_property_name
    IS 'The name of corresponding XML property name, like CromerrReportName.';