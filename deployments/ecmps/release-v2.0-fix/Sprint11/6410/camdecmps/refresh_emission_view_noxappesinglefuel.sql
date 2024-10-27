CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_noxappesinglefuel
(
    IN vmonplanid character varying,
    IN vrptperiodid NUMERIC
)
 LANGUAGE plpgsql
AS $procedure$
declare 
BEGIN
    RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmps.EMISSION_VIEW_NOXAPPESINGLEFUEL	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;
    RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmps.EMISSION_VIEW_NOXAPPESINGLEFUEL(
		MON_PLAN_ID,
		MON_LOC_ID,
		RPT_PERIOD_ID,
		DATE_HOUR,
		OP_TIME,
		FUEL_SYS_ID,
		FUEL_TYPE,
		FUEL_USE_TIME,
		UNIT_LOAD,
		LOAD_UOM,
		CALC_HI_RATE,
		OPERATING_CONDITION_CD,
		SEGMENT_NUMBER,
		APP_E_SYS_ID,
		RPT_NOX_EMISSION_RATE,
		CALC_NOX_EMISSION_RATE,
		SUMMATION_FORMULA_CD,
		RPT_NOX_EMISSION_RATE_ALL_FUELS,
		CALC_NOX_EMISSION_RATE_ALL_FUELS,
		CALC_HI_RATE_ALL_FUELS,
		NOX_MASS_RATE_FORMULA_CD,
		RPT_NOX_MASS_ALL_FUELS,
		CALC_NOX_MASS_ALL_FUELS,
		ERROR_CODES
	)
    select  dat.MON_PLAN_ID, 
            dat.MON_LOC_ID, 
            dat.RPT_PERIOD_ID, 
            camdecmps.format_date_hour( dat.BEGIN_DATE, dat.BEGIN_HOUR, null ) as DATE_HOUR,
            dat.OP_TIME, 
            dat.FUEL_SYSTEM_IDENTIFIER as FUEL_SYS_ID,
            dat.FUEL_CD as FUEL_TYPE,
            dat.FUEL_USAGE_TIME as FUEL_USE_TIME,
            dat.HR_LOAD as UNIT_LOAD, 
            dat.LOAD_UOM_CD as LOAD_UOM,
            dat.HI_CALC_PARAM_VAL_FUEL as CALC_HI_RATE,
            dat.NOXR_OPERATING_CONDITION_CD,
            dat.NOXR_SEGMENT_NUM as SEGMENT_NUMBER,
            dat.NOXR_APPE_SYSTEM_IDENTIFIER as APP_E_SYS_ID,
            dat.NOXR_PARAM_VAL_FUEL as RPT_NOX_EMISSION_RATE,
            dat.NOXR_CALC_PARAM_VAL_FUEL as CALC_NOX_EMISSION_RATE,
            dat.NOXR_FORMULA_CD as SUMMATION_FORMULA_CD,
            dat.NOXR_ADJUSTED_HRLY_VALUE as RPT_NOX_EMISSION_RATE_ALL_FUELS,
            dat.NOXR_CALC_ADJUSTED_HRLY_VALUE as CALC_NOX_EMISSION_RATE_ALL_FUELS,
            case 
                when ( dat.NOX_HOUR_ID is not null )
                then dat.HI_CALC_ADJUSTED_HRLY_VALUE
            end as CALC_HI_RATE_ALL_FUELS,
            dat.NOX_FORMULA_CD as NOX_MASS_RATE_FORMULA_CD,
            dat.NOX_ADJUSTED_HRLY_VALUE as RPT_NOX_MASS_ALL_FUELS,
            dat.NOX_CALC_ADJUSTED_HRLY_VALUE as CALC_NOX_MASS_ALL_FUELS,
            (
                select  case when max( coalesce( sev.SEVERITY_LEVEL, 0 ) ) > 0 then 'Y' else NULL end
                  from  camdecmpsaux.CHECK_LOG chl
                        left join camdecmpsmd.SEVERITY_CODE sev
                          on sev.SEVERITY_CD = chl.SEVERITY_CD
                 where  chl.CHK_SESSION_ID = dat.CHK_SESSION_ID
                   and  chl.MON_LOC_ID = dat.MON_LOC_ID
                   and  ( chl.OP_BEGIN_DATE < dat.BEGIN_DATE or ( chl.OP_BEGIN_DATE = dat.BEGIN_DATE and chl.OP_BEGIN_HOUR <= dat.BEGIN_HOUR ) )
                   and  ( chl.OP_END_DATE > dat.BEGIN_DATE or ( chl.OP_END_DATE = dat.BEGIN_DATE and chl.OP_END_HOUR >= dat.BEGIN_HOUR ) )
            ) as error_codes
      from  (
                select  mpl.MON_PLAN_ID, 
                        hod.MON_LOC_ID, 
                        hod.RPT_PERIOD_ID,
                        hod.BEGIN_DATE,
                        hod.BEGIN_HOUR,
                        hod.OP_TIME,
                        hod.HR_LOAD,
                        hod.LOAD_UOM_CD,
                        -- HFF
                        hff.FUEL_CD,
                        hff.FUEL_USAGE_TIME,
                        sys_hff.SYSTEM_IDENTIFIER as FUEL_SYSTEM_IDENTIFIER,
                        -- HI HPFF
                        max( case when hpff.PARAMETER_CD = 'HI'   then hpff.CALC_PARAM_VAL_FUEL end ) as HI_CALC_PARAM_VAL_FUEL,
                        -- NOXR HPFF
                        max( case when hpff.PARAMETER_CD = 'NOXR' then hpff.HRLY_FUEL_FLOW_ID end ) as NOXR_HRLY_FUEL_FLOW_ID,
                        max( case when hpff.PARAMETER_CD = 'NOXR' then hpff.PARAM_VAL_FUEL end ) as NOXR_PARAM_VAL_FUEL,
                        max( case when hpff.PARAMETER_CD = 'NOXR' then hpff.CALC_PARAM_VAL_FUEL end ) as NOXR_CALC_PARAM_VAL_FUEL,
                        max( case when hpff.PARAMETER_CD = 'NOXR' then hpff.OPERATING_CONDITION_CD end ) as NOXR_OPERATING_CONDITION_CD,
                        max( case when hpff.PARAMETER_CD = 'NOXR' then hpff.SEGMENT_NUM end ) as NOXR_SEGMENT_NUM,
                        max( case when hpff.PARAMETER_CD = 'NOXR' then sys_hpff.SYSTEM_IDENTIFIER end ) as NOXR_APPE_SYSTEM_IDENTIFIER,
                        -- HI DHV
                        max( case when dhv.PARAMETER_CD  = 'HI'   then dhv.CALC_ADJUSTED_HRLY_VALUE end ) as HI_CALC_ADJUSTED_HRLY_VALUE,
                        -- NOX DHV
                        max( case when dhv.PARAMETER_CD  = 'NOX'  then dhv.HOUR_ID end ) as NOX_HOUR_ID,
                        max( case when dhv.PARAMETER_CD  = 'NOX'  then dhv.ADJUSTED_HRLY_VALUE end ) as NOX_ADJUSTED_HRLY_VALUE,
                        max( case when dhv.PARAMETER_CD  = 'NOX'  then dhv.CALC_ADJUSTED_HRLY_VALUE end ) as NOX_CALC_ADJUSTED_HRLY_VALUE,
                        max( case when dhv.PARAMETER_CD  = 'NOX'  then frm.EQUATION_CD end ) as NOX_FORMULA_CD,
                        -- NOXR DHV
                        max( case when dhv.PARAMETER_CD  = 'NOXR' then dhv.ADJUSTED_HRLY_VALUE end ) as NOXR_ADJUSTED_HRLY_VALUE,
                        max( case when dhv.PARAMETER_CD  = 'NOXR' then dhv.CALC_ADJUSTED_HRLY_VALUE end ) as NOXR_CALC_ADJUSTED_HRLY_VALUE,
                        max( case when dhv.PARAMETER_CD  = 'NOXR' then frm.EQUATION_CD end ) as NOXR_FORMULA_CD,
                        -- Error Information
                        ems.CHK_SESSION_ID
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
                        join camdecmps.HRLY_FUEL_FLOW hff
                          on hff.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
                         and hff.MON_LOC_ID = hod.MON_LOC_ID
                         and hff.HOUR_ID = hod.HOUR_ID
                        left join camdecmps.MONITOR_SYSTEM sys_hff
                          on sys_hff.MON_SYS_ID = hff.MON_SYS_ID
                        join camdecmps.HRLY_PARAM_FUEL_FLOW hpff
                          on hpff.RPT_PERIOD_ID = hff.RPT_PERIOD_ID
                         and hpff.MON_LOC_ID = hff.MON_LOC_ID
                         and hpff.HRLY_FUEL_FLOW_ID = hff.HRLY_FUEL_FLOW_ID
                         and hpff.PARAMETER_CD in ( 'HI', 'NOXR' )
                        left join camdecmps.MONITOR_SYSTEM sys_hpff
                          on sys_hpff.MON_SYS_ID = hpff.MON_SYS_ID
                        left join camdecmps.DERIVED_HRLY_VALUE dhv
                          on dhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
                         and dhv.MON_LOC_ID = hod.MON_LOC_ID
                         and dhv.HOUR_ID = hod.HOUR_ID
                         and dhv.PARAMETER_CD in ( 'HI', 'NOX', 'NOXR' )
                        left join camdecmps.MONITOR_FORMULA frm
                          on frm.MON_FORM_ID = dhv.MON_FORM_ID
                 group
                    by  mpl.MON_PLAN_ID, 
                        hod.MON_LOC_ID, 
                        hod.RPT_PERIOD_ID,
                        hod.BEGIN_DATE,
                        hod.BEGIN_HOUR,
                        hod.OP_TIME,
                        hod.HR_LOAD,
                        hod.LOAD_UOM_CD,
                        hff.FUEL_CD,
                        hff.FUEL_USAGE_TIME,
                        sys_hff.SYSTEM_IDENTIFIER,
                        ems.CHK_SESSION_ID
            ) dat
     where  dat.NOXR_HRLY_FUEL_FLOW_ID is not null;

    RAISE NOTICE 'Refreshing view counts...';
    CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'NOXAPPESINGLEFUEL');
END
$procedure$
