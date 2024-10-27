CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_hicems
(
    IN vmonplanid character varying, 
    IN vrptperiodid numeric
)
 LANGUAGE plpgsql
AS $procedure$
DECLARE  
BEGIN
    RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmpswks.EMISSION_VIEW_HICEMS	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;

    RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmpswks.EMISSION_VIEW_HICEMS(		MON_PLAN_ID,		MON_LOC_ID,		RPT_PERIOD_ID,		HOUR_ID,		DATE_HOUR,		OP_TIME,		UNIT_LOAD,		LOAD_UOM,		LOAD_RANGE,		COMMON_STACK_LOAD_RANGE,
        FUEL_CD,		HI_FORMULA_CD,		HI_MODC,		RPT_HI_RATE,		CALC_HI_RATE,		DILUENT_PARAM,		RPT_PCT_DILUENT,		PCT_DILUENT_USED,		DILUENT_MODC,		DILUENT_PMA,		UNADJ_FLOW,		CALC_FLOW_BAF,		RPT_ADJ_FLOW,		ADJ_FLOW_USED,		FLOW_MODC,		FLOW_PMA,		PCT_H2O_USED,		SOURCE_H2O_VALUE,		F_FACTOR,		ERROR_CODES	)
    select  dat.MON_PLAN_ID, 
            dat.MON_LOC_ID, 
            dat.RPT_PERIOD_ID,
            dat.HOUR_ID,
            camdecmpswks.format_date_hour( dat.BEGIN_DATE, dat.BEGIN_HOUR, null ) as DATE_HOUR,
            dat.OP_TIME,
            dat.HR_LOAD as UNIT_LOAD,
            dat.LOAD_UOM_CD as LOAD_UOM,
            dat.LOAD_RANGE, 
            dat.COMMON_STACK_LOAD_RANGE,
            dat.FUEL_CD, 
            dat.HI_FORMULA_CD,
            dat.HI_MODC_CD as HI_MODC,
            dat.HI_ADJUSTED_HRLY_VALUE as RPT_HI_RATE, 
            dat.HI_CALC_ADJUSTED_HRLY_VALUE as CALC_HI_RATE, 
            case dat.HI_FORMULA_CD 
                when 'F-15' then 'CO2' 
                when 'F-16' then 'CO2' 
                when 'F-17' then 'O2' 
                when 'F-18' then 'O2' 
                else null 
            end as DILUENT_PARAM, 
            case dat.HI_FORMULA_CD
                when 'F-15' then case when dat.CO2C_SD_HOUR_ID is not null then dat.CO2C_SD_UNADJUSTED_HRLY_VALUE else dat.CO2C_UNADJUSTED_HRLY_VALUE end
                when 'F-16' then case when dat.CO2C_SD_HOUR_ID is not null then dat.CO2C_SD_UNADJUSTED_HRLY_VALUE else dat.CO2C_UNADJUSTED_HRLY_VALUE end
                when 'F-17' then case when dat.O2W_SD_HOUR_ID  is not null then dat.O2W_SD_UNADJUSTED_HRLY_VALUE  else dat.O2W_UNADJUSTED_HRLY_VALUE  end
                when 'F-18' then case when dat.O2D_SD_HOUR_ID  is not null then dat.O2D_SD_UNADJUSTED_HRLY_VALUE  else dat.O2D_UNADJUSTED_HRLY_VALUE  end
                else null 
            end as RPT_PCT_DILUENT, 
            dat.hi_CALC_PCT_DILUENT AS PCT_DILUENT_USED,
            case dat.HI_FORMULA_CD
                when 'F-15' then case when dat.CO2C_SD_HOUR_ID is not null then dat.CO2C_SD_MODC_CD else dat.CO2C_MODC_CD end
                when 'F-16' then case when dat.CO2C_SD_HOUR_ID is not null then dat.CO2C_SD_MODC_CD else dat.CO2C_MODC_CD end
                when 'F-17' then case when dat.O2W_SD_HOUR_ID  is not null then dat.O2W_SD_MODC_CD  else dat.O2W_MODC_CD  end
                when 'F-18' then case when dat.O2D_SD_HOUR_ID  is not null then dat.O2D_SD_MODC_CD  else dat.O2D_MODC_CD  end
                else null 
            end as DILUENT_MODC,
            case dat.HI_FORMULA_CD
                when 'F-15' then case when dat.CO2C_SD_HOUR_ID is not null then dat.CO2C_SD_PCT_AVAILABLE else dat.CO2C_PCT_AVAILABLE end
                when 'F-16' then case when dat.CO2C_SD_HOUR_ID is not null then dat.CO2C_SD_PCT_AVAILABLE else dat.CO2C_PCT_AVAILABLE end
                when 'F-17' then case when dat.O2W_SD_HOUR_ID  is not null then dat.O2W_SD_PCT_AVAILABLE  else dat.O2W_PCT_AVAILABLE  end
                when 'F-18' then case when dat.O2D_SD_HOUR_ID  is not null then dat.O2D_SD_PCT_AVAILABLE  else dat.O2D_PCT_AVAILABLE  end
                else null 
            end as DILUENT_PMA,
            dat.FLOW_UNADJUSTED_HRLY_VALUE as UNADJ_FLOW, 
            dat.FLOW_APPLICABLE_BIAS_ADJ_FACTOR as CALC_FLOW_BAF, 
            dat.FLOW_ADJUSTED_HRLY_VALUE as RPT_ADJ_FLOW, 
            dat.FLOW_CALC_ADJUSTED_HRLY_VALUE as ADJ_FLOW_USED, 
            dat.FLOW_MODC_CD as FLOW_MODC, 
            dat.FLOW_PCT_AVAILABLE as FLOW_PMA,
            dat.HI_CALC_PCT_MOISTURE as PCT_H2O_USED, 
            case 
                when ( dat.hi_CALC_PCT_MOISTURE is not null ) then 
                    case 
                        when ( dat.H2O_DHV_MODC_CD is not null ) then dat.H2O_DHV_MODC_CD 
                        when ( dat.H2O_MHV_MODC_CD is not null ) then dat.H2O_MHV_MODC_CD 
                        else 'DF'
                    end 
                else null
            end as SOURCE_H2O_VALUE, 
            case dat.HI_FORMULA_CD 
                when 'F-15' then dat.FC_FACTOR 
                when 'F-16' then dat.FC_FACTOR 
                when 'F-17' then dat.FD_FACTOR 
                when 'F-18' then dat.FD_FACTOR 
            end AS F_FACTOR, 
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
                select  hod.HOUR_ID,
                        mpl.MON_PLAN_ID, 
                        hod.MON_LOC_ID, 
                        hod.RPT_PERIOD_ID,
                        hod.BEGIN_DATE,
                        hod.BEGIN_HOUR,
                        hod.OP_TIME,
                        hod.HR_LOAD,
                        hod.LOAD_UOM_CD,
                        hod.LOAD_RANGE, 
                        hod.COMMON_STACK_LOAD_RANGE,
                        hod.FC_FACTOR,
                        hod.FD_FACTOR,
                        hod.FW_FACTOR,
                        hod.FUEL_CD,
                        ems.CHK_SESSION_ID,
                        -- HI
                        max( case when dhv.PARAMETER_CD = 'HI'   then dhv.HOUR_ID end ) as HI_HOUR_ID,
                        max( case when dhv.PARAMETER_CD = 'HI'   then dhv.MODC_CD end ) as HI_MODC_CD,
                        max( case when dhv.PARAMETER_CD = 'HI'   then dhv.ADJUSTED_HRLY_VALUE end ) as HI_ADJUSTED_HRLY_VALUE,
                        max( case when dhv.PARAMETER_CD = 'HI'   then dhv.CALC_ADJUSTED_HRLY_VALUE end ) as HI_CALC_ADJUSTED_HRLY_VALUE,
                        max( case when dhv.PARAMETER_CD = 'HI'   then dhv.CALC_PCT_DILUENT end ) as HI_CALC_PCT_DILUENT,
                        max( case when dhv.PARAMETER_CD = 'HI'   then dhv.CALC_PCT_MOISTURE end ) as HI_CALC_PCT_MOISTURE,
                        max( case when dhv.PARAMETER_CD = 'HI'   then frm.EQUATION_CD end ) as HI_FORMULA_CD,
                        -- H2O DHV
                        max( case when dhv.PARAMETER_CD = 'H2O'  then dhv.MODC_CD end ) as H2O_DHV_MODC_CD,
                        -- FLOW
                        max( case when mhv.PARAMETER_CD = 'FLOW' then mhv.HOUR_ID end ) as FLOW_HOUR_ID,
                        max( case when mhv.PARAMETER_CD = 'FLOW' then mhv.ADJUSTED_HRLY_VALUE end ) as FLOW_ADJUSTED_HRLY_VALUE,
                        max( case when mhv.PARAMETER_CD = 'FLOW' then mhv.UNADJUSTED_HRLY_VALUE end ) as FLOW_UNADJUSTED_HRLY_VALUE,
                        max( case when mhv.PARAMETER_CD = 'FLOW' then mhv.MODC_CD end ) as FLOW_MODC_CD,
                        max( case when mhv.PARAMETER_CD = 'FLOW' then mhv.PCT_AVAILABLE end ) as FLOW_PCT_AVAILABLE,
                        max( case when mhv.PARAMETER_CD = 'FLOW' then mhv.APPLICABLE_BIAS_ADJ_FACTOR end ) as FLOW_APPLICABLE_BIAS_ADJ_FACTOR,
                        max( case when mhv.PARAMETER_CD = 'FLOW' then mhv.CALC_ADJUSTED_HRLY_VALUE end ) as FLOW_CALC_ADJUSTED_HRLY_VALUE,
                        -- CO2C (All)
                        max( case when mhv.PARAMETER_CD = 'CO2C' then mhv.HOUR_ID end ) as CO2C_HOUR_ID,
                        max( case when mhv.PARAMETER_CD = 'CO2C' then mhv.UNADJUSTED_HRLY_VALUE end ) as CO2C_UNADJUSTED_HRLY_VALUE,
                        max( case when mhv.PARAMETER_CD = 'CO2C' then mhv.MODC_CD end ) as CO2C_MODC_CD,
                        max( case when mhv.PARAMETER_CD = 'CO2C' then mhv.PCT_AVAILABLE end ) as CO2C_PCT_AVAILABLE,
                        -- CO2C (Substitute Data)
                        max( case when mhv.PARAMETER_CD = 'CO2C' and mhv.MODC_CD IN ('06', '07', '08', '09', '10', '11', '12', '55') then mhv.HOUR_ID end ) as CO2C_SD_HOUR_ID,
                        max( case when mhv.PARAMETER_CD = 'CO2C' and mhv.MODC_CD IN ('06', '07', '08', '09', '10', '11', '12', '55') then mhv.UNADJUSTED_HRLY_VALUE end ) as CO2C_SD_UNADJUSTED_HRLY_VALUE,
                        max( case when mhv.PARAMETER_CD = 'CO2C' and mhv.MODC_CD IN ('06', '07', '08', '09', '10', '11', '12', '55') then mhv.MODC_CD end ) as CO2C_SD_MODC_CD,
                        max( case when mhv.PARAMETER_CD = 'CO2C' and mhv.MODC_CD IN ('06', '07', '08', '09', '10', '11', '12', '55') then mhv.PCT_AVAILABLE end ) as CO2C_SD_PCT_AVAILABLE,
                        -- H2O MHV
                        max( case when mhv.PARAMETER_CD = 'H2O'  then mhv.MODC_CD end ) as H2O_MHV_MODC_CD,
                        -- O2D (All)
                        max( case when mhv.PARAMETER_CD = 'O2C'  and mhv.MOISTURE_BASIS = 'D' then mhv.UNADJUSTED_HRLY_VALUE end ) as O2D_UNADJUSTED_HRLY_VALUE,
                        max( case when mhv.PARAMETER_CD = 'O2C'  and mhv.MOISTURE_BASIS = 'D' then mhv.MODC_CD end ) as O2D_MODC_CD,
                        max( case when mhv.PARAMETER_CD = 'O2C'  and mhv.MOISTURE_BASIS = 'D' then mhv.PCT_AVAILABLE end ) as O2D_PCT_AVAILABLE,
                        -- O2D (Substitute Data)
                        max( case when mhv.PARAMETER_CD = 'O2C'  and mhv.MOISTURE_BASIS = 'D' and mhv.MODC_CD IN ('06', '07', '08', '09', '10', '11', '12', '55') then mhv.HOUR_ID end ) as O2D_SD_HOUR_ID,
                        max( case when mhv.PARAMETER_CD = 'O2C'  and mhv.MOISTURE_BASIS = 'D' and mhv.MODC_CD IN ('06', '07', '08', '09', '10', '11', '12', '55') then mhv.UNADJUSTED_HRLY_VALUE end ) as O2D_SD_UNADJUSTED_HRLY_VALUE,
                        max( case when mhv.PARAMETER_CD = 'O2C'  and mhv.MOISTURE_BASIS = 'D' and mhv.MODC_CD IN ('06', '07', '08', '09', '10', '11', '12', '55') then mhv.MODC_CD end ) as O2D_SD_MODC_CD,
                        max( case when mhv.PARAMETER_CD = 'O2C'  and mhv.MOISTURE_BASIS = 'D' and mhv.MODC_CD IN ('06', '07', '08', '09', '10', '11', '12', '55') then mhv.PCT_AVAILABLE end ) as O2D_SD_PCT_AVAILABLE,
                        -- O2W (All)
                        max( case when mhv.PARAMETER_CD = 'O2C'  and mhv.MOISTURE_BASIS = 'W' then mhv.UNADJUSTED_HRLY_VALUE end ) as O2W_UNADJUSTED_HRLY_VALUE,
                        max( case when mhv.PARAMETER_CD = 'O2C'  and mhv.MOISTURE_BASIS = 'W' then mhv.MODC_CD end ) as O2W_MODC_CD,
                        max( case when mhv.PARAMETER_CD = 'O2C'  and mhv.MOISTURE_BASIS = 'W' then mhv.PCT_AVAILABLE end ) as O2W_PCT_AVAILABLE,
                        -- O2W (Substitute Data)
                        max( case when mhv.PARAMETER_CD = 'O2C'  and mhv.MOISTURE_BASIS = 'W' and mhv.MODC_CD IN ('06', '07', '08', '09', '10', '11', '12', '55') then mhv.HOUR_ID end ) as O2W_SD_HOUR_ID,
                        max( case when mhv.PARAMETER_CD = 'O2C'  and mhv.MOISTURE_BASIS = 'W' and mhv.MODC_CD IN ('06', '07', '08', '09', '10', '11', '12', '55') then mhv.UNADJUSTED_HRLY_VALUE end ) as O2W_SD_UNADJUSTED_HRLY_VALUE,
                        max( case when mhv.PARAMETER_CD = 'O2C'  and mhv.MOISTURE_BASIS = 'W' and mhv.MODC_CD IN ('06', '07', '08', '09', '10', '11', '12', '55') then mhv.MODC_CD end ) as O2W_SD_MODC_CD,
                        max( case when mhv.PARAMETER_CD = 'O2C'  and mhv.MOISTURE_BASIS = 'W' and mhv.MODC_CD IN ('06', '07', '08', '09', '10', '11', '12', '55') then mhv.PCT_AVAILABLE end ) as O2W_SD_PCT_AVAILABLE
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
                         and dhv.PARAMETER_CD in ( 'H2O', 'HI' )
                        join camdecmpswks.MONITOR_HRLY_VALUE mhv
                          on mhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
                         and mhv.MON_LOC_ID = hod.MON_LOC_ID
                         and mhv.HOUR_ID = hod.HOUR_ID
                         and mhv.PARAMETER_CD in ( 'CO2C', 'FLOW', 'H2O', 'O2C' )
                        left join camdecmpswks.MONITOR_FORMULA frm
                          on frm.MON_FORM_ID = dhv.MON_FORM_ID
                        LEFT JOIN camdecmpswks.MONITOR_DEFAULT AS def 
                          ON def.MON_LOC_ID = hod.MON_LOC_ID
                         AND def.DEFAULT_PURPOSE_CD = 'PM'
                         AND def.PARAMETER_CD = 'H2O'
                         AND ( def.BEGIN_DATE + ( def.BEGIN_HOUR || ' hour' )::interval ) <= ( hod.BEGIN_DATE + ( hod.BEGIN_HOUR || ' hour' )::interval )
                         AND ( ( def.END_DATE is null ) or ( def.END_DATE + ( def.END_HOUR || ' hour' )::interval ) >= ( hod.BEGIN_DATE + ( hod.BEGIN_HOUR || ' hour' )::interval ) )

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
        ) dat
     where  dat.HI_HOUR_ID is not null
       and  dat.FLOW_HOUR_ID is not null;


  RAISE NOTICE 'Refreshing view counts...';
  CALL camdecmpswks.refresh_emission_view_count(vmonplanid, vrptperiodid, 'HICEMS');
END
$procedure$
