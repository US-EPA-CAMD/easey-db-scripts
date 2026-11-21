ALTER TABLE IF EXISTS camddmw.monitor_fact
    ADD CONSTRAINT monitor_fact_pk PRIMARY KEY (mon_loc_id, op_year);
	