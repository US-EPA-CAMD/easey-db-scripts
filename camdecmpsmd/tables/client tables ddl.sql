CREATE TABLE IF NOT EXISTS camdecmpsmd.process_group_code(
    process_group_cd character varying(7) NOT NULL,
    process_group_description character varying(1000) NOT NULL
);

ALTER TABLE camdecmpsmd.process_group_code
ADD CONSTRAINT pk_process_group_code PRIMARY KEY (process_group_cd);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS camdecmpsmd.system_parameter_name(
    sys_param_name character varying(50) NOT NULL,
    sys_param_description character varying(1000)
);

ALTER TABLE camdecmpsmd.system_parameter_name
ADD CONSTRAINT pk_system_parameter_name PRIMARY KEY (sys_param_name);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS camdecmpsmd.response_type_code(
    response_type_cd character varying(7) NOT NULL,
    response_type_cd_description character varying(1000) NOT NULL
);

ALTER TABLE camdecmpsmd.response_type_code
ADD CONSTRAINT pk_response_type_code PRIMARY KEY (response_type_cd);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS camdecmpsmd.eval_score_code(
    eval_score_cd character varying(7) NOT NULL,
    eval_score_description character varying(1000)
);

ALTER TABLE camdecmpsmd.eval_score_code
ADD CONSTRAINT pk_eval_score_code PRIMARY KEY (eval_score_cd);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS camdecmpsmd.plugin_type_code(
    plugin_type_cd character varying(7) NOT NULL,
    plugin_type_cd_description character varying(1000) NOT NULL
);

ALTER TABLE camdecmpsmd.plugin_type_code
ADD CONSTRAINT pk_plugin_type_code PRIMARY KEY (plugin_type_cd);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS camdecmpsmd.check_status_code(
    check_status_cd character varying(7) NOT NULL,
    check_status_cd_description character varying(1000) NOT NULL,
    check_uses_flg character varying(1),
    code_uses_flg character varying(1),
    test_uses_flg character varying(1)
);

ALTER TABLE camdecmpsmd.check_status_code
ADD CONSTRAINT pk_check_status_code PRIMARY KEY (check_status_cd);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS camdecmpsmd.check_parameter_usage_code(
    check_param_usage_cd character varying(7) NOT NULL,
    check_param_usage_cd_name character varying(100) NOT NULL
);

ALTER TABLE camdecmpsmd.check_parameter_usage_code
ADD CONSTRAINT pk_check_parameter_usage_code PRIMARY KEY (check_param_usage_cd);

CREATE UNIQUE INDEX uq_check_parameter_usage_code
ON camdecmpsmd.check_parameter_usage_code
USING BTREE (check_param_usage_cd_name ASC);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS camdecmpsmd.check_parameter_type_code(
    chk_param_type_cd character varying(7) NOT NULL,
    chk_param_type_cd_description character varying(1000) NOT NULL
);

ALTER TABLE camdecmpsmd.check_parameter_type_code
ADD CONSTRAINT pk_check_parameter_type_code PRIMARY KEY (chk_param_type_cd);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS camdecmpsmd.configuration_type_code(
    config_type_cd character varying(7) NOT NULL,
    config_type_cd_description character varying(1000)
);

ALTER TABLE camdecmpsmd.configuration_type_code
ADD CONSTRAINT pk_configuration_type_code PRIMARY KEY (config_type_cd);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS camdecmpsmd.parameter_group_override_code(
    parameter_group_override_cd character varying(7) NOT NULL,
    parameter_group_override_description character varying(1000) NOT NULL
);

ALTER TABLE camdecmpsmd.parameter_group_override_code
ADD CONSTRAINT pk_parameter_group_override_code PRIMARY KEY (parameter_group_override_cd);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS camdecmpsmd.check_applicability_code(
    check_applicability_cd character varying(7) NOT NULL,
    check_applicability_cd_name character varying(1000)
);

ALTER TABLE camdecmpsmd.check_applicability_code
ADD CONSTRAINT pk_check_applicability_code PRIMARY KEY (check_applicability_cd);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS camdecmpsmd.check_operator_code(
    check_operator_cd character varying(7) NOT NULL,
    check_operator_cd_name character varying(1000)
);

ALTER TABLE camdecmpsmd.check_operator_code
ADD CONSTRAINT pk_check_operator_code PRIMARY KEY (check_operator_cd);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS camdecmpsmd.check_data_type_code(
    check_data_type_cd character varying(7) NOT NULL,
    check_data_type_cd_name character varying(1000) NOT NULL
);

