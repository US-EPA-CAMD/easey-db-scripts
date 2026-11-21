ALTER TABLE IF EXISTS camddmw.state_allocation_fact
    ADD CONSTRAINT state_allocation_fact_pk PRIMARY KEY (vintage_year, "state");
	