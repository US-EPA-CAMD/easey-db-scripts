begin

    declare @MonPlanId varchar(max);
    declare @OrisCode integer;
    declare @FacilityName varchar(max);
    declare @Locations varchar(max);

    select  @MonPlanId = 'TWCORNEL5-F4E3DAADF24B4E1C8F2BEDD2DE59B436'

    select  @OrisCode = fac.ORIS_CODE,
            @FacilityName = fac.FACILITY_NAME,
            @Locations = ECMPS.dbo.ConcatMonitorPlanLocations( pln.MON_PLAN_ID )
      from  ECMPS.dbo.MONITOR_PLAN pln
            join ECMPS.dbo.FACILITY fac on fac.FAC_ID = pln.FAC_ID
     where  pln.MON_PLAN_ID = @MonPlanId;

    declare @vMonitorPlanIdTable SqlGen.Monitor_Plan_Id_Table;

    insert
      into  @vMonitorPlanIdTable
    select  pln.MON_PLAN_ID
      from  ECMPS.dbo.MONITOR_PLAN pln
     where  pln.MON_PLAN_ID = @MonPlanId;
    

    select concat( '/*', 'ORIS: ', right( concat('      ', @OrisCode), 6 ), '    Order:   45 */ ', SQL_STATEMENT ) from SqlGen.PgRectDuctWafDeletes(@vMonitorPlanIdTable) union all

    select concat( '/*', 'ORIS: ', right( concat('      ', @OrisCode), 6 ), '    Order:   79 */ ', SQL_STATEMENT ) from SqlGen.PgRectDuctWafInserts(@vMonitorPlanIdTable)

    order by 1;

end;
