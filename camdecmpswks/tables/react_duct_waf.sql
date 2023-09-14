CREATE TABLE IF NOT EXISTS camdecmpswks.rect_duct_waf
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
    userid character varying(25) COLLATE pg_catalog."default"
);
