CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_moisture
(
    IN vmonplanid character varying,
    IN vrptperiodid NUMERIC
)
 LANGUAGE plpgsql
AS $procedure$
DECLARE
BEGIN
    RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmpswks.EMISSION_VIEW_MOISTURE

    RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmpswks.EMISSION_VIEW_MOISTURE(
            dat.MON_LOC_ID, 
            dat.RPT_PERIOD_ID,
            camdecmpswks.format_date_hour( dat.BEGIN_DATE, dat.BEGIN_HOUR, null ) as DATE_HOUR,
            dat.OP_TIME,
            dat.H2O_MODC_CD AS H2O_MODC,
            dat.H2O_PCT_AVAILABLE AS H2O_PMA,
            dat.O2W_UNADJUSTED_HRLY_VALUE AS PCT_O2_WET,
            dat.O2W_MODC_CD AS O2_WET_MODC,
            dat.O2D_UNADJUSTED_HRLY_VALUE AS PCT_O2_DRY,
            dat.O2D_MODC_CD AS O2_DRY_MODC,
            dat.H2O_FORMULA_CD AS H2O_FORMULA_CODE,
            dat.H2O_ADJUSTED_HRLY_VALUE AS RPT_PCT_H2O,
            dat.H2O_CALC_ADJUSTED_HRLY_VALUE AS CALC_PCT_H2O,
            (
                select  case when max( coalesce( sev.SEVERITY_LEVEL, 0 ) ) > 0 then 'Y' else NULL end
                  from  camdecmpswks.CHECK_LOG chl
                        left join camdecmpsmd.SEVERITY_CODE sev
                          on sev.SEVERITY_CD = chl.SEVERITY_CD
                 where  chl.CHK_SESSION_ID = dat.CHK_SESSION_ID
                   and  chl.MON_LOC_ID = dat.MON_LOC_ID
                   and  ( chl.OP_BEGIN_DATE < dat.BEGIN_DATE or ( chl.OP_BEGIN_DATE = dat.BEGIN_DATE and chl.OP_BEGIN_HOUR <= dat.BEGIN_HOUR ) )
                   and  ( chl.OP_END_DATE > dat.BEGIN_DATE or ( chl.OP_END_DATE = dat.BEGIN_DATE and chl.OP_END_HOUR >= dat.BEGIN_HOUR ) )
            ) as ERROR_CODES
      from  (
                select  mpl.MON_PLAN_ID, 
                        hod.MON_LOC_ID, 
                        hod.RPT_PERIOD_ID,
                        hod.BEGIN_DATE,
                        hod.BEGIN_HOUR,
                        hod.OP_TIME,
                        -- H2O
                        dhv.ADJUSTED_HRLY_VALUE as H2O_ADJUSTED_HRLY_VALUE,
                        dhv.CALC_ADJUSTED_HRLY_VALUE as H2O_CALC_ADJUSTED_HRLY_VALUE,
                        dhv.MODC_CD as H2O_MODC_CD,
                        dhv.PCT_AVAILABLE as H2O_PCT_AVAILABLE,
                        frm.EQUATION_CD as H2O_FORMULA_CD,
                        -- O2D (All)
                        max( case when mhv.PARAMETER_CD = 'O2C'  and mhv.MOISTURE_BASIS = 'D' then mhv.UNADJUSTED_HRLY_VALUE end ) as O2D_UNADJUSTED_HRLY_VALUE,
                        max( case when mhv.PARAMETER_CD = 'O2C'  and mhv.MOISTURE_BASIS = 'D' then mhv.MODC_CD end ) as O2D_MODC_CD,
                        -- O2W (All)
                        max( case when mhv.PARAMETER_CD = 'O2C'  and mhv.MOISTURE_BASIS = 'W' then mhv.UNADJUSTED_HRLY_VALUE end ) as O2W_UNADJUSTED_HRLY_VALUE,
                        max( case when mhv.PARAMETER_CD = 'O2C'  and mhv.MOISTURE_BASIS = 'W' then mhv.MODC_CD end ) as O2W_MODC_CD,
                        -- Error Information
                        ems.CHK_SESSION_ID
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
                        join camdecmpswks.DERIVED_HRLY_VALUE dhv
                          on dhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
                         and dhv.MON_LOC_ID = hod.MON_LOC_ID
                         and dhv.HOUR_ID = hod.HOUR_ID
                         and dhv.PARAMETER_CD = 'H2O'
                         and dhv.MODC_CD != '40'
                        left join camdecmpswks.MONITOR_FORMULA frm
                          on frm.MON_FORM_ID = dhv.MON_FORM_ID
                        left join camdecmpswks.MONITOR_HRLY_VALUE mhv
                          on mhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
                         and mhv.MON_LOC_ID = hod.MON_LOC_ID
                         and mhv.HOUR_ID = hod.HOUR_ID
                         and mhv.PARAMETER_CD = 'O2C'
                 group
                    by  mpl.MON_PLAN_ID, 
                        hod.MON_LOC_ID, 
                        hod.RPT_PERIOD_ID,
                        hod.BEGIN_DATE,
                        hod.BEGIN_HOUR,
                        hod.OP_TIME,
                        dhv.ADJUSTED_HRLY_VALUE,
                        dhv.CALC_ADJUSTED_HRLY_VALUE,
                        dhv.MODC_CD,
                        dhv.PCT_AVAILABLE,
                        frm.EQUATION_CD,
                        ems.CHK_SESSION_ID
        ) dat;

    RAISE NOTICE 'Refreshing view counts...';
    CALL camdecmpswks.refresh_emission_view_count(vmonplanid, vrptperiodid, 'MOISTURE');
END
$procedure$