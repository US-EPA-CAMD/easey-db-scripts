CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_lme
(
    IN vmonplanid character varying,
    IN vrptperiodid NUMERIC
)
 LANGUAGE plpgsql
AS $procedure$
DECLARE
BEGIN    
    RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmps.EMISSION_VIEW_LME	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;
    RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmps.EMISSION_VIEW_LME(		MON_PLAN_ID,		MON_LOC_ID,		RPT_PERIOD_ID,		DATE_HOUR,		OP_TIME,		UNIT_LOAD,		LOAD_UOM,		HOUR_ID,		HI_MODC,		RPT_HEAT_INPUT,		CALC_HEAT_INPUT,		SO2M_FUEL_TYPE,		SO2_EMISS_RATE,		RPT_SO2_MASS,		CALC_SO2_MASS,		NOXM_FUEL_TYPE,		OPERATING_CONDITION_CD,		NOX_EMISS_RATE,		RPT_NOX_MASS,		CALC_NOX_MASS,		CO2M_FUEL_TYPE,		CO2_EMISS_RATE,		RPT_CO2_MASS,		CALC_CO2_MASS,		ERROR_CODES	)    select  dat.MON_PLAN_ID, 
            dat.MON_LOC_ID, 
            dat.RPT_PERIOD_ID,
            camdecmps.format_date_hour( dat.BEGIN_DATE, dat.BEGIN_HOUR, null ) as DATE_HOUR,
            dat.OP_TIME,
            dat.HR_LOAD as UNIT_LOAD,
            dat.LOAD_UOM_CD as LOAD_UOM,
            dat.HOUR_ID,
            dat.HIT_MODC_CD as HI_MODC,
            dat.HIT_ADJUSTED_HRLY_VALUE as RPT_HEAT_INPUT,
            dat.HIT_CALC_ADJUSTED_HRLY_VALUE as CALC_HEAT_INPUT,
            dat.SO2M_FUEL_CD as SO2M_FUEL_TYPE,
            dat.SO2R_DEFAULT_VALUE as SO2_EMISS_RATE,
            dat.SO2M_ADJUSTED_HRLY_VALUE as RPT_SO2_MASS,
            dat.SO2M_CALC_ADJUSTED_HRLY_VALUE as CALC_SO2_MASS,
            dat.NOXM_FUEL_CD as NOXM_FUEL_TYPE,
            dat.NOXM_OPERATING_CONDITION_CD,
            case
                when dat.NOXR_DEFAULT_VALUE is not null then dat.NOXR_DEFAULT_VALUE
                when dat.NORX_DEFAULT_VALUE is not null then dat.NORX_DEFAULT_VALUE
                else null
            end as NOX_EMISS_RATE,
            dat.NOXM_ADJUSTED_HRLY_VALUE as RPT_NOX_MASS,
            dat.NOXM_CALC_ADJUSTED_HRLY_VALUE as CALC_NOX_MASS,
            dat.CO2M_FUEL_CD as CO2M_FUEL_TYPE,
            dat.CO2R_DEFAULT_VALUE as CO2_EMISS_RATE,
            dat.CO2M_ADJUSTED_HRLY_VALUE as RPT_CO2_MASS,
            dat.CO2M_CALC_ADJUSTED_HRLY_VALUE as CALC_CO2_MASS,
            (
                select  case when max( coalesce( sev.SEVERITY_LEVEL, 0 ) ) > 0 then 'Y' else null end
                  from  camdecmpsaux.CHECK_LOG chl
                        left join camdecmpsmd.SEVERITY_CODE sev
                          on sev.SEVERITY_CD = chl.SEVERITY_CD
                 where  chl.CHK_SESSION_ID = dat.CHK_SESSION_ID
                   and  chl.MON_LOC_ID = dat.MON_LOC_ID
                   and  ( chl.OP_BEGIN_DATE < dat.BEGIN_DATE or ( chl.OP_BEGIN_DATE = dat.BEGIN_DATE and chl.OP_BEGIN_HOUR <= dat.BEGIN_HOUR ) )
                   and  ( chl.OP_END_DATE > dat.BEGIN_DATE or ( chl.OP_END_DATE = dat.BEGIN_DATE and chl.OP_END_HOUR >= dat.BEGIN_HOUR ) )
            ) as ERROR_CODES
      from  (
                select  hod.HOUR_ID,
                        mpl.MON_PLAN_ID, 
                        hod.MON_LOC_ID, 
                        hod.RPT_PERIOD_ID,
                        hod.BEGIN_DATE,
                        hod.BEGIN_HOUR,
                        hod.OP_TIME,
                        hod.HR_LOAD,
                        hod.LOAD_UOM_CD,
                        ems.CHK_SESSION_ID,
                        -- CO2M
                        max( case when dhv.PARAMETER_CD = 'CO2M' then dhv.ADJUSTED_HRLY_VALUE end ) as CO2M_ADJUSTED_HRLY_VALUE,
                        max( case when dhv.PARAMETER_CD = 'CO2M' then dhv.CALC_ADJUSTED_HRLY_VALUE end ) as CO2M_CALC_ADJUSTED_HRLY_VALUE,
                        max( case when dhv.PARAMETER_CD = 'CO2M' then dhv.FUEL_CD end ) as CO2M_FUEL_CD,
                        -- HIT
                        max( case when dhv.PARAMETER_CD = 'HIT'  then dhv.ADJUSTED_HRLY_VALUE end ) as HIT_ADJUSTED_HRLY_VALUE,
                        max( case when dhv.PARAMETER_CD = 'HIT'  then dhv.CALC_ADJUSTED_HRLY_VALUE end ) as HIT_CALC_ADJUSTED_HRLY_VALUE,
                        max( case when dhv.PARAMETER_CD = 'HIT'  then dhv.MODC_CD end ) as HIT_MODC_CD,
                        -- NOXM
                        max( case when dhv.PARAMETER_CD = 'NOXM' then dhv.ADJUSTED_HRLY_VALUE end ) as NOXM_ADJUSTED_HRLY_VALUE,
                        max( case when dhv.PARAMETER_CD = 'NOXM' then dhv.CALC_ADJUSTED_HRLY_VALUE end ) as NOXM_CALC_ADJUSTED_HRLY_VALUE,
                        max( case when dhv.PARAMETER_CD = 'NOXM' then dhv.FUEL_CD end ) as NOXM_FUEL_CD,
                        max( case when dhv.PARAMETER_CD = 'NOXM' then dhv.OPERATING_CONDITION_CD end ) as NOXM_OPERATING_CONDITION_CD,
                        -- SO2M
                        max( case when dhv.PARAMETER_CD = 'SO2M' then dhv.ADJUSTED_HRLY_VALUE end ) as SO2M_ADJUSTED_HRLY_VALUE,
                        max( case when dhv.PARAMETER_CD = 'SO2M' then dhv.CALC_ADJUSTED_HRLY_VALUE end ) as SO2M_CALC_ADJUSTED_HRLY_VALUE,
                        max( case when dhv.PARAMETER_CD = 'SO2M' then dhv.FUEL_CD end ) as SO2M_FUEL_CD,
                        -- Defaults
                        max
                        (
                            case
                                when def.PARAMETER_CD = 'CO2R' and dhv.PARAMETER_CD = 'CO2M' and def.FUEL_CD = dhv.FUEL_CD
                                then def.DEFAULT_VALUE
                            end
                        ) as CO2R_DEFAULT_VALUE,
                        max
                        (
                            case
                                when def.PARAMETER_CD = 'NORX' and dhv.PARAMETER_CD = 'NOXM' and def.FUEL_CD = dhv.FUEL_CD
                                     and def.OPERATING_CONDITION_CD = 'U'
                                then def.DEFAULT_VALUE
                            end
                        ) as NORX_DEFAULT_VALUE,
                        max
                        (
                            case
                                when def.PARAMETER_CD = 'NOXR' and dhv.PARAMETER_CD = 'NOXM' and def.FUEL_CD = dhv.FUEL_CD
                                     and def.OPERATING_CONDITION_CD != 'U'
                                     and def.OPERATING_CONDITION_CD = coalesce( dhv.OPERATING_CONDITION_CD, 'A' )
                                then def.DEFAULT_VALUE
                            end
                        ) as NOXR_DEFAULT_VALUE,
                        max
                        (
                            case
                                when def.PARAMETER_CD = 'SO2R' and dhv.PARAMETER_CD = 'SO2M' and def.FUEL_CD = dhv.FUEL_CD
                                then def.DEFAULT_VALUE
                            end
                        ) as SO2R_DEFAULT_VALUE
                  from  (
                            select  vmonplanid as MON_PLAN_ID,
                                    vrptperiodid as RPT_PERIOD_ID
                        ) sel
                        join camdecmps.MONITOR_PLAN_LOCATION mpl
                          on mpl.MON_PLAN_ID = sel.MON_PLAN_ID
                        join camdecmps.EMISSION_EVALUATION ems
                          on ems.RPT_PERIOD_ID = sel.RPT_PERIOD_ID
                         and ems.MON_PLAN_ID = mpl.MON_PLAN_ID
                        join camdecmps.HRLY_OP_DATA hod 
                          on hod.rpt_period_id = ems.rpt_period_id
                         and hod.mon_loc_id = mpl.mon_loc_id
                        join camdecmps.DERIVED_HRLY_VALUE dhv
                          on dhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
                         and dhv.MON_LOC_ID = hod.MON_LOC_ID
                         and dhv.HOUR_ID = hod.HOUR_ID
                         and dhv.PARAMETER_CD in ( 'CO2M', 'HIT', 'NOXM', 'SO2M' )
                        left join camdecmps.MONITOR_DEFAULT as def 
                          on def.MON_LOC_ID = hod.MON_LOC_ID
                         and ( def.PARAMETER_CD, def.DEFAULT_PURPOSE_CD, def.DEFAULT_UOM_CD ) in ( ( 'CO2R', 'LM', 'TNMMBTU' ), ( 'NORX', 'MD', 'LBMMBTU' ), ( 'NOXR', 'LM', 'LBMMBTU' ), ( 'SO2R', 'LM', 'LBMMBTU' ) )
                         and ( def.BEGIN_DATE + ( def.BEGIN_HOUR || ' hour' )::interval ) <= ( hod.BEGIN_DATE + ( hod.BEGIN_HOUR || ' hour' )::interval )
                         and ( ( def.END_DATE is null ) or ( def.END_DATE + ( def.END_HOUR || ' hour' )::interval ) >= ( hod.BEGIN_DATE + ( hod.BEGIN_HOUR || ' hour' )::interval ) )

                 group
                    by  hod.hour_id,
                        mpl.MON_PLAN_ID, 
                        hod.MON_LOC_ID, 
                        hod.RPT_PERIOD_ID,
                        hod.BEGIN_DATE,
                        hod.BEGIN_HOUR,
                        hod.OP_TIME,
                        hod.HR_LOAD,
                        hod.LOAD_UOM_CD,
                        ems.CHK_SESSION_ID
        ) dat;
    
    
    RAISE NOTICE 'Refreshing view counts...';
    CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'LME');
END
$procedure$
