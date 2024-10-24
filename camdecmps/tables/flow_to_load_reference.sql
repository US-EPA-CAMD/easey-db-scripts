CREATE TABLE IF NOT EXISTS camdecmps.flow_to_load_reference
(
    flow_load_ref_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    op_level_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    avg_ref_method_flow numeric(10,0),
    calc_avg_ref_method_flow numeric(10,0),
    rata_test_num character varying(18) COLLATE pg_catalog."default",
    avg_gross_unit_load numeric(6,0),
    calc_avg_gross_unit_load numeric(6,0),
    ref_flow_load_ratio numeric(6,2),
    calc_ref_flow_load_ratio numeric(6,2),
    avg_hrly_hi_rate numeric(7,1),
    ref_ghr numeric(6,0),
    calc_ref_ghr numeric(6,0),
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    calc_sep_ref_ind numeric(38,0)
);

COMMENT ON TABLE camdecmps.flow_to_load_reference
    IS 'Flow to load reference data.  Record Type 605.';

COMMENT ON COLUMN camdecmps.flow_to_load_reference.flow_load_ref_id
    IS 'Unique identifier of flow to load reference record. ';

COMMENT ON COLUMN camdecmps.flow_to_load_reference.test_sum_id
    IS 'Unique identifier of a test summary record. ';

COMMENT ON COLUMN camdecmps.flow_to_load_reference.op_level_cd
    IS 'Code used to identify the operating level. ';

COMMENT ON COLUMN camdecmps.flow_to_load_reference.avg_ref_method_flow
    IS 'Average reference method flow rate during reference flow RATA. ';

COMMENT ON COLUMN camdecmps.flow_to_load_reference.calc_avg_ref_method_flow
    IS 'Average reference method flow rate during reference flow RATA. ';

COMMENT ON COLUMN camdecmps.flow_to_load_reference.rata_test_num
    IS 'RATA test number. ';

COMMENT ON COLUMN camdecmps.flow_to_load_reference.avg_gross_unit_load
    IS 'Average gross unit load (MWe or Steam). ';

COMMENT ON COLUMN camdecmps.flow_to_load_reference.calc_avg_gross_unit_load
    IS 'Average gross unit load (MWe or Steam). ';

COMMENT ON COLUMN camdecmps.flow_to_load_reference.ref_flow_load_ratio
    IS 'Reference flow to load ratio. ';

COMMENT ON COLUMN camdecmps.flow_to_load_reference.calc_ref_flow_load_ratio
    IS 'Reference flow to load ratio. ';

COMMENT ON COLUMN camdecmps.flow_to_load_reference.avg_hrly_hi_rate
    IS 'Average hourly heat input rate during RATA. ';

COMMENT ON COLUMN camdecmps.flow_to_load_reference.ref_ghr
    IS 'Reference gross heat rate (GHR) value. ';

COMMENT ON COLUMN camdecmps.flow_to_load_reference.calc_ref_ghr
    IS 'Reference gross heat rate (GHR) value. ';

COMMENT ON COLUMN camdecmps.flow_to_load_reference.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.flow_to_load_reference.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.flow_to_load_reference.update_date
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmps.flow_to_load_reference.calc_sep_ref_ind
    IS 'Used to indicate if separate reference ratio was calculated for each multiple stack. ';
