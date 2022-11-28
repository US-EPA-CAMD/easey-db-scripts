select  *
  from  DBA_TAB_COLS col
 where  ( col.Owner, col.Table_Name, col.Column_Name ) in 
        ( 
            ( 'CAMDECMPS', 'TEST_EXTENSION_EXEMPTION', 'TEST_EXTENSION_EXEMPTION_ID' )
        )
    --or  col.Owner = 'CAMDECMPS' and col.Column_Name in ( 'TEST_SUM_ID' )
    or  col.Owner = 'CAMDECMPS' and col.Column_Name in ( 'TEST_EXTENSION_EXEMPTION_ID' )
    --or  col.Owner = 'CAMDECMPS' and col.Table_Name in ( 'CERTIFICATION_EVENTS' )
 order
    by  col.Owner,
        col.Table_Name,
        col.Column_Id,
        col.Column_Name
