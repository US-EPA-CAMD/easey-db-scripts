select  *
  from  DBA_TAB_COLS col
 where  ( col.Owner, col.Table_Name, col.Column_Name ) in 
        ( 
            ( 'CAMDECMPS', 'QA_CERT_EVENT', 'QA_CERT_EVENT_ID' ),
            ( 'CAMDECMPS', 'CERTIFICATION_EVENTS', 'CERT_ID' )
        )
    --or  col.Owner = 'CAMDECMPS' and col.Column_Name in ( 'TEST_SUM_ID' )
    or  col.Owner = 'CAMDECMPS' and col.Column_Name in ( 'CERT_ID' )
    --or  col.Owner = 'CAMDECMPS' and col.Table_Name in ( 'CERTIFICATION_EVENTS' )
 order
    by  col.Owner,
        col.Table_Name,
        col.Column_Id,
        col.Column_Name
