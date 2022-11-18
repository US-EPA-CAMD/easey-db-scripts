select  *
  from  DBA_TAB_COLS col
 where  ( col.Owner, col.Table_Name, col.Column_Name ) in 
        ( 
            ( 'CAMDECMPS', 'TEST_SUMMARY', 'TEST_SUM_ID' ),
            ( 'CAMDECMPS', 'CALIBRATION_INJECTION', 'ON_OFF_CAL_ID' )
        )
    --or  col.Owner = 'CAMDECMPS' and col.Column_Name in ( 'TEST_SUM_ID' )
    or  col.Owner = 'CAMDECMPS' and col.Column_Name in ( 'ON_OFF_CAL_ID' )
    --or  col.Owner = 'CAMDECMPS' and col.Table_Name in ( 'ON_OFF_CAL' )
 order
    by  col.Owner,
        col.Table_Name,
        col.Column_Id,
        col.Column_Name
