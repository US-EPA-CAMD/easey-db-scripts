select  *
  from  DBA_TAB_COLS col
 where  ( col.Owner, col.Table_Name, col.Column_Name ) in 
        ( 
            ( 'CAMDECMPS', 'TEST_SUMMARY', 'TEST_SUM_ID' ),
            ( 'CAMDECMPS', 'CYCLE_TIME_SUMMARY', 'CYCLE_TIME_SUM_ID' ),
            ( 'CAMDECMPS', 'CYCLE_TIME_INJECTION', 'CYCLE_TIME_INJ_ID' )
        )
    --or  col.Owner = 'CAMDECMPS' and col.Column_Name in ( 'TEST_SUM_ID' )
    or  col.Owner = 'CAMDECMPS' and col.Column_Name in ( 'CYCLE_TIME_INJ_ID' )
    --or  col.Owner = 'CAMDECMPS' and col.Table_Name in ( 'CYCLE_TIME_INJECTION' )
 order
    by  col.Owner,
        col.Table_Name,
        col.Column_Id,
        col.Column_Name
