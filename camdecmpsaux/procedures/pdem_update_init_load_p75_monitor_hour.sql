create or replace procedure camdecmpsaux.PDEM_Update_Init_Load_P75_Monitor_Hour 
(
    in vPdemReportId bigint,
    out vResult boolean, 
    out vErrorMessage text
)

language plpgsql

as $procedure$

declare
    cRoutineName constant varchar := 'PDEM_Update_Init_Load_P75_Monitor_Hour';
    
    vCount integer;
    vMonPlanId varchar;
    vRptPeriodId numeric;
    
    vSqlState text;
    vErrorContext text;
begin

    -- Get MON_PLAN_ID and RPT_PERIOD_ID
    select  max( rpt.Mon_Plan_Id ),
            max( rpt.RPT_PERIOD_Id ),
            count( 1 )
      into  vMonPlanId,
            vRptPeriodId,
            vCount
      from  camdecmpsaux.PDEM_REPORT rpt
     where  rpt.Pdem_Report_Id = vPdemReportId;
    
    
    -- Ensure that the specified PDEM_REPORT row EXISTS
    if ( vCount > 0 )
    then
    
        -- Insert statements for procedure here
        insert
          into  camdecmpsaux.PDEM_P75_MONITOR_HOUR 
                (
                    Pdem_Report_Id,
                    Mon_Loc_Id,
                    Op_Date,
                    Op_Hour,
                    Op_Time,
                    Gload,
                    Sload,
                    Tload,
                    Hit,
                    Hit_Hour_Measure_Cd,
                    So2m,
                    So2m_Hour_Measure_Cd,
                    So2r,
                    So2r_Hour_Measure_Cd,
                    Noxm,
                    Noxm_Hour_Measure_Cd,
                    Noxr,
                    Noxr_Hour_Measure_Cd,
                    Co2m,
                    Co2m_Hour_Measure_Cd,
                    Co2r,
                    Co2r_Hour_Measure_Cd,
                    Mon_Plan_Id,
                    Rpt_Period_Id,
                    Op_Year
                )
        select  vPdemReportId as Pdem_Report_Id,
                rst.Mon_Loc_Id,
                rst.Op_Date,
                rst.Op_Hour,
                -- Op Time and Load Values
                rst.Op_Time,
                rst.Gload,
                rst.Sload,
                rst.Tload,
                -- HI Values, Measure Codes and Fuel Flow Values
                rst.Hit,
                rst.Hit_Hour_Measure_Cd,
                -- SO2 Values and Measure Codes
                rst.So2m,
                rst.So2m_Hour_Measure_Cd,
                case
                    when rst.So2m is not null and rst.Hit > 0 then round( rst.So2m / rst.Hit, 3 )
                    else null
                end as So2r,
                case
                    when rst.So2m is not null and rst.Hit > 0 then 'CALC'
                    else null
                end as So2r_Hour_Measure_Cd,
                -- NOx Value and Measure Code
                rst.Noxm,
                rst.Noxm_Hour_Measure_Cd,
                rst.Noxr,
                rst.Noxr_Hour_Measure_Cd,
                -- CO2 Values and Measure Codes
                rst.Co2m,
                rst.Co2m_Hour_Measure_Cd,
                case
                    when rst.Co2m is not null and rst.Hit > 0 then round( rst.Co2m / rst.Hit, 3 )
                    else null
                end as Co2r,
                case
                    when rst.Co2m is not null and rst.Hit > 0 then 'CALC'
                    else null
                end as Co2r_Hour_Measure_Cd,
                -- Supporting Information
                rst.Mon_Plan_Id,
                rst.Rpt_Period_Id,
                extract( year from rst.Op_Date ) as Op_Year
          from	(
                    select  -- Key Information
                            flt.Mon_Plan_Id,
                            flt.Rpt_Period_Id,
                            flt.Mon_Loc_Id,
                            flt.Op_Date,
                            flt.Op_Hour,
                            -- Op Time and Load Values
                            flt.Op_Time,
                            flt.Gload,
                            flt.Sload,
                            flt.Tload,
                            -- HI Values, Measure Codes and Fuel Flow Values
                            case
                                when flt.Op_Time = 0 or flt.Op_Time is null then null 
                                when flt.Hit_Hour_Id_From_Hi is not null then flt.Hit_From_Hi
                                when flt.Hit_Hour_Id_From_Hit is not null then flt.Hit_From_Hit
                                else null
                            end as Hit,
                            case
                                when flt.Op_Time = 0 or flt.Op_Time is null then null 
                                when flt.Hit_Hour_Id_From_Hi is not null then flt.Hit_Measure_From_Hi
                                when flt.Hit_Hour_Id_From_Hit is not null then flt.Hit_Measure_From_Hit
                                else null
                            end as Hit_Hour_Measure_Cd,
                            -- SO2 Values and Measure Codes
                            case
                                when flt.Op_Time = 0 or flt.Op_Time is null then null 
                                when flt.So2m_Hour_Id_From_So2 is not null then flt.So2m_From_So2
                                when flt.So2m_Hour_Id_From_So2m is not null then flt.So2m_From_So2m
                                else null
                            end as So2m,
                            case
                                when flt.Op_Time = 0 or flt.Op_Time is null then null 
                                when flt.So2m_Hour_Id_From_So2 is not null then flt.So2m_Measure_From_So2
                                when flt.So2m_Hour_Id_From_So2m is not null then flt.So2m_Measure_From_So2m
                                else null
                            end as So2m_Hour_Measure_Cd,
                            -- NOx Value and Measure Code
                            case
                                when flt.Op_Time = 0 or flt.Op_Time is null then null 
                                when flt.Noxm_Hour_Id_From_Nox is not null then flt.Noxm_From_Nox
                                when flt.Noxm_Hour_Id_From_Noxm is not null then flt.Noxm_From_Noxm
                                else null
                            end as Noxm,
                            case
                                when flt.Op_Time = 0 or flt.Op_Time is null then null 
                                when flt.Noxm_Hour_Id_From_Nox is not null then flt.Noxm_Measure_From_Nox
                                when flt.Noxm_Hour_Id_From_Noxm is not null then flt.Noxm_Measure_From_Noxm
                                else null
                            end as Noxm_Hour_Measure_Cd,
                            case
                                when flt.Op_Time = 0 or flt.Op_Time is null then null 
                                when flt.Noxr_Hour_Id is not null then flt.Noxr
                                else null
                            end as Noxr,
                            case
                                when flt.Op_Time = 0 or flt.Op_Time is null then null 
                                when flt.Noxr_Hour_Id is not null then flt.Noxr_Measure
                                else null
                            end as Noxr_Hour_Measure_Cd,
                            -- CO2 Values and Measure Codes
                            case
                                when flt.Op_Time = 0 or flt.Op_Time is null then null 
                                when flt.Co2m_Hour_Id_From_Co2 is not null then flt.Co2m_From_Co2
                                when flt.Co2m_Hour_Id_From_Co2m is not null then flt.Co2m_From_Co2m
                                when flt.Co2m_From_Co2d is not null then flt.Co2m_From_Co2d
                                else null
                            end as Co2m,
                            case
                                when flt.Op_Time = 0 or flt.Op_Time is null then null 
                                when flt.Co2m_Hour_Id_From_Co2 is not null then flt.Co2m_Measure_From_Co2
                                when flt.Co2m_Hour_Id_From_Co2m is not null then flt.Co2m_Measure_From_Co2m
                                when flt.Co2m_From_Co2d is not null then flt.Co2m_Measure_From_Co2d
                                else null
                            end as Co2m_Hour_Measure_Cd
                      from	(
                                select  -- Key Information
                                        ems.Mon_Plan_Id,
                                        ems.Rpt_Period_Id,
                                        hod.Mon_Loc_Id,
                                        hod.Begin_Date as Op_Date,
                                        hod.Begin_Hour as Op_Hour,
                                        -- Op Time
                                        max( hod.Op_Time ) as Op_Time,
                                        -- Load Values
                                        max
                                        (
                                            case 
                                                when hod.Op_Time = 0 or hod.Op_Time is null then null
                                                when hod.Load_Uom_Cd = 'MW' then hod.Hr_Load 
                                                else null 
                                            end
                                        ) as Gload,
                                        max
                                        (
                                            case 
                                                when hod.Op_Time = 0 or hod.Op_Time is null then null
                                                when hod.Load_Uom_Cd = 'KLBHR' then hod.Hr_Load 
                                                else null 
                                            end
                                        ) as Sload,
                                        max
                                        (
                                            case 
                                                when hod.Op_Time = 0 or hod.Op_Time is null then null
                                                when hod.Load_Uom_Cd = 'MMBTUHR' then hod.Hr_Load 
                                                else null 
                                            end
                                        ) as Tload,
                                        -- HI Values, Measure Codes and Fuel Flow Values
                                        max( case when dhv.Parameter_cd = 'HI'    then dhv.Hour_Id end ) as Hit_Hour_Id_From_Hi,
                                        max( case when dhv.Parameter_cd = 'HI'    then round( dhv.Adjusted_Hrly_Value * hod.Op_Time, 3 ) end ) as Hit_From_Hi,
                                        max( case when dhv.Parameter_cd = 'HI'    then dhv.Calc_Hour_Measure_Cd end ) as Hit_Measure_From_Hi,
                                        max( case when dhv.Parameter_cd = 'HIT'   then dhv.Hour_Id end ) as Hit_Hour_Id_From_Hit,
                                        max( case when dhv.Parameter_cd = 'HIT'   then dhv.Adjusted_Hrly_Value  end ) as Hit_From_Hit,
                                        max( case when dhv.Parameter_cd = 'HIT'   then dhv.Calc_Hour_Measure_Cd end ) as Hit_Measure_From_Hit,
                                        -- SO2 Values and Measure Codes
                                        max( case when dhv.Parameter_cd = 'SO2'   then dhv.Hour_Id end ) as So2m_Hour_Id_From_So2,
                                        max( case when dhv.Parameter_cd = 'SO2'   then round( dhv.Adjusted_Hrly_Value * hod.Op_Time, 3 ) end ) as So2m_From_So2,
                                        max( case when dhv.Parameter_cd = 'SO2'   then dhv.Calc_Hour_Measure_Cd end ) as So2m_Measure_From_So2,
                                        max( case when dhv.Parameter_cd = 'SO2M'  then dhv.Hour_Id end ) as So2m_Hour_Id_From_So2m,
                                        max( case when dhv.Parameter_cd = 'SO2M'  then dhv.Adjusted_Hrly_Value  end ) as So2m_From_So2m,
                                        max( case when dhv.Parameter_cd = 'SO2M'  then dhv.Calc_Hour_Measure_Cd end ) as So2m_Measure_From_So2m,
                                        -- NOx Value and Measure Code
                                        max( case when dhv.Parameter_cd = 'NOX'   then dhv.Hour_Id end ) as Noxm_Hour_Id_From_Nox,
                                        max( case when dhv.Parameter_cd = 'NOX'   then round( dhv.Adjusted_Hrly_Value * hod.Op_Time, 3 ) end ) as Noxm_From_Nox,
                                        max( case when dhv.Parameter_cd = 'NOX'   then dhv.Calc_Hour_Measure_Cd end ) as Noxm_Measure_From_Nox,
                                        max( case when dhv.Parameter_cd = 'NOXM'  then dhv.Hour_Id end ) as Noxm_Hour_Id_From_Noxm,
                                        max( case when dhv.Parameter_cd = 'NOXM'  then dhv.Adjusted_Hrly_Value  end ) as Noxm_From_Noxm,
                                        max( case when dhv.Parameter_cd = 'NOXM'  then dhv.Calc_Hour_Measure_Cd end ) as Noxm_Measure_From_Noxm,
                                        max( case when dhv.Parameter_cd = 'NOXR'  then dhv.Hour_Id end ) as Noxr_Hour_Id,
                                        max( case when dhv.Parameter_cd = 'NOXR'  then dhv.Adjusted_Hrly_Value  end ) as Noxr,
                                        max( case when dhv.Parameter_cd = 'NOXR'  then dhv.Calc_Hour_Measure_Cd end ) as Noxr_Measure,
                                        -- CO2M Value and Measure Code
                                        max( case when dhv.Parameter_cd = 'CO2'   then dhv.Hour_Id end ) as Co2m_Hour_Id_From_Co2,
                                        max( case when dhv.Parameter_cd = 'CO2'   then round( dhv.Adjusted_Hrly_Value * hod.Op_Time, 3 ) end ) as Co2m_From_Co2,
                                        max( case when dhv.Parameter_cd = 'CO2'   then dhv.Calc_Hour_Measure_Cd end ) as Co2m_Measure_From_Co2,
                                        max( case when dhv.Parameter_cd = 'CO2M'   then dhv.Hour_Id end ) as Co2m_Hour_Id_From_Co2m,
                                        max( case when dhv.Parameter_cd = 'CO2M'  then dhv.Adjusted_Hrly_Value  end ) as Co2m_From_Co2m,
                                        max( case when dhv.Parameter_cd = 'CO2M'  then dhv.Calc_Hour_Measure_Cd end ) as Co2m_Measure_From_Co2m,
                                        max( case when dem.Mon_Loc_Id is not null then round( dem.Total_Daily_Emission * ( hod.Op_Time / dem.Calc_Total_Op_Time ), 3 )  end ) as Co2m_From_Co2d,
                                        max( case when dem.Mon_Loc_Id is not null then 'OTHER' end ) as Co2m_Measure_From_Co2d
                                  from	camdecmps.EMISSION_EVALUATION ems
                                        join camdecmps.MONITOR_PLAN_LOCATION mpl
                                          on mpl.Mon_Plan_Id = ems.Mon_Plan_Id
                                        join camdecmps.HRLY_OP_DATA hod
                                          on hod.Rpt_Period_Id = ems.Rpt_Period_Id
                                         and hod.Mon_Loc_Id = mpl.Mon_Loc_Id
                                        left join camdecmps.DERIVED_HRLY_VALUE dhv
                                          on dhv.Rpt_Period_Id = hod.Rpt_Period_Id
                                         and dhv.Hour_Id = hod.Hour_Id
                                        left join camdecmps.DAILY_EMISSION dem
                                          on dem.Rpt_Period_Id = ems.Rpt_Period_Id
                                         and dem.Mon_Loc_Id = mpl.Mon_Loc_Id
                                         and dem.Begin_Date = hod.Begin_Date
                                 where  ems.Rpt_Period_Id = vRptPeriodId
                                   and  ems.Mon_Plan_Id = vMonPlanId
                                 group
                                    by	ems.Mon_Plan_Id,
                                        ems.Rpt_Period_Id,
                                        hod.Mon_Loc_Id,
                                        hod.Begin_Date,
                                        hod.Begin_Hour
                            ) flt
                ) rst;
        
        vResult := true;
        vErrorMessage := '';
    
    else
        vResult := false;
        vErrorMessage := concat( cRoutineName, ': ', 'PDEM Report row does not exist. (Id: ', vPdemReportId, ')' );
    end if;
    
exception when others then	
    
    get stacked diagnostics 
        vSqlState := returned_sqlstate,
        vErrorMessage := message_text,
        vErrorContext := pg_exception_context;
    
    raise notice 'SQL State: %', vSqlState;
    raise notice 'Error Message: %', vErrorMessage;
    raise notice 'Error Context: %', vErrorContext;
    
    vResult := false;
    vErrorMessage := concat( cRoutineName, ': ', vErrorMessage );
    
end;

$procedure$;
