USE [EASEY-IN]
GO

declare @OrisCode integer
declare @LocationNameFilter varchar(6)
declare @TestTypeCdFilter varchar(7)


/*
    1) Replace the ORIS_CODE and run the script.
    2) Save the results as a SQL script by right clicking on the results grid using "Save Result As", changing "Save as Type" to "All Files", and using a file name with a ".sql" extension.
*/

select @OrisCode = null;               /* Replace ORIS_CODE */
select @LocationNameFilter = null   /* Replace Location or null */
select @TestTypeCdFilter = null   /* Replace Test Type or null */

select  lst.ORIS_CODE,
        lst.FACILITY_NAME,
        lst.LOCATION_NAME,
        lst.TEST_TYPE_CD,
        lst.TEST_NUM,
        (
            select  max(pln.MON_PLAN_ID)
              from  ECMPS.dbo.TEST_SUMMARY tst
                    join ECMPS.dbo.MONITOR_PLAN_LOCATION mpl on mpl.MON_LOC_ID = tst.MON_LOC_ID
                    join ECMPS.dbo.MONITOR_PLAN pln on pln.MON_PLAN_ID = mpl.MON_PLAN_ID
             where  tst.TEST_SUM_ID = lst.TEST_SUM_ID
               and  pln.END_RPT_PERIOD_ID is null
        ) as MON_LAN_ID,
        concat( '   "', lst.TEST_SUM_ID, '",' ) as ENDPOINT_JSON_SELECTION
  from  SqlGenQa.PgQatInformation( @OrisCode, @LocationNameFilter, @TestTypeCdFilter ) lst;


select  *
  from  [SqlGenQa].[PgQatInserts] ( @OrisCode, @LocationNameFilter, @TestTypeCdFilter ) 
 order
    by  1
GO