ALTER TABLE camdecmpsmd.check_data_type_code
ADD CONSTRAINT pk_check_data_type_code PRIMARY KEY (check_data_type_cd);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS camdecmpsmd.check_operator_data_type(
    check_operator_cd character varying(7) NOT NULL,
    check_data_type_cd character varying(7) NOT NULL
);

ALTER TABLE camdecmpsmd.check_operator_data_type
ADD CONSTRAINT pk_check_operator_data_type PRIMARY KEY (check_operator_cd, check_data_type_cd);

ALTER TABLE camdecmpsmd.check_operator_data_type
ADD CONSTRAINT fk_check_operator_data_type_check_data_type_code FOREIGN KEY (check_data_type_cd) 
REFERENCES camdecmpsmd.check_data_type_code (check_data_type_cd);

ALTER TABLE camdecmpsmd.check_operator_data_type
ADD CONSTRAINT fk_check_operator_data_type_check_operator_code FOREIGN KEY (check_operator_cd) 
REFERENCES camdecmpsmd.check_operator_code (check_operator_cd);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS camdecmpsmd.check_parameter_code(
    check_param_id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY,
    check_param_id_name character varying(100) NOT NULL,
    check_param_id_description character varying(1000) NOT NULL,
    display_name character varying(100) NOT NULL,
    source_table character varying(100),
    check_data_type_cd character varying(7) NOT NULL,
    chk_param_type_cd character varying(7),
    object_type character varying(100)
);

ALTER TABLE camdecmpsmd.check_parameter_code
ADD CONSTRAINT pk_check_parameter_code PRIMARY KEY (check_param_id);

ALTER TABLE camdecmpsmd.check_parameter_code
ADD CONSTRAINT fk_check_parameter_code_check_data_type_code FOREIGN KEY (check_data_type_cd) 
REFERENCES camdecmpsmd.check_data_type_code (check_data_type_cd);

ALTER TABLE camdecmpsmd.check_parameter_code
ADD CONSTRAINT fk_check_parameter_code_check_parameter_type_code FOREIGN KEY (chk_param_type_cd) 
REFERENCES camdecmpsmd.check_parameter_type_code (chk_param_type_cd);

--NOT SURE WE NEED INDEC & UNIQUE INDEX
CREATE INDEX IF NOT EXISTS ix_check_parameter_code_name
ON camdecmpsmd.check_parameter_code
USING BTREE (check_param_id_name ASC);

--NOT SURE WE NEED INDEC & UNIQUE INDEX
CREATE UNIQUE INDEX uq_check_parameter_code_name
ON camdecmpsmd.check_parameter_code
USING BTREE (check_param_id_name ASC);
-----------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS camdecmpsmd.check_catalog_parameter(
    check_catalog_param_id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY,
    check_catalog_id INTEGER NOT NULL,
    check_param_id INTEGER NOT NULL,
    check_param_usage_cd character varying(7) NOT NULL
);

ALTER TABLE camdecmpsmd.check_catalog_parameter
ADD CONSTRAINT pk_check_catalog_parameter PRIMARY KEY (check_catalog_param_id);

ALTER TABLE camdecmpsmd.check_catalog_parameter
ADD CONSTRAINT fk_check_catalog_parameter_check_catalog FOREIGN KEY (check_catalog_id) 
REFERENCES camdecmpsmd.check_catalog (check_catalog_id);

ALTER TABLE camdecmpsmd.check_catalog_parameter
ADD CONSTRAINT fk_check_catalog_parameter_check_parameter_usage_code FOREIGN KEY (check_param_usage_cd) 
REFERENCES camdecmpsmd.check_parameter_usage_code (check_param_usage_cd);

ALTER TABLE camdecmpsmd.check_catalog_parameter
ADD CONSTRAINT fk_check_catalog_parameter_check_parameter_code FOREIGN KEY (check_param_id) 
REFERENCES camdecmpsmd.check_parameter_code (check_param_id);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS camdecmpsmd.check_catalog_plugin(
    check_catalog_plugin_id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY,
    plugin_name character varying(100) NOT NULL,
    check_catalog_id INTEGER NOT NULL,
    plugin_type_cd character varying(7) NOT NULL,
    check_param_id INTEGER,
    field_name character varying(100)
);

ALTER TABLE camdecmpsmd.check_catalog_plugin
ADD CONSTRAINT pk_check_catalog_plugin PRIMARY KEY (check_catalog_plugin_id);

