-- Table: camdecmps.rect_duct_waf

-- DROP TABLE camdecmps.rect_duct_waf;

CREATE TABLE IF NOT EXISTS camdecmps.rect_duct_waf
(
    rect_duct_waf_data_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    waf_determined_date date,
    waf_effective_date date NOT NULL,
    waf_effective_hour numeric(2,0) NOT NULL,
    waf_method_cd character varying(7) COLLATE pg_catalog."default",
    waf_value numeric(6,4) NOT NULL,
    num_test_runs numeric(2,0),
    num_traverse_points_waf numeric(2,0),
    num_test_ports numeric(2,0),
    num_traverse_points_ref numeric(2,0),
    duct_width numeric(5,1),
    duct_depth numeric(5,1),
    end_date date,
    end_hour numeric(2,0),
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    userid character varying(25) COLLATE pg_catalog."default",
    CONSTRAINT pk_rect_duct_waf PRIMARY KEY (rect_duct_waf_data_id),
    CONSTRAINT fk_rect_duct_waf_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_rect_duct_waf_waf_method_code FOREIGN KEY (waf_method_cd)
        REFERENCES camdecmpsmd.waf_method_code (waf_method_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmps.rect_duct_waf
    IS 'Table containing data pertaining to wall effects correction obtained using CTM-041.';

COMMENT ON COLUMN camdecmps.rect_duct_waf.rect_duct_waf_data_id
    IS 'Unique identifier of a rectangular duct WAF data record. ';

COMMENT ON COLUMN camdecmps.rect_duct_waf.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmps.rect_duct_waf.waf_determined_date
    IS 'The date the WAF applied in column 20 was determined. ';

COMMENT ON COLUMN camdecmps.rect_duct_waf.waf_effective_date
    IS 'The date on which the WAF was first applied to the flow rate data. ';

COMMENT ON COLUMN camdecmps.rect_duct_waf.waf_effective_hour
    IS 'The hour in which the WAF was first applied to the flow rate data. ';

COMMENT ON COLUMN camdecmps.rect_duct_waf.waf_method_cd
    IS 'Code used to identify the WAF determination method. ';

COMMENT ON COLUMN camdecmps.rect_duct_waf.waf_value
    IS 'The WAF applied to the flow rate data, to four decimal places. ';

COMMENT ON COLUMN camdecmps.rect_duct_waf.num_test_runs
    IS 'The number of runs in the WAF test (must be one for default WAF and at least three for a measured WAF) ';

COMMENT ON COLUMN camdecmps.rect_duct_waf.num_traverse_points_waf
    IS 'The number of Method 1 traverse points in the WAF test runs ';

COMMENT ON COLUMN camdecmps.rect_duct_waf.num_test_ports
    IS 'The number of test ports at which measurements were made during the WAF test runs. ';

COMMENT ON COLUMN camdecmps.rect_duct_waf.num_traverse_points_ref
    IS 'The number of Method 1 traverse points in the reference flow RATA test runs.';

COMMENT ON COLUMN camdecmps.rect_duct_waf.duct_width
    IS 'The width of the rectangular duct at the test location (i.e., dimension Lx in Figure 1 of CTM-041) to the nearest 0.1 ft) ';

COMMENT ON COLUMN camdecmps.rect_duct_waf.duct_depth
    IS 'The depth of the rectangular duct at the test location (i.e., dimension Ly in Figure 1 of CTM-041) to the nearest 0.1 ft) ';

COMMENT ON COLUMN camdecmps.rect_duct_waf.end_date
    IS 'The date on which the WAF was last applied to the flow rate data. ';

COMMENT ON COLUMN camdecmps.rect_duct_waf.end_hour
    IS 'The hour in which the WAF was last applied to the flow rate data. ';

COMMENT ON COLUMN camdecmps.rect_duct_waf.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.rect_duct_waf.update_date
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmps.rect_duct_waf.userid
    IS 'User account or source of data that added or updated record. ';

-- Index: idx_rect_duct_waf_mon_loc_id

-- DROP INDEX camdecmps.idx_rect_duct_waf_mon_loc_id;

CREATE INDEX IF NOT EXISTS idx_rect_duct_waf_mon_loc_id
    ON camdecmps.rect_duct_waf USING btree
    (mon_loc_id COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_rect_duct_waf_waf_method

-- DROP INDEX camdecmps.idx_rect_duct_waf_waf_method;

CREATE INDEX IF NOT EXISTS idx_rect_duct_waf_waf_method
    ON camdecmps.rect_duct_waf USING btree
    (waf_method_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: rect_duct_waf_idx$$_15f60009

-- DROP INDEX camdecmps."rect_duct_waf_idx$$_15f60009";

CREATE INDEX IF NOT EXISTS "rect_duct_waf_idx$$_15f60009"
    ON camdecmps.rect_duct_waf USING btree
    (waf_effective_date ASC NULLS LAST, waf_effective_hour ASC NULLS LAST);
