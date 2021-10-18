USE [EASEY-IN]
GO

/*
    1) Replace the ORIS_CODE and run the script.
    2) Save the results as a SQL script by right clicking on the results grid using "Save Result As", changing "Save as Type" to "All Files", and using a file name with a ".sql" extension.
*/

select * from [SqlGen].[PgMpInserts] ( 3 /* Replace ORIS_CODE */ ) union all
/* Repeat Above */
select * from [SqlGen].[PgMpInserts] ( 9 /* Replace ORIS_CODE */ )
order by 1
GO