ALTER TABLE camdecmpsmd.check_catalog_plugin
ADD CONSTRAINT fk_check_catalog_plugin_check_catalog FOREIGN KEY (check_catalog_id) 
REFERENCES camdecmpsmd.check_catalog (check_catalog_id);

ALTER TABLE camdecmpsmd.check_catalog_plugin
ADD CONSTRAINT fk_check_catalog_plugin_plugin_type_code FOREIGN KEY (plugin_type_cd) 
REFERENCES camdecmpsmd.plugin_type_code (plugin_type_cd);

CREATE UNIQUE INDEX uq_check_catalog_plugin_check_catalog_plugin_name
ON camdecmpsmd.check_catalog_plugin
USING BTREE (check_catalog_id ASC, plugin_name ASC);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS camdecmpsmd.cross_check_catalog(
    cross_chk_catalog_id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY,
    cross_chk_catalog_name character varying(100) NOT NULL,
    cross_chk_catalog_description character varying(1000),
    table_name1 character varying(100),
    column_name1 character varying(100),
    description1 character varying(1000) NOT NULL,
    field_type_cd1 character varying(7),
    table_name2 character varying(100),
    column_name2 character varying(100),
    description2 character varying(1000) NOT NULL,
    field_type_cd2 character varying(7),
    table_name3 character varying(100),
    column_name3 character varying(100),
    description3 character varying(1000),
    field_type_cd3 character varying(7)
);

ALTER TABLE camdecmpsmd.cross_check_catalog
ADD CONSTRAINT pk_cross_check_catalog PRIMARY KEY (cross_chk_catalog_id);

ALTER TABLE camdecmpsmd.cross_check_catalog
ADD CONSTRAINT pk_cross_check_catalog_field_type_cd1 FOREIGN KEY (field_type_cd1) 
REFERENCES camdecmpsmd.check_data_type_code (check_data_type_cd);

ALTER TABLE camdecmpsmd.cross_check_catalog
ADD CONSTRAINT pk_cross_check_catalog_field_type_cd2 FOREIGN KEY (field_type_cd2) 
REFERENCES camdecmpsmd.check_data_type_code (check_data_type_cd);

ALTER TABLE camdecmpsmd.cross_check_catalog
ADD CONSTRAINT pk_cross_check_catalog_field_type_cd3 FOREIGN KEY (field_type_cd3) 
REFERENCES camdecmpsmd.check_data_type_code (check_data_type_cd);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS camdecmpsmd.cross_check_catalog_value(
    cross_chk_catalog_value_id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY,
    cross_chk_catalog_id INTEGER NOT NULL,
    value1 TEXT,
    value2 TEXT,
    value3 TEXT
);

ALTER TABLE camdecmpsmd.cross_check_catalog_value
ADD CONSTRAINT pk_cross_check_catalog_value PRIMARY KEY (cross_chk_catalog_value_id);

ALTER TABLE camdecmpsmd.cross_check_catalog_value
ADD CONSTRAINT fk_cross_check_catalog_value_cross_check_catalog FOREIGN KEY (cross_chk_catalog_id) 
REFERENCES camdecmpsmd.cross_check_catalog (cross_chk_catalog_id);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS camdecmpsmd.response_catalog(
    response_catalog_id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY,
    response_catalog_description character varying(1000),
    response_type_cd character varying(7),
    response_catalog_header character varying(100),
    severity_cd character varying(7)
);

ALTER TABLE camdecmpsmd.response_catalog
ADD CONSTRAINT pk_response_catalog PRIMARY KEY (response_catalog_id);

ALTER TABLE camdecmpsmd.response_catalog
ADD CONSTRAINT fk_response_catalog_response_type_code FOREIGN KEY (response_type_cd) 
REFERENCES camdecmpsmd.response_type_code (response_type_cd);

ALTER TABLE camdecmpsmd.response_catalog
ADD CONSTRAINT fk_response_catalog_severity_code FOREIGN KEY (severity_cd) 
REFERENCES camdecmpsmd.severity_code (severity_cd);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS camdecmpsmd.rule_check_condition(
    rule_check_condition_id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY,
    rule_check_id INTEGER NOT NULL,
    and_group_no INTEGER NOT NULL,
    check_param_id INTEGER NOT NULL,
    check_operator_cd character varying(7) NOT NULL,
    check_condition character varying(100),
    negation_ind INTEGER
);

