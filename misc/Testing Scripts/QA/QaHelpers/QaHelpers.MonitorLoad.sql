use [EASEY-IN]
go

begin

    declare @MonPlanId varchar(max);
    declare @OrisCode integer;
    declare @FacilityName varchar(max);
    declare @Locations varchar(max);

    select  @MonPlanId = 'TWCORNEL5-EA112F04E50E44E29ED6A63A025E4B4F'

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
    

    select concat( '/*', 'ORIS: ', right( concat('      ', @OrisCode), 6 ), ' (', @FacilityName, '), Location(s): ', @Locations, '    Order:   45 */ ', SQL_STATEMENT ) from SqlGen.PgMonitorLoadDeletes(@vMonitorPlanIdTable) union all

    select concat( '/*', 'ORIS: ', right( concat('      ', @OrisCode), 6 ), ' (', @FacilityName, '), Location(s): ', @Locations, '    Order:   79 */ ', SQL_STATEMENT ) from SqlGen.PgMonitorLoadInserts(@vMonitorPlanIdTable)

    order by 1;

end;
