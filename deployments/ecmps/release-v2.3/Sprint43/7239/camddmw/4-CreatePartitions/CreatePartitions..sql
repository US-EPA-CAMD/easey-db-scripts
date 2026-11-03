DO $$
DECLARE
	cmdStmt text;
	partitionName text;
	schemaName text := 'camddmw';
	tableName text;
    year integer;
BEGIN
    
    ------------------------
    -- OP_STATUS_YEAR_DIM --
    ------------------------
    
    RAISE NOTICE 'OP_STATUS_YEAR_DIM Beginning';
    
    -- 1980 and Before --
    cmdStmt := 'CREATE TABLE IF NOT EXISTS camddmw.op_status_year_dim_p1980_and_before PARTITION OF camddmw.op_status_year_dim FOR VALUES FROM ( 0 ) TO ( 1981 )';
    RAISE NOTICE '%', cmdStmt;
    EXECUTE cmdStmt;
    RAISE NOTICE '-- executed --';
    
    -- 1985 back to 1981 --
    cmdStmt := 'CREATE TABLE IF NOT EXISTS camddmw.op_status_year_dim_p1985_to_1981 PARTITION OF camddmw.op_status_year_dim FOR VALUES FROM ( 1981 ) TO ( 1986 )';
    RAISE NOTICE '%', cmdStmt;
    EXECUTE cmdStmt;
    RAISE NOTICE '-- executed --';
    
    -- 1990 back to 1986 --
    cmdStmt := 'CREATE TABLE IF NOT EXISTS camddmw.op_status_year_dim_p1990_to_1986 PARTITION OF camddmw.op_status_year_dim FOR VALUES FROM ( 1986 ) TO ( 1991 )';
    RAISE NOTICE '%', cmdStmt;
    EXECUTE cmdStmt;
    RAISE NOTICE '-- executed --';
    
    -- 1993 back to 1991 --
    cmdStmt := 'CREATE TABLE IF NOT EXISTS camddmw.op_status_year_dim_p1993_to_1991 PARTITION OF camddmw.op_status_year_dim FOR VALUES FROM ( 1991 ) TO ( 1994 )';
    RAISE NOTICE '%', cmdStmt;
    EXECUTE cmdStmt;
    RAISE NOTICE '-- executed --';
    
    -- 1994 through 2026 --
    tableName := 'op_status_year_dim';
	partitionName := tableName || '_p';
    
    FOR year IN 1994..2026
    LOOP
        cmdStmt := FORMAT('CREATE TABLE IF NOT EXISTS %s.%s%s PARTITION OF %s.%s FOR VALUES FROM (%L) TO (%L);', 
                          schemaName, partitionName, year, schemaName, tableName, year, year+1);
        
        RAISE NOTICE '%', cmdStmt;
        EXECUTE cmdStmt;
        RAISE NOTICE '-- executed --';
    END LOOP;
    
    RAISE NOTICE 'OP_STATUS_YEAR_DIM Completed';
    RAISE NOTICE '';
    
    ----------------------
    -- REP_DISPLAY_FACT --
    ----------------------
    
    RAISE NOTICE 'REP_DISPLAY_FACT Beginning';
    
    -- 1980 and Before --
    cmdStmt := 'CREATE TABLE IF NOT EXISTS camddmw.rep_display_fact_p1980_and_before PARTITION OF camddmw.rep_display_fact FOR VALUES FROM ( 0 ) TO ( 1981 )';
    RAISE NOTICE '%', cmdStmt;
    EXECUTE cmdStmt;
    RAISE NOTICE '-- executed --';
    
    -- 1985 back to 1981 --
    cmdStmt := 'CREATE TABLE IF NOT EXISTS camddmw.rep_display_fact_p1985_to_1981 PARTITION OF camddmw.rep_display_fact FOR VALUES FROM ( 1981 ) TO ( 1986 )';
    RAISE NOTICE '%', cmdStmt;
    EXECUTE cmdStmt;
    RAISE NOTICE '-- executed --';
    
    -- 1990 back to 1986 --
    cmdStmt := 'CREATE TABLE IF NOT EXISTS camddmw.rep_display_fact_p1990_to_1986 PARTITION OF camddmw.rep_display_fact FOR VALUES FROM ( 1986 ) TO ( 1991 )';
    RAISE NOTICE '%', cmdStmt;
    EXECUTE cmdStmt;
    RAISE NOTICE '-- executed --';
    
    -- 1993 back to 1991 --
    cmdStmt := 'CREATE TABLE IF NOT EXISTS camddmw.rep_display_fact_p1993_to_1991 PARTITION OF camddmw.rep_display_fact FOR VALUES FROM ( 1991 ) TO ( 1994 )';
    RAISE NOTICE '%', cmdStmt;
    EXECUTE cmdStmt;
    RAISE NOTICE '-- executed --';
    
    -- 1994 through 2026 --
    tableName := 'rep_display_fact';
	partitionName := tableName || '_p';
    
    FOR year IN 1994..2026
    LOOP
        cmdStmt := FORMAT('CREATE TABLE IF NOT EXISTS %s.%s%s PARTITION OF %s.%s FOR VALUES FROM (%L) TO (%L);', 
                          schemaName, partitionName, year, schemaName, tableName, year, year+1);
        
        RAISE NOTICE '%', cmdStmt;
        EXECUTE cmdStmt;
        RAISE NOTICE '-- executed --';
    END LOOP;
    
    RAISE NOTICE 'REP_DISPLAY_FACT Completed';
    RAISE NOTICE '';
    
END $$;
