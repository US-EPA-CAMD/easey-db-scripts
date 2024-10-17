CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_co2calc
(
    IN vmonplanid character varying,
    IN vrptperiodid numeric
)
 LANGUAGE plpgsql
AS $procedure$
DECLARE
BEGIN
    RAISE NOTICE 'Loading temp_hourly_test_errors...';
	CALL camdecmps.load_temp_hourly_test_errors(vMonPlanId, vRptPeriodId);
    RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmps.EMISSION_VIEW_CO2CALC	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;
    RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmps.EMISSION_VIEW_CO2CALC(		MON_PLAN_ID,		MON_LOC_ID,		RPT_PERIOD_ID,		DATE_HOUR,		OP_TIME,		CO2C_MODC,		CO2C_PMA,		RPT_PCT_O2,		PCT_O2_USED,		O2_MODC,		PCT_H2O_USED,		SOURCE_H2O_VALUE,		FC_FACTOR,		FD_FACTOR,		FORMULA_CD,		RPT_PCT_CO2,		CALC_PCT_CO2,		ERROR_CODES	)
    select  dat.MON_PLAN_ID, 
            dat.MON_LOC_ID, 
            dat.RPT_PERIOD_ID,
            camdecmps.format_date_hour( dat.BEGIN_DATE, dat.BEGIN_HOUR, null ) as DATE_HOUR,
            dat.OP_TIME,
            dat.CO2C_MODC_CD as CO2C_MODC,
            dat.CO2C_PCT_AVAILABLE as CO2C_PMA,
            case ( dat.CO2C_FORMULA_CD )
                when 'F-14A' then dat.O2D_UNADJUSTED_HRLY_VALUE
                when 'F-14B' then dat.O2W_UNADJUSTED_HRLY_VALUE
            end as RPT_PCT_O2,
            dat.CO2C_CALC_PCT_DILUENT as PCT_O2_USED,
            case ( dat.CO2C_FORMULA_CD )
                when 'F-14A' then dat.O2D_MODC_CD
                when 'F-14B' then dat.O2W_MODC_CD
            end as O2_MODC,
            dat.CO2C_CALC_PCT_MOISTURE as PCT_H2O_USED, 
            case 
                when ( dat.CO2C_CALC_PCT_MOISTURE is not null ) then 
                    case 
                        when ( dat.H2O_DHV_HOUR_ID is not null ) then dat.H2O_DHV_MODC_CD 
                        when ( dat.H2O_MHV_HOUR_ID is not null ) then dat.H2O_MHV_MODC_CD 
                        else 'DF'
                    end 
                else null
            end as SOURCE_H2O_VALUE, 
            dat.FC_FACTOR as FC_FACTOR,
            dat.FD_FACTOR as FD_FACTOR,
            dat.CO2C_FORMULA_CD as FORMULA_CODE,
            dat.CO2C_ADJUSTED_HRLY_VALUE as RPT_PCT_CO2,
            dat.CO2C_CALC_ADJUSTED_HRLY_VALUE as CALC_PCT_CO2,
            (
                select  case when max( coalesce( sev.SEVERITY_LEVEL, 0 ) ) > 0 then 'Y' else NULL end
                  from  camdecmpsaux.CHECK_LOG chl
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
                        hod.FC_FACTOR,
                        hod.FD_FACTOR,
                        ems.CHK_SESSION_ID,
                        -- CO2C
                        max( case when dhv.PARAMETER_CD = 'CO2C' then dhv.HOUR_ID end ) as CO2C_HOUR_ID,
                        max( case when dhv.PARAMETER_CD = 'CO2C' then dhv.ADJUSTED_HRLY_VALUE end ) as CO2C_ADJUSTED_HRLY_VALUE,
                        max( case when dhv.PARAMETER_CD = 'CO2C' then dhv.MODC_CD end ) as CO2C_MODC_CD,
                        max( case when dhv.PARAMETER_CD = 'CO2C' then dhv.PCT_AVAILABLE end ) as CO2C_PCT_AVAILABLE,
                        max( case when dhv.PARAMETER_CD = 'CO2C' then dhv.CALC_ADJUSTED_HRLY_VALUE end ) as CO2C_CALC_ADJUSTED_HRLY_VALUE,
                        max( case when dhv.PARAMETER_CD = 'CO2C' then dhv.CALC_PCT_DILUENT end ) as CO2C_CALC_PCT_DILUENT,
                        max( case when dhv.PARAMETER_CD = 'CO2C' then dhv.CALC_PCT_MOISTURE end ) as CO2C_CALC_PCT_MOISTURE,
                        max( case when dhv.PARAMETER_CD = 'CO2C' then frm.EQUATION_CD end ) as CO2C_FORMULA_CD,
                        -- H2O DHV
                        max( case when dhv.PARAMETER_CD = 'H2O'  then dhv.HOUR_ID end ) as H2O_DHV_HOUR_ID,
                        max( case when dhv.PARAMETER_CD = 'H2O'  then dhv.MODC_CD end ) as H2O_DHV_MODC_CD,
                        -- H2O MHV
                        max( case when mhv.PARAMETER_CD = 'H2O'  then mhv.HOUR_ID end ) as H2O_MHV_HOUR_ID,
                        max( case when mhv.PARAMETER_CD = 'H2O'  then mhv.MODC_CD end ) as H2O_MHV_MODC_CD,
                        -- O2D
                        max( case when mhv.PARAMETER_CD = 'O2C'  and mhv.MOISTURE_BASIS = 'D' then mhv.UNADJUSTED_HRLY_VALUE end ) as O2D_UNADJUSTED_HRLY_VALUE,
                        max( case when mhv.PARAMETER_CD = 'O2C'  and mhv.MOISTURE_BASIS = 'D' then mhv.MODC_CD end ) as O2D_MODC_CD,
                        -- O2W
                        max( case when mhv.PARAMETER_CD = 'O2C'  and mhv.MOISTURE_BASIS = 'W' then mhv.UNADJUSTED_HRLY_VALUE end ) as O2W_UNADJUSTED_HRLY_VALUE,
                        max( case when mhv.PARAMETER_CD = 'O2C'  and mhv.MOISTURE_BASIS = 'W' then mhv.MODC_CD end ) as O2W_MODC_CD
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
                         and dhv.PARAMETER_CD in ( 'CO2C', 'H2O' )
                        left join camdecmps.MONITOR_HRLY_VALUE mhv
                          on mhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
                         and mhv.MON_LOC_ID = hod.MON_LOC_ID
                         and mhv.HOUR_ID = hod.HOUR_ID
                         and mhv.PARAMETER_CD in ( 'H2O', 'O2C' )
                        left join camdecmps.MONITOR_FORMULA frm
                          on frm.MON_FORM_ID = dhv.MON_FORM_ID
                 group
                    by  mpl.MON_PLAN_ID, 
                        hod.MON_LOC_ID, 
                        hod.RPT_PERIOD_ID,
                        hod.BEGIN_DATE,
                        hod.BEGIN_HOUR,
                        hod.OP_TIME,
                        hod.FC_FACTOR,
                        hod.FD_FACTOR,
                        ems.CHK_SESSION_ID
        ) dat
     where  dat.CO2C_HOUR_ID is not null;


    RAISE NOTICE 'Refreshing view counts...';
    CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'CO2CALC');
END
$procedure$