ALTER TABLE camdecmpsmd.rule_check_condition
ADD CONSTRAINT pk_rule_check_condition PRIMARY KEY (rule_check_condition_id);

ALTER TABLE camdecmpsmd.rule_check_condition
ADD CONSTRAINT fk_rule_check_condition_check_operator_code FOREIGN KEY (check_operator_cd) 
REFERENCES camdecmpsmd.check_operator_code (check_operator_cd);

ALTER TABLE camdecmpsmd.rule_check_condition
ADD CONSTRAINT fk_rule_check_condition_check_parameter_code FOREIGN KEY (check_param_id)
REFERENCES camdecmpsmd.check_parameter_code (check_param_id);

ALTER TABLE camdecmpsmd.rule_check_condition
ADD CONSTRAINT fk_rule_check_condition_rule_check FOREIGN KEY (rule_check_id) 
REFERENCES camdecmpsmd.rule_check (rule_check_id);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS camdecmpsmd.system_parameter(
    sys_param_id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY,
    sys_param_name character varying(50) NOT NULL,
    param_name1 character varying(50),
    param_value1 character varying(250),
    param_name2 character varying(50),
    param_value2 character varying(250),
    param_name3 character varying(50),
    param_value3 character varying(250),
    param_name4 character varying(50),
    param_value4 character varying(250),
    param_name5 character varying(50),
    param_value5 character varying(250),
    notes character varying(500)
);

ALTER TABLE camdecmpsmd.system_parameter
ADD CONSTRAINT pk_system_parameter PRIMARY KEY (sys_param_id);

ALTER TABLE camdecmpsmd.system_parameter
ADD CONSTRAINT fk_system_parameter_system_parameter_name FOREIGN KEY (sys_param_name) 
REFERENCES camdecmpsmd.system_parameter_name (sys_param_name);
-----------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS camdecmpsmd.parameter_method_to_formula(
    param_method_to_formula_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 ),
    parameter_cd character varying(7) NOT NULL,
    method_cd character varying(7) NOT NULL,
    system_type_list character varying(1000),
    ecmps_only character varying(3),
    location_type_list character varying(1000),
    formula_list character varying(1000) NOT NULL,
    not_found_result character varying(75) NOT NULL
);

ALTER TABLE camdecmpsmd.parameter_method_to_formula
ADD CONSTRAINT pk_parameter_method_to_formula PRIMARY KEY (param_method_to_formula_id);

ALTER TABLE camdecmpsmd.parameter_method_to_formula
ADD CONSTRAINT uq_parameter_method_to_formula UNIQUE (parameter_cd, method_cd, system_type_list, location_type_list);

ALTER TABLE camdecmpsmd.parameter_method_to_formula
ADD CONSTRAINT fk_parameter_method_to_formula_parameter_code FOREIGN KEY (parameter_cd) 
REFERENCES camdecmpsmd.parameter_code (parameter_cd);

ALTER TABLE camdecmpsmd.parameter_method_to_formula
ADD CONSTRAINT fk_parameter_method_to_formula_method_code FOREIGN KEY (method_cd) 
REFERENCES camdecmpsmd.method_code (method_cd);
-----------------------------------------------------------------------------------------------------------------
create table if not exists camdecmpsmd.hbha_supp_data_xref
(
    hbha_sd_xref_id         integer not null generated always as identity,
    hourly_type_cd          character varying(7) not null,
    parameter_cd            character varying(7) not null,
    moisture_basis          character varying(1),
    primary_bypass_ind      numeric(38,0) not null,
    derived_value_source    character varying(1000) collate pg_catalog."default",
    monitor_value_source    character varying(1000) collate pg_catalog."default"
);

alter table camdecmpsmd.hbha_supp_data_xref
    add constraint hbha_supp_data_xref_pk
    primary key ( hbha_sd_xref_id );

alter table camdecmpsmd.hbha_supp_data_xref
    add constraint hbha_supp_data_xref_uq
    unique ( hourly_type_cd, parameter_cd, moisture_basis );

alter table camdecmpsmd.hbha_supp_data_xref
    add constraint hbha_supp_data_xref_hrt_fk
    foreign key ( hourly_type_cd ) 
    references camdecmpsmd.hourly_type_code ( hourly_type_cd );

alter table camdecmpsmd.hbha_supp_data_xref
    add constraint hbha_supp_data_xref_par_fk
    foreign key ( parameter_cd ) 
    references camdecmpsmd.parameter_code ( parameter_cd );
-----------------------------------------------------------------------------------------------------------------	
