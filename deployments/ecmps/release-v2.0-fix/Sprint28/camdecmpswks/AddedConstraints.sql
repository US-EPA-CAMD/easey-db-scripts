ALTER TABLE camdecmpswks.monitor_default
ADD CONSTRAINT uq_monitor_default_key
UNIQUE (mon_loc_id, parameter_cd, default_purpose_cd, fuel_cd, operating_condition_cd, begin_date, begin_hour);

ALTER TABLE camdecmpswks.monitor_formula
ADD CONSTRAINT uq_monitor_formula_key
UNIQUE (mon_loc_id, formula_identifier);

ALTER TABLE camdecmpswks.monitor_load
ADD CONSTRAINT uq_monitor_load_key
UNIQUE (MON_LOC_ID, BEGIN_DATE, BEGIN_HOUR);

ALTER TABLE camdecmpswks.monitor_location_attribute
ADD CONSTRAINT uq_monitor_location_attribute_key
UNIQUE (MON_LOC_ID, BEGIN_DATE);

ALTER TABLE camdecmpswks.monitor_method
ADD CONSTRAINT uq_monitor_method_key
UNIQUE (MON_LOC_ID, PARAMETER_CD, BEGIN_DATE, BEGIN_HOUR);

ALTER TABLE camdecmpswks.monitor_system
ADD CONSTRAINT uq_monitor_system_key
UNIQUE (MON_LOC_ID, SYSTEM_IDENTIFIER);

ALTER TABLE camdecmpswks.monitor_system_component
ADD CONSTRAINT uq_monitor_system_component_key
UNIQUE (MON_SYS_ID, COMPONENT_ID, BEGIN_DATE, BEGIN_HOUR);

ALTER TABLE camdecmpswks.analyzer_range
ADD CONSTRAINT uq_analyzer_range_key
UNIQUE (COMPONENT_ID, BEGIN_DATE, BEGIN_HOUR);

ALTER TABLE camdecmpswks.system_fuel_flow
ADD CONSTRAINT uq_system_fuel_flow_key
UNIQUE (MON_SYS_ID, BEGIN_DATE, BEGIN_HOUR);

ALTER TABLE camdecmpswks.monitor_qualification
ADD CONSTRAINT uq_monitor_qualification_key
UNIQUE (MON_LOC_ID, QUAL_TYPE_CD, BEGIN_DATE);

ALTER TABLE camdecmpswks.monitor_qualification_pct
ADD CONSTRAINT uq_monitor_qualification_pct_key
UNIQUE (MON_QUAL_ID, QUAL_YEAR);

ALTER TABLE camdecmpswks.monitor_qualification_lme
ADD CONSTRAINT uq_monitor_qualification_lme_key
UNIQUE (MON_QUAL_ID, QUAL_YEAR);

ALTER TABLE camdecmpswks.monitor_qualification_lee
ADD CONSTRAINT uq_monitor_qualification_lee_key
UNIQUE (MON_QUAL_ID, QUAL_TEST_DATE);

ALTER TABLE camdecmpswks.monitor_span
ADD CONSTRAINT uq_monitor_span_key
UNIQUE (MON_LOC_ID, COMPONENT_TYPE_CD, SPAN_SCALE_CD, BEGIN_DATE, BEGIN_HOUR);

ALTER TABLE camdecmpswks.rect_duct_waf
ADD CONSTRAINT uq_rect_duct_waf_key
UNIQUE (MON_LOC_ID, WAF_EFFECTIVE_DATE, WAF_EFFECTIVE_HOUR);

ALTER TABLE camdecmpswks.mats_method_data
ADD CONSTRAINT uq_mats_method_data_key
UNIQUE (MON_LOC_ID, MATS_METHOD_PARAMETER_CD, BEGIN_DATE, BEGIN_HOUR);

ALTER TABLE camdecmpswks.unit_control
ADD CONSTRAINT uq_unit_control_key
UNIQUE (UNIT_ID, CE_PARAM, CONTROL_CD, INSTALL_DATE);

ALTER TABLE camdecmpswks.unit_capacity
ADD CONSTRAINT uq_unit_capacity_key
UNIQUE (UNIT_ID, BEGIN_DATE);
