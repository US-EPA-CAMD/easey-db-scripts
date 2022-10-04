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
    

    select concat( '/*', 'ORIS: ', right( concat('      ', @OrisCode), 6 ), ' (', @FacilityName, '), Location(s): ', @Locations, '    Order:   36 */ ', SQL_STATEMENT ) from SqlGen.PgMonitorQualificationLeeDeletes(@vMonitorPlanIdTable) union all   -- MONITOR_QUALIFICATION child
    select concat( '/*', 'ORIS: ', right( concat('      ', @OrisCode), 6 ), ' (', @FacilityName, '), Location(s): ', @Locations, '    Order:   37 */ ', SQL_STATEMENT ) from SqlGen.PgMonitorQualificationLmeDeletes(@vMonitorPlanIdTable) union all   -- MONITOR_QUALIFICATION child
    select concat( '/*', 'ORIS: ', right( concat('      ', @OrisCode), 6 ), ' (', @FacilityName, '), Location(s): ', @Locations, '    Order:   38 */ ', SQL_STATEMENT ) from SqlGen.PgMonitorQualificationPctDeletes(@vMonitorPlanIdTable) union all   -- MONITOR_QUALIFICATION child
    select concat( '/*', 'ORIS: ', right( concat('      ', @OrisCode), 6 ), ' (', @FacilityName, '), Location(s): ', @Locations, '    Order:   39 */ ', SQL_STATEMENT ) from SqlGen.PgMonitorQualificationDeletes(@vMonitorPlanIdTable) union all

    select concat( '/*', 'ORIS: ', right( concat('      ', @OrisCode), 6 ), ' (', @FacilityName, '), Location(s): ', @Locations, '    Order:   71 */ ', SQL_STATEMENT ) from SqlGen.PgMonitorQualificationInserts(@vMonitorPlanIdTable) union all
    select concat( '/*', 'ORIS: ', right( concat('      ', @OrisCode), 6 ), ' (', @FacilityName, '), Location(s): ', @Locations, '    Order:   72 */ ', SQL_STATEMENT ) from SqlGen.PgMonitorQualificationLeeInserts(@vMonitorPlanIdTable) union all
    select concat( '/*', 'ORIS: ', right( concat('      ', @OrisCode), 6 ), ' (', @FacilityName, '), Location(s): ', @Locations, '    Order:   73 */ ', SQL_STATEMENT ) from SqlGen.PgMonitorQualificationLmeInserts(@vMonitorPlanIdTable) union all
    select concat( '/*', 'ORIS: ', right( concat('      ', @OrisCode), 6 ), ' (', @FacilityName, '), Location(s): ', @Locations, '    Order:   74 */ ', SQL_STATEMENT ) from SqlGen.PgMonitorQualificationPctInserts(@vMonitorPlanIdTable)

    order by 1;

    select  *
      from  @vMonitorPlanIdTable

end;
