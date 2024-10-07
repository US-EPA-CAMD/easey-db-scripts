CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_co2appd
(
    IN vmonplanid character varying,
    IN vrptperiodid NUMERIC
)
 LANGUAGE plpgsql
AS $procedure$
DECLAREBEGIN
    RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmps.EMISSION_VIEW_CO2APPD	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;
    RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmps.EMISSION_VIEW_CO2APPD(		MON_PLAN_ID,		MON_LOC_ID,		RPT_PERIOD_ID,		DATE_HOUR,		OP_TIME,		FUEL_SYS_ID,		FUEL_TYPE,		FUEL_USE_TIME,		UNIT_LOAD,		LOAD_UOM,		CALC_HI_RATE,		FC_FACTOR,		FORMULA_CD,		RPT_CO2_MASS_RATE,		CALC_CO2_MASS_RATE,		SUMMATION_FORMULA_CD,		RPT_CO2_MASS_RATE_ALL_FUELS,		CALC_CO2_MASS_RATE_ALL_FUELS,		ERROR_CODES	)    select  dat.MON_PLAN_ID, 
            dat.MON_LOC_ID, 
            dat.RPT_PERIOD_ID, 
            camdecmps.format_date_hour( dat.BEGIN_DATE, dat.BEGIN_HOUR, null ) AS DATE_HOUR,
            dat.OP_TIME, 
            COALESCE( dat.SYSTEM_IDENTIFIER, '' ) AS FUEL_SYS_ID,
            dat.FUEL_CD AS FUEL_TYPE,
            dat.FUEL_USAGE_TIME AS FUEL_USE_TIME,
            dat.HR_LOAD AS UNIT_LOAD, 
            dat.LOAD_UOM_CD AS LOAD_UOM,
            dat.HI_CALC_PARAM_VAL_FUEL AS CALC_HI_RATE,
            dat.FC_PARAM_VAL_FUEL AS FC_FACTOR,
            dat.CO2_HPFF_FORMULA_CD AS FORMULA_CD,
            dat.CO2_HPFF_PARAM_VAL_FUEL AS RPT_CO2_MASS_RATE,
            dat.CO2_HPFF_CALC_PARAM_VAL_FUEL AS CALC_CO2_MASS_RATE,
            dat.CO2_DHV_FORMULA_CD AS SUMMATION_FORMULA_CD,
            dat.CO2_DHV_ADJUSTED_HRLY_VALUE AS RPT_CO2_MASS_RATE_ALL_FUELS,
            dat.CO2_DHV_CALC_ADJUSTED_HRLY_VALUE AS CALC_CO2_MASS_RATE_ALL_FUELS,
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
                        -- HFF
                        hff.FUEL_CD,
                        hff.FUEL_USAGE_TIME,
                        sys.SYSTEM_IDENTIFIER,
                        -- CO2 DHV
                        co2.HOUR_ID as CO2_DHV_HOUR_ID,
                        co2.ADJUSTED_HRLY_VALUE as CO2_DHV_ADJUSTED_HRLY_VALUE,
                        co2.CALC_ADJUSTED_HRLY_VALUE as CO2_DHV_CALC_ADJUSTED_HRLY_VALUE,
                        co2_frm.EQUATION_CD as CO2_DHV_FORMULA_CD,
                        -- CO2 HPFF
                        max( case when hpff.PARAMETER_CD = 'CO2' then hpff.HRLY_FUEL_FLOW_ID end ) as CO2_HPFF_HRLY_FUEL_FLOW_ID,
                        max( case when hpff.PARAMETER_CD = 'CO2' then hpff.PARAM_VAL_FUEL end ) as CO2_HPFF_PARAM_VAL_FUEL,
                        max( case when hpff.PARAMETER_CD = 'CO2' then hpff.CALC_PARAM_VAL_FUEL end ) as CO2_HPFF_CALC_PARAM_VAL_FUEL,
                        max( case when hpff.PARAMETER_CD = 'CO2' then hpff_frm.EQUATION_CD end ) as CO2_HPFF_FORMULA_CD,
                        -- FC HPFF
                        max( case when hpff.PARAMETER_CD = 'FC'  then hpff.PARAM_VAL_FUEL end ) as FC_PARAM_VAL_FUEL,
                        -- HI HPFF
                        max( case when hpff.PARAMETER_CD = 'HI'  then hpff.CALC_PARAM_VAL_FUEL end ) as HI_CALC_PARAM_VAL_FUEL
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
                        left join camdecmps.MONITOR_SYSTEM sys
                          on sys.MON_SYS_ID = hff.MON_SYS_ID
                        left join camdecmps.DERIVED_HRLY_VALUE co2
                          on co2.RPT_PERIOD_ID = hff.RPT_PERIOD_ID
                         and co2.MON_LOC_ID = hff.MON_LOC_ID
                         and co2.HOUR_ID = hff.HOUR_ID
                         and co2.PARAMETER_CD = 'CO2'
                        left join camdecmps.MONITOR_FORMULA co2_frm
                          on co2_frm.MON_FORM_ID = co2.MON_FORM_ID
                        left join camdecmps.HRLY_PARAM_FUEL_FLOW hpff
                          on hpff.RPT_PERIOD_ID = hff.RPT_PERIOD_ID
                         and hpff.MON_LOC_ID = hff.MON_LOC_ID
                         and hpff.HRLY_FUEL_FLOW_ID = hff.HRLY_FUEL_FLOW_ID
                         and hpff.PARAMETER_CD in ( 'CO2', 'FC', 'HI' )
                        left join camdecmps.MONITOR_FORMULA hpff_frm
                          on hpff_frm.MON_FORM_ID = hpff.MON_FORM_ID
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
                        co2.HOUR_ID,
                        hff.FUEL_CD,
                        hff.FUEL_USAGE_TIME,
                        sys.SYSTEM_IDENTIFIER,
                        co2.ADJUSTED_HRLY_VALUE,
                        co2.CALC_ADJUSTED_HRLY_VALUE,
                        co2_frm.EQUATION_CD,
                        ems.CHK_SESSION_ID
            ) dat
     where  (
                dat.CO2_HPFF_HRLY_FUEL_FLOW_ID is not null
                or
                ( ( dat.CO2_HPFF_HRLY_FUEL_FLOW_ID is null ) and ( dat.HI_CALC_PARAM_VAL_FUEL is not null or dat.CO2_DHV_HOUR_ID is not null ) )
            );

    RAISE NOTICE 'Refreshing view counts...';
    CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'CO2APPD');
END
$procedure$
