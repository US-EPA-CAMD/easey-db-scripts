create or replace function camdecmpsaux.PDEM_Update_Init_Get_Combined_Hourly_Data
(
    in vMonPlanId varchar,
    in vRptPeriodId numeric
)
    returns table
            (
                -- Key Information
                Mon_Loc_Id varchar,
                Op_Date date,
                Op_Hour integer,
                -- Op Time and Load Values
                Op_Time numeric,
                Gload numeric,
                Mats_Load numeric,
                Sload numeric,
                Tload numeric,
                -- HIT Value and Measure Code
                Hit numeric,
                Hit_Hour_Measure_Cd varchar,
                -- Part 75 SO2, CO2 and NOx Mass and Rate Values and Measure Codes
                So2m numeric,
                So2m_Hour_Measure_Cd varchar,
                So2r numeric,
                So2r_Hour_Measure_Cd varchar,
                Co2m numeric,
                Co2m_Hour_Measure_Cd varchar,
                Co2r numeric,
                Co2r_Hour_Measure_Cd varchar,
                Noxm numeric,
                Noxm_Hour_Measure_Cd varchar,
                Noxr numeric,
                Noxr_Hour_Measure_Cd varchar,
                -- MATS Hg, HCl and HF Rate and Mass Values and Measure Codes
                Hg_Rate_Eo numeric,
                Hg_Rate_Hi numeric,
                Hg_Mass numeric,
                Hg_Hour_Measure_Cd varchar,
                Hcl_Rate_Eo numeric,
                Hcl_Rate_Hi numeric,
                Hcl_Mass numeric,
                Hcl_Hour_Measure_Cd varchar,
                Hf_Rate_Eo numeric,
                Hf_Rate_Hi numeric,
                Hf_Mass numeric,
                Hf_Hour_Measure_Cd varchar,
                -- Supporting Information
                Mon_Plan_Id varchar,
                Op_Year integer
            )

language plpgsql

as $function$

