CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_all(IN vmonplanid character varying, IN vrptperiodid numeric)
 LANGUAGE plpgsql
AS $procedure$
DECLAREBEGIN
    RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmpswks.EMISSION_VIEW_ALL	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;
    RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmpswks.EMISSION_VIEW_ALL(		MON_PLAN_ID,		MON_LOC_ID,		RPT_PERIOD_ID,		HOUR_ID,		DATE_HOUR,		OP_TIME,		UNIT_LOAD,		LOAD_UOM,		HI_FORMULA_cd,		RPT_HI_RATE,		CALC_HI_RATE,		SO2_FORMULA_cd,		RPT_SO2_MASS_RATE,		CALC_SO2_MASS_RATE,		nox_rate_formula_cd,		RPT_ADJ_NOX_RATE,		CALC_ADJ_NOX_RATE,		nox_mass_formula_cd,		RPT_NOX_MASS,		CALC_NOX_MASS,		CO2_FORMULA_cd,		RPT_CO2_MASS_RATE,		CALC_CO2_MASS_RATE,		ADJ_FLOW_USED,		RPT_ADJ_FLOW,		UNADJ_FLOW,		ERROR_CODES	)    select  dat.MON_PLAN_ID, 
            dat.MON_LOC_ID, 
            dat.RPT_PERIOD_ID,
            dat.HOUR_ID,
            camdecmpswks.format_date_hour( dat.BEGIN_DATE, dat.BEGIN_HOUR, null ) AS date_hour,
            dat.OP_TIME,
            dat.HR_LOAD,
            dat.LOAD_UOM_CD,
            dat.HI_FORMULA_CD,
            dat.HI_RPT_VALUE,
            dat.HI_CALC_VALUE,
            dat.SO2_FORMULA_CD,
            dat.SO2_RPT_VALUE,
            dat.SO2_CALC_VALUE,
            dat.NOXR_FORMULA_CD,
            dat.NOXR_RPT_VALUE,
            dat.NOXR_CALC_VALUE,
            dat.NOX_FORMULA_CD,
            dat.NOX_RPT_VALUE,
            dat.NOX_CALC_VALUE,
            dat.CO2_FORMULA_CD,
            dat.CO2_RPT_VALUE,
            dat.CO2_CALC_VALUE,
            dat.FLOW_CALC_ADJ_VALUE,
            dat.FLOW_RPT_ADJ_VALUE,
            dat.FLOW_RPT_UNADJ_VALUE,
            (
                select  case when max( coalesce( sev.SEVERITY_LEVEL, 0 ) ) > 0 then 'Y' else NULL end
                  from  camdecmpswks.CHECK_LOG chl
                        left join camdecmpsmd.SEVERITY_CODE sev
                          on sev.SEVERITY_CD = chl.SEVERITY_CD
                 where  chl.CHK_SESSION_ID = dat.CHK_SESSION_ID
                   and  chl.MON_LOC_ID = dat.MON_LOC_ID
                   and  ( chl.OP_BEGIN_DATE < dat.BEGIN_DATE or ( chl.OP_BEGIN_DATE = dat.BEGIN_DATE and chl.OP_BEGIN_HOUR <= dat.BEGIN_HOUR ) )
                   and  ( chl.OP_END_DATE > dat.BEGIN_DATE or ( chl.OP_END_DATE = dat.BEGIN_DATE and chl.OP_END_HOUR >= dat.BEGIN_HOUR ) )
            ) as error_codes
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
                        -- HI
                        max( case when dhv.PARAMETER_CD = 'HI'   then frm.EQUATION_CD end ) as HI_FORMULA_CD,
                        max( case when dhv.PARAMETER_CD = 'HI'   then dhv.ADJUSTED_HRLY_VALUE end ) as HI_RPT_VALUE,
                        max( case when dhv.PARAMETER_CD = 'HI'   then dhv.CALC_ADJUSTED_HRLY_VALUE end ) as HI_CALC_VALUE,
                        -- SO2 MASS
                        max( case when dhv.PARAMETER_CD = 'SO2'  then frm.EQUATION_CD end ) as SO2_FORMULA_CD,
                        max( case when dhv.PARAMETER_CD = 'SO2'  then dhv.ADJUSTED_HRLY_VALUE end ) as SO2_RPT_VALUE,
                        max( case when dhv.PARAMETER_CD = 'SO2'  then dhv.CALC_ADJUSTED_HRLY_VALUE end ) as SO2_CALC_VALUE,
                        -- NOX RATE
                        max( case when dhv.PARAMETER_CD = 'NOXR' then frm.EQUATION_CD end ) as NOXR_FORMULA_CD,
                        max( case when dhv.PARAMETER_CD = 'NOXR' then dhv.ADJUSTED_HRLY_VALUE end ) as NOXR_RPT_VALUE,
                        max( case when dhv.PARAMETER_CD = 'NOXR' then dhv.CALC_ADJUSTED_HRLY_VALUE end ) as NOXR_CALC_VALUE,
                        -- NOX MASS
                        max( case when dhv.PARAMETER_CD = 'NOX' then frm.EQUATION_CD end ) as NOX_FORMULA_CD,
                        max( case when dhv.PARAMETER_CD = 'NOX' then dhv.ADJUSTED_HRLY_VALUE end ) as NOX_RPT_VALUE,
                        max( case when dhv.PARAMETER_CD = 'NOX' then dhv.CALC_ADJUSTED_HRLY_VALUE end ) as NOX_CALC_VALUE,
                        -- CO2 MASS
                        max( case when dhv.PARAMETER_CD = 'CO2' then frm.EQUATION_CD end ) as CO2_FORMULA_CD,
                        max( case when dhv.PARAMETER_CD = 'CO2' then dhv.ADJUSTED_HRLY_VALUE end ) as CO2_RPT_VALUE,
                        max( case when dhv.PARAMETER_CD = 'CO2' then dhv.CALC_ADJUSTED_HRLY_VALUE end ) as CO2_CALC_VALUE,
                        -- FLOW
                        flow.CALC_ADJUSTED_HRLY_VALUE AS FLOW_CALC_ADJ_VALUE,
                        flow.ADJUSTED_HRLY_VALUE AS FLOW_RPT_ADJ_VALUE, 
                        flow.UNADJUSTED_HRLY_VALUE AS FLOW_RPT_UNADJ_VALUE
                  from  (
                            select  vmonplanid as MON_PLAN_ID,
                                    vrptperiodid as RPT_PERIOD_ID
                        ) sel
                        join camdecmpswks.MONITOR_PLAN_LOCATION mpl
                          on mpl.MON_PLAN_ID = sel.MON_PLAN_ID
                        join camdecmpswks.EMISSION_EVALUATION ems
                          on ems.RPT_PERIOD_ID = sel.RPT_PERIOD_ID
                         and ems.MON_PLAN_ID = mpl.MON_PLAN_ID
                        join camdecmpswks.HRLY_OP_DATA hod 
                          on hod.rpt_period_id = ems.rpt_period_id
                         and hod.mon_loc_id = mpl.mon_loc_id
                        left join camdecmpswks.MONITOR_HRLY_VALUE flow
                          on flow.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
                         and flow.MON_LOC_ID = hod.MON_LOC_ID
                         and flow.HOUR_ID = hod.HOUR_ID
                         and flow.PARAMETER_CD = 'FLOW'
                        left join camdecmpswks.DERIVED_HRLY_VALUE dhv
                          on dhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
                         and dhv.MON_LOC_ID = hod.MON_LOC_ID
                         and dhv.HOUR_ID = hod.HOUR_ID
                         and dhv.PARAMETER_CD in ( 'CO2', 'HI', 'NOX', 'NOXR', 'SO2' )
                        left join camdecmpswks.MONITOR_FORMULA frm
                          on frm.MON_FORM_ID = dhv.MON_FORM_ID
                 where  (
                            flow.HOUR_ID is not null or
                            dhv.HOUR_ID is not null
                        )
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
                        flow.CALC_ADJUSTED_HRLY_VALUE,
                        flow.ADJUSTED_HRLY_VALUE, 
                        flow.UNADJUSTED_HRLY_VALUE,
                        ems.CHK_SESSION_ID
        ) dat;

  RAISE NOTICE 'Refreshing view counts...';
  CALL camdecmpswks.refresh_emission_view_count(vmonplanid, vrptperiodid, 'ALL');
END
$procedure$
