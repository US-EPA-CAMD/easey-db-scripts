with
    sel as  (
                select 'CAMDECMPS' as Owner, 'QA_CERT_EVENT' as Table_Name from DUAL
            )

select  col.Table_Name,
        col.Column_Name,
        col.Data_Type,
        ( '                        ''' || col.Column_Name || ''', '', '',' ) as Insert_Column_Name,
        case
            when col.Data_Type = 'VARCHAR2'
                then '                    case when dat.' || col.Column_Name || ' is not null then '''''''' + dat.' || col.Column_Name || ' + '''''''' else ''NULL'' end, '', '','
            
            when col.Data_Type = 'NUMBER'
                then '                    case when dat.' || col.Column_Name || ' is not null then cast(dat.' || col.Column_Name || ' as varchar) else ''NULL'' end, '', '','
            
            when col.Data_Type = 'DATE' and col.Column_Name in ( 'ADD_DATE', 'UPDATE_DATE' )
                then '                    case when dat.' || col.Column_Name || ' is not null then '''''''' + convert(varchar, dat.' || col.Column_Name || ', 120) + '''''''' else ''NULL'' end, '', '','
            
            when col.Data_Type = 'DATE'
                then '                    case when dat.' || col.Column_Name || ' is not null then '''''''' + convert(varchar(10), dat.' || col.Column_Name || ', 120) + '''''''' else ''NULL'' end, '', '','
        end as Insert_Column_Value,
        (
            case
                when exists
                     (
                        select  1
                          from  DBA_CONSTRAINTS con
                                join DBA_CONS_COLUMNS ccl
                                  on ccl.Owner = con.Owner
                                 and ccl.Constraint_Name = con.Constraint_Name
                         where  con.Constraint_Type = 'P'
                           and  con.Owner = col.OWNER
                           and  con.Table_Name = col.Table_Name
                           and  ccl.Column_Name = col.Column_Name
                     )
                then col.Column_Name
                else ( '                        ''' || col.Column_Name || ' = EXCLUDED.' || col.Column_Name || ', '',' )
            end
        ) as Conflict_Update
  from  DBA_TAB_COLS col
 where  ( col.Owner, col.Table_Name ) in ( select Owner, Table_Name from sel )
 order
    by  col.Owner,
        col.Table_Name,
        (
            case
                when exists (
                                select  1
                                  from  DBA_CONSTRAINTS con
                                        join DBA_CONS_COLUMNS coc
                                          on coc.Owner = con.Owner
                                         and coc.Constraint_Name = con.Constraint_Name
                                 where  con.Owner = col.Owner
                                   and  con.Table_Name = col.Table_Name
                                   and  con.Constraint_Type = 'P'
                                   and  coc.Column_Name = col.Column_Name
                            )
                    then 1
                    else 0
            end
        ) desc,
        decode( upper(col.Column_Name), 'USERID', 1001, 'ADD_DATE', 1002, 'UPDATE_DATE', 1003, col.Column_Id),
        col.Column_Name