declare
begin
    
    return query
        select  -- Key Information
                cmb.Mon_Loc_Id,
                cmb.Op_Date,
                cmb.Op_Hour::integer,
                -- Op Time and Load Values
                max( cmb.Op_Time ) as Op_Time,
                max( cmb.Gload ) as Gload,
                max( cmb.Mats_Load ) as Mats_Load,
                max( cmb.Sload ) as Sload,
                max( cmb.Tload ) as Tload,
                -- HIT Value and Measure Code
                max( cmb.Hit ) as Hit,
                max( cmb.Hit_Hour_Measure_Cd )::varchar as Hit_Hour_Measure_Cd,
                -- Part 75 SO2, CO2 and NOx Mass and Rate Values and Measure Codes
                max( cmb.So2m ) as So2m,
                max( cmb.So2m_Hour_Measure_Cd )::varchar as So2m_Hour_Measure_Cd,
                max( cmb.So2r ) as So2r,
                max( cmb.So2r_Hour_Measure_Cd )::varchar as So2r_Hour_Measure_Cd,
                max( cmb.Co2m ) as Co2m,
                max( cmb.Co2m_Hour_Measure_Cd )::varchar as Co2m_Hour_Measure_Cd,
                max( cmb.Co2r ) as Co2r,
                max( cmb.Co2r_Hour_Measure_Cd )::varchar as Co2r_Hour_Measure_Cd,
                max( cmb.Noxm ) as Noxm,
                max( cmb.Noxm_Hour_Measure_Cd )::varchar as Noxm_Hour_Measure_Cd,
                max( cmb.Noxr ) as Noxr,
                max( cmb.Noxr_Hour_Measure_Cd )::varchar as Noxr_Hour_Measure_Cd,
                -- MATS Hg, HCl and HF Rate and Mass Values and Measure Codes
                max( cmb.Hg_Rate_Eo ) as Hg_Rate_Eo,
                max( cmb.Hg_Rate_Hi ) as Hg_Rate_Hi,
                max( cmb.Hg_Mass ) as Hg_Mass,
                max( cmb.Hg_Hour_Measure_Cd )::varchar as Hg_Hour_Measure_Cd,
                max( cmb.Hcl_Rate_Eo ) as Hcl_Rate_Eo,
                max( cmb.Hcl_Rate_Hi ) as Hcl_Rate_Hi,
                max( cmb.Hcl_Mass ) as Hcl_Mass,
                max( cmb.Hcl_Hour_Measure_Cd )::varchar as Hcl_Hour_Measure_Cd,
                max( cmb.Hf_Rate_Eo ) as Hf_Rate_Eo,
                max( cmb.Hf_Rate_Hi ) as Hf_Rate_Hi,
                max( cmb.Hf_Mass ) as Hf_Mass,
                max( cmb.Hf_Hour_Measure_Cd )::varchar as Hf_Hour_Measure_Cd,
                -- Supporting Information
                cmb.Mon_Plan_Id,
                cmb.Op_Year::integer
          from 	(
                    -- Part 75 Data
                    select  -- Key Information
                            dat.Mon_Loc_Id,
                            dat.Op_Date,
                            dat.Op_Hour,
                            'P75' as Source_Cd,
                            -- Op Time and Load Values
                            dat.Op_Time,
                            dat.Gload,
                            null as Mats_Load,
                            dat.Sload,
                            dat.tload,
                            -- HIT Value and Measure Code
                            dat.Hit,
                            dat.Hit_Hour_Measure_Cd,
                            -- Part 75 SO2, CO2 and NOx Mass and Rate Values and Measure Codes
                            dat.So2m,
                            dat.So2m_Hour_Measure_Cd,
                            dat.So2r,
                            dat.So2r_Hour_Measure_Cd,
                            dat.Co2m,
                            dat.Co2m_Hour_Measure_Cd,
                            dat.Co2r,
                            dat.Co2r_Hour_Measure_Cd,
                            dat.Noxm,
                            dat.Noxm_Hour_Measure_Cd,
                            dat.Noxr,
                            dat.Noxr_Hour_Measure_Cd,
                            -- MATS Hg, HCl and HF Rate and Mass Values and Measure Codes
                            null as Hg_Rate_Eo,
                            null as Hg_Rate_Hi,
                            null as Hg_Mass,
                            null as Hg_Hour_Measure_Cd,
                            null as Hcl_Rate_Eo,
                            null as Hcl_Rate_Hi,
                            null as Hcl_Mass,
                            null as Hcl_Hour_Measure_Cd,
                            null as Hf_Rate_Eo,
                            null as Hf_Rate_Hi,
                            null as Hf_Mass,
                            null as Hf_Hour_Measure_Cd,
                            -- Supporting Information
                            dat.Mon_Plan_Id,
                            dat.Op_Year
                      from  camdecmpsaux.PDEM_P75_MONITOR_HOUR dat
                     where  dat.Rpt_Period_Id = vRptPeriodId
                       and  dat.Mon_Plan_Id = vMonPlanId
                     union  all
                    -- MATS DF
                    select  -- Key Information
                            dat.Mon_Loc_Id,
                            dat.Op_Date,
                            dat.Op_Hour,
                            'MATS' as Source_Cd,
                            -- Op Time and Load Values
                            dat.Op_Time,
                            null as Gload,
                            dat.Gload as Mats_Load,
                            null as Sload,
                            null as tload,
                            -- HIT Value and Measure Code
                            dat.Hit,
                            dat.Hit_Hour_Measure_Cd,
                            -- Part 75 SO2, CO2 and NOx Mass and Rate Values and Measure Codes
                            null as So2m,
                            null as So2m_Hour_Measure_Cd,
                            null as So2r,
                            null as So2r_Hour_Measure_Cd,
                            null as Co2m,
                            null as Co2m_Hour_Measure_Cd,
                            null as Co2r,
                            null as Co2r_Hour_Measure_Cd,
                            null as Noxm,
                            null as Noxm_Hour_Measure_Cd,
                            null as Noxr,
                            null as Noxr_Hour_Measure_Cd,
                            -- MATS Hg, HCl and HF Rate and Mass Values and Measure Codes
                            dat.Hg_Rate_Eo::numeric as Hg_Rate_Eo,
                            dat.Hg_Rate_Hi::numeric as Hg_Rate_Hi,
                            dat.Hg_Mass as Hg_Mass,
                            dat.Hg_Hour_Measure_Cd as Hg_Hour_Measure_Cd,
                            dat.Hcl_Rate_Eo::numeric as Hcl_Rate_Eo,
                            dat.Hcl_Rate_Hi::numeric as Hcl_Rate_Hi,
                            dat.Hcl_Mass as Hcl_Mass,
                            dat.Hcl_Hour_Measure_Cd as Hcl_Hour_Measure_Cd,
                            dat.Hf_Rate_Eo::numeric as Hf_Rate_Eo,
                            dat.Hf_Rate_Hi::numeric as Hf_Rate_Hi,
                            dat.Hf_Mass as Hf_Mass,
                            dat.Hf_Hour_Measure_Cd as Hf_Hour_Measure_Cd,
                            -- Supporting Information
                            dat.Mon_Plan_Id,
                            dat.Op_Year
                      from  camdecmpsaux.PDEM_MATS_MONITOR_HOUR dat
                     where  dat.Rpt_Period_Id = vRptPeriodId
                       and  dat.Mon_Plan_Id = vMonPlanId
                ) cmb
         group
            by  cmb.Mon_Loc_Id,
                cmb.Op_Date,
                cmb.Op_Hour,
                cmb.Mon_Plan_Id,
                cmb.Op_Year;

end;

$function$;
