select  *
  from  DBA_TAB_COLS col
 where  ( col.Owner, col.Table_Name, col.Column_Name ) in 
        ( 
            ( 'CAMDECMPS', 'TEST_SUMMARY', 'TEST_SUM_ID' ), 
            ( 'CAMDECMPS', 'UNIT_DEFAULT_TEST', 'UNIT_DEFAULT_TEST_SUM_ID' ), 
            ( 'CAMDECMPS', 'UNIT_DEFAULT_TEST_RUN', 'UNIT_DEFAULT_TEST_RUN_ID' )
        )
    --or  col.Owner = 'CAMDECMPS' and col.Column_Name in ( 'TEST_SUM_ID' )
    --or  col.Owner = 'CAMDECMPS' and col.Column_Name in ( 'UNIT_DEFAULT_TEST_RUN_ID', 'UNIT_DEFAULT_TEST_SUM_ID' )
    or  col.Owner = 'CAMDECMPS' and col.Table_Name in ( 'AE_CORRELATION_TEST_SUM' )
 order
    by  col.Owner,
        col.Table_Name,
        col.Column_Id,
        col.Column_Name
