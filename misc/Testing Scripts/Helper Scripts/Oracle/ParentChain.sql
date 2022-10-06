select  *
  from  DBA_TAB_COLS col
 where  ( col.Owner, col.Table_Name, col.Column_Name ) in 
        ( 
            ( 'CAMDECMPS', 'TEST_SUMMARY', 'TEST_SUM_ID' ), 
            ( 'CAMDECMPS', 'LINEARITY_SUMMARY', 'LIN_SUM_ID' ) , 
            ( 'CAMDECMPS', 'LINEARITY_INJECTION', 'LIN_INJ_ID' )
        )
    --or  col.Owner = 'CAMDECMPS' and col.Column_Name in ( 'LIN_INJ_ID' )
    --or  col.Owner = 'CAMDECMPS' and col.Table_Name in ( 'LINEARITY_INJECTION' )
 order
    by  col.Owner,
        col.Table_Name,
        col.Column_Name
