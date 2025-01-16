create or replace procedure camdecmpsaux.PDEM_Update_Init_Load_Mats_Monitor_Hour 
(
    in vPdemReportId bigint,
    out vResult boolean, 
    out vErrorMessage text
)

language plpgsql

as $procedure$

declare
    cRoutineName constant varchar := 'PDEM_Update_Init_Load_Mats_Monitor_Hour';
    
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
          into  camdecmpsaux.PDEM_MATS_MONITOR_HOUR 
                ( 
                    -- Key Information
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
                    -- HG Values and Measure Code
                    Hg_Rate_Eo,
                    Hg_Rate_Hi,
                    Hg_Mass,
                    Hg_Hour_Measure_Cd,
                    -- HCL Values and Measure Code
                    Hcl_Rate_Eo,
                    Hcl_Rate_Hi,
                    Hcl_Mass,
                    Hcl_Hour_Measure_Cd,
                    -- HF Values and Measure Code
                    Hf_Rate_Eo,
                    Hf_Rate_Hi,
                    Hf_Mass,
                    Hf_Hour_Measure_Cd,
                    -- Supporting Information
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
                -- HG Values and Measure Code
                rst.Hg_Rate_Eo,
                rst.Hg_Rate_Hi,
                rst.Hg_Mass,
                rst.Hg_Hour_Measure_Cd,
                -- HCL Values and Measure Code
                rst.Hcl_Rate_Eo,
                rst.Hcl_Rate_Hi,
                rst.Hcl_Mass,
                rst.Hcl_Hour_Measure_Cd,
                -- HF Values and Measure Code
                rst.Hf_Rate_Eo,
                rst.Hf_Rate_Hi,
                rst.Hf_Mass,
                rst.Hf_Hour_Measure_Cd,
                -- Supporting Information
                rst.Mon_Plan_Id,
                rst.Rpt_Period_Id,
                extract( year from rst.Op_Date ) as Op_Year
          from	(
                    select  flt.Mon_Loc_Id,
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
                                when flt.Hit_Hour_Id is not null then flt.Hit
                                else null
                            end as Hit,
                            case
                                when flt.Op_Time = 0 or flt.Op_Time is null then null 
                                when flt.Hit_Hour_Id is not null then flt.Hit_Measure_Cd
                                else null
                            end as Hit_Hour_Measure_Cd,
                            -- HG Values and Measure Code
                            case
                                when flt.Op_Time = 0 or flt.Op_Time is null then null 
                                when flt.Hgre_Hour_Id is not null then flt.Hgre
                                else null
                            end as Hg_Rate_Eo,
                            case
                                when flt.Op_Time = 0 or flt.Op_Time is null then null 
                                when flt.Hgrh_Hour_Id is not null then flt.Hgrh
                                else null
                            end as Hg_Rate_Hi,
                            case
                                when flt.Op_Time = 0 or flt.Op_Time is null then null 
                                when flt.Hgre_Hour_Id is not null then cast( flt.Hgre as numeric ) * ( flt.Gload * flt.Op_Time / 1000 )
                                when flt.Hgrh_Hour_Id is not null then cast( flt.Hgrh as numeric ) * ( flt.Hit / 1000000 )
                            end as Hg_Mass,
                            case
                                when flt.Op_Time = 0 or flt.Op_Time is null then null 
                                when flt.Hgre_Hour_Id is not null then Hgre_Measure_Cd
                                when flt.Hgrh_Hour_Id is not null then Hgrh_Measure_Cd
                                else null
                            end as Hg_Hour_Measure_Cd,
                            -- HCL Values and Measure Code
                            case
                                when flt.Op_Time = 0 or flt.Op_Time is null then null 
                                when flt.Hclre_Hour_Id is not null then flt.Hclre
                                else null
                            end as Hcl_Rate_Eo,
                            case
                                when flt.Op_Time = 0 or flt.Op_Time is null then null 
                                when flt.Hclrh_Hour_Id is not null then flt.Hclrh
                                else null
                            end as Hcl_Rate_Hi,
                            case
                                when flt.Op_Time = 0 or flt.Op_Time is null then null 
                                when flt.Hclre_Hour_Id is not null then cast( flt.Hclre as numeric ) * ( flt.Gload * flt.Op_Time )
                                when flt.Hclrh_Hour_Id is not null then cast( flt.Hclrh as numeric ) * ( flt.Hit )
                            end as Hcl_Mass,
                            case
                                when flt.Op_Time = 0 or flt.Op_Time is null then null 
                                when flt.Hclre_Hour_Id is not null then Hclre_Measure_Cd
                                when flt.Hclrh_Hour_Id is not null then Hclrh_Measure_Cd
                                else null
                            end as Hcl_Hour_Measure_Cd,
                            -- HF Values and Measure Code
                            case
                                when flt.Op_Time = 0 or flt.Op_Time is null then null 
                                when flt.Hfre_Hour_Id is not null then flt.Hfre
                                else null
                            end as Hf_Rate_Eo,
                            case
                                when flt.Op_Time = 0 or flt.Op_Time is null then null 
                                when flt.Hfrh_Hour_Id is not null then flt.Hfrh
                                else null
                            end as Hf_Rate_Hi,
                            case
                                when flt.Op_Time = 0 or flt.Op_Time is null then null 
                                when flt.Hfre_Hour_Id is not null then cast( flt.Hfre as numeric ) * ( flt.Gload * flt.Op_Time )
                                when flt.Hfrh_Hour_Id is not null then cast( flt.Hfrh as numeric ) * ( flt.Hit )
                            end as Hf_Mass,
                            case
                                when flt.Op_Time = 0 or flt.Op_Time is null then null 
                                when flt.Hfre_Hour_Id is not null then Hfre_Measure_Cd
                                when flt.Hfrh_Hour_Id is not null then Hfrh_Measure_Cd
                                else null
                            end as Hf_Hour_Measure_Cd,
                            -- Supporting Information
                            flt.Mon_Plan_Id,
                            flt.Rpt_Period_Id,
                            extract( year from flt.Op_Date ) as Op_Year
                      from	(
                                select  -- Key Information
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
                                                when hod.Mats_Load IS NOT NULL AND hod.Mats_Load > 0 THEN hod.Mats_Load     -- Use Mats_Load if it is not null and > 0
                                                when hod.Load_Uom_Cd = 'MW' then hod.Hr_Load                                -- Otherwise use LOAD if reported in MW
                                                when hod.Mats_Load IS NOT NULL THEN hod.Mats_Load                           -- Otherwise use MATS_LOAD if it is not null (could be equal to or maybe less than 0)
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
                                        max( case when dhv.Parameter_cd = 'HI' then dhv.Hour_Id end ) as Hit_Hour_Id,
                                        max( case when dhv.Parameter_cd = 'HI' then round( dhv.Adjusted_Hrly_Value * hod.Op_Time, 3 ) end ) as Hit,
                                        max( case when dhv.Parameter_cd = 'HI' then dhv.Calc_Hour_Measure_Cd end ) as Hit_Measure_Cd,
                                        -- HG Values and Measure Code
                                        max( case when mdv.Parameter_cd = 'HGRE' then mdv.Hour_Id end ) as Hgre_Hour_Id,
                                        max( case when mdv.Parameter_cd = 'HGRE' then mdv.Unadjusted_Hrly_Value end ) as Hgre,
                                        max( case when mdv.Parameter_cd = 'HGRE' then camdecmpsaux.PDEM_Mats_Modc_To_Measure_Code( mdv.Modc_Cd ) end ) as Hgre_Measure_Cd,
                                        max( case when mdv.Parameter_cd = 'HGRH' then mdv.Hour_Id end ) as Hgrh_Hour_Id,
                                        max( case when mdv.Parameter_cd = 'HGRH' then mdv.Unadjusted_Hrly_Value end ) as Hgrh,
                                        max( case when mdv.Parameter_cd = 'HGRH' then camdecmpsaux.PDEM_Mats_Modc_To_Measure_Code( mdv.Modc_Cd ) end ) as Hgrh_Measure_Cd,
                                        -- HCL Values and Measure Code
                                        max( case when mdv.Parameter_cd = 'HCLRE' then mdv.Hour_Id end ) as Hclre_Hour_Id,
                                        max( case when mdv.Parameter_cd = 'HCLRE' then mdv.Unadjusted_Hrly_Value end ) as Hclre,
                                        max( case when mdv.Parameter_cd = 'HCLRE' then camdecmpsaux.PDEM_Mats_Modc_To_Measure_Code( mdv.Modc_Cd ) end ) as Hclre_Measure_Cd,
                                        max( case when mdv.Parameter_cd = 'HCLRH' then mdv.Hour_Id end ) as Hclrh_Hour_Id,
                                        max( case when mdv.Parameter_cd = 'HCLRH' then mdv.Unadjusted_Hrly_Value end ) as Hclrh,
                                        max( case when mdv.Parameter_cd = 'HCLRH' then camdecmpsaux.PDEM_Mats_Modc_To_Measure_Code( mdv.Modc_Cd ) end ) as Hclrh_Measure_Cd,
                                        -- HF Values and Measure Code
                                        max( case when mdv.Parameter_cd = 'HFRE' then mdv.Hour_Id end ) as Hfre_Hour_Id,
                                        max( case when mdv.Parameter_cd = 'HFRE' then mdv.Unadjusted_Hrly_Value end ) as Hfre,
                                        max( case when mdv.Parameter_cd = 'HFRE' then camdecmpsaux.PDEM_Mats_Modc_To_Measure_Code( mdv.Modc_Cd ) end ) as Hfre_Measure_Cd,
                                        max( case when mdv.Parameter_cd = 'HFRH' then mdv.Hour_Id end ) as Hfrh_Hour_Id,
                                        max( case when mdv.Parameter_cd = 'HFRH' then mdv.Unadjusted_Hrly_Value end ) as Hfrh,
                                        max( case when mdv.Parameter_cd = 'HFRH' then camdecmpsaux.PDEM_Mats_Modc_To_Measure_Code( mdv.Modc_Cd ) end ) as Hfrh_Measure_Cd,
                                        -- Supporting Information
                                        ems.Mon_Plan_Id,
                                        ems.Rpt_Period_Id
                                  from	camdecmps.EMISSION_EVALUATION ems
                                        join camdecmps.MONITOR_PLAN_LOCATION mpl
                                          on mpl.Mon_Plan_Id = ems.Mon_Plan_Id
                                        join camdecmps.HRLY_OP_DATA hod
                                          on hod.Rpt_Period_Id = ems.Rpt_Period_Id
                                         and hod.Mon_Loc_Id = mpl.Mon_Loc_Id
                                        left join camdecmps.DERIVED_HRLY_VALUE dhv
                                          on dhv.Rpt_Period_Id = hod.Rpt_Period_Id
                                         and dhv.Hour_Id = hod.Hour_Id
                                         and dhv.Parameter_Cd = 'HI'
                                        left join camdecmps.MATS_DERIVED_HRLY_VALUE mdv
                                          on mdv.Rpt_Period_Id = hod.Rpt_Period_Id
                                         and mdv.Hour_Id = hod.Hour_Id
                                         and mdv.Parameter_Cd in ( 'HGRE', 'HGRH', 'HCLRE', 'HCLRH', 'HFRE', 'HFRH' )
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
