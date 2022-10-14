select  *
  from  DBA_TAB_COLS col
 where  ( col.Owner, col.Table_Name, col.Column_Name ) in 
        ( 
            ( 'CAMDECMPS', 'TEST_SUMMARY', 'TEST_SUM_ID' ),
            ( 'CAMDECMPS', 'FLOW_TO_LOAD_REFERENCE', 'FLOW_LOAD_REF_ID' )
        )
    --or  col.Owner = 'CAMDECMPS' and col.Column_Name in ( 'TEST_SUM_ID' )
    or  col.Owner = 'CAMDECMPS' and col.Column_Name in ( 'FLOW_LOAD_REF_ID' )
    --or  col.Owner = 'CAMDECMPS' and col.Table_Name in ( 'FLOW_TO_LOAD_REFERENCE' )
 order
    by  col.Owner,
        col.Table_Name,
        col.Column_Id,
        col.Column_Name
