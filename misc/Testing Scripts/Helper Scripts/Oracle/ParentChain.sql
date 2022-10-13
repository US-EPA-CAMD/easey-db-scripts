select  *
  from  DBA_TAB_COLS col
 where  ( col.Owner, col.Table_Name, col.Column_Name ) in 
        ( 
            ( 'CAMDECMPS', 'TEST_SUMMARY', 'TEST_SUM_ID' ), 
            ( 'CAMDECMPS', 'AE_CORRELATION_TEST_SUM', 'AE_CORR_TEST_SUM_ID' ), 
            ( 'CAMDECMPS', 'AE_CORRELATION_TEST_RUN', 'AE_CORR_TEST_RUN_ID' ), 
            ( 'CAMDECMPS', 'AE_HI_GAS', 'AE_HI_GAS_ID' ), 
            ( 'CAMDECMPS', 'AE_HI_OIL', 'AE_HI_OIL_ID' )
        )
    --or  col.Owner = 'CAMDECMPS' and col.Column_Name in ( 'TEST_SUM_ID' )
    --or  col.Owner = 'CAMDECMPS' and col.Column_Name in ( 'AE_HI_GAS_ID', 'AE_HI_OIL_ID' )
    --or  col.Owner = 'CAMDECMPS' and col.Table_Name in ( 'AE_HI_GAS', 'AE_HI_OIL' )
 order
    by  col.Owner,
        col.Table_Name,
        col.Column_Id,
        col.Column_Name
