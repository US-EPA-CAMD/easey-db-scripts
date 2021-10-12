USE [EASEY-IN]
GO

/*
    1) Modify and run the script.
    2) Say the results as a SQL script by right clicking on the results grid using "Save Result As", changing "Save as Type" to "All Files", and using a file name with a ".sql" extension.
*/

select * from [SqlGen].[PgMpInserts] ( 1 /* Replace FAC_ID */ ) union all
/* Repeat Above */
select * from [SqlGen].[PgMpInserts] ( 8237 /* Replace FAC_ID */ )
order by 1
GO
