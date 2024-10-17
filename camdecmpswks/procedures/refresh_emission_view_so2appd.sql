CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_so2appd
(
    IN vmonplanid character varying,
    IN vrptperiodid NUMERIC
)
 LANGUAGE plpgsql
AS $procedure$
DECLARE 
BEGIN
    RAISE NOTICE 'Deleting existing records...';

	DELETE FROM camdecmpswks.EMISSION_VIEW_SO2APPD 	WHERE MON_PLAN_ID = vmonplanid AND RPT_PERIOD_ID = vrptperiodid;
    RAISE NOTICE 'Refreshing view data...';

	INSERT INTO camdecmpswks.EMISSION_VIEW_SO2APPD(
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
		CALC_FUEL_FLOW,
		FUEL_FLOW_UOM,
		FUEL_FLOW_SODC,
		SULFUR_CONTENT,
		SULFUR_UOM,
		SULFUR_SAMPLING_TYPE,
		DEFAULT_SO2_EMISSION_RATE,
		CALC_HI_RATE,
		FORMULA_CD,
		RPT_SO2_MASS_RATE,
		CALC_SO2_MASS_RATE,
		SUMMATION_FORMULA_CD,
		RPT_SO2_MASS_RATE_ALL_FUELS,
		CALC_SO2_MASS_RATE_ALL_FUELS,
		ERROR_CODES
	)
    select  dat.MON_PLAN_ID, 
            dat.MON_LOC_ID, 
            dat.RPT_PERIOD_ID, 
            camdecmpswks.format_date_hour( dat.BEGIN_DATE, dat.BEGIN_HOUR, null ) as DATE_HOUR,
            dat.OP_TIME, 
            COALESCE( dat.SYSTEM_IDENTIFIER, '' ) as FUEL_SYS_ID,
            dat.FUEL_CD as FUEL_TYPE,
            dat.FUEL_USAGE_TIME as FUEL_USE_TIME,
            dat.HR_LOAD as UNIT_LOAD, 
            dat.LOAD_UOM_CD as LOAD_UOM,
            case 
                when ( dat.SO2_HPFF_FORMULA_CD IN ( 'D-2', 'D-4' ) ) then
                    case 
                        when ( dat.FUEL_GROUP_CD = 'GAS' )
                        then dat.CALC_VOLUMETRIC_FLOW_RATE
                        else dat.CALC_MASS_FLOW_RATE
                    end 
            end as CALC_FUEL_FLOW,
            case
                when ( dat.SO2_HPFF_FORMULA_CD IN ( 'D-2', 'D-4' ) ) then
                    case 
                        when ( dat.FUEL_GROUP_CD = 'GAS' )
                        then dat.VOLUMETRIC_UOM_CD
                        else 'LBHR'
                    end
            end as FUEL_FLOW_UOM,
            case
                when ( dat.SO2_HPFF_FORMULA_CD IN ( 'D-2', 'D-4' ) ) then
                    case 
                        when ( dat.FUEL_GROUP_CD = 'GAS' )
                        then dat.SOD_VOLUMETRIC_CD
                        else dat.SOD_MASS_CD
                    end
            end as FUEL_FLOW_SODC,
            dat.SULFUR_PARAM_VAL_FUEL as SULFUR_CONTENT,
            dat.SULFUR_PARAMETER_UOM_CD as SULFUR_UOM,
            dat.SULFUR_SAMPLE_TYPE_CD as SULFUR_SAMPLING_TYPE,
            dat.SO2R_PARAM_VAL_FUEL as DEFAULT_SO2_EMISSION_RATE,
            dat.HI_CALC_PARAM_VAL_FUEL as CALC_HI_RATE,
            dat.SO2_HPFF_FORMULA_CD as FORMULA_CODE,
            dat.SO2_HPFF_PARAM_VAL_FUEL as RPT_SO2_MASS_RATE,
            dat.SO2_HPFF_CALC_PARAM_VAL_FUEL as CALC_SO2_MASS_RATE,
            dat.SO2_DHV_FORMULA_CD as SUMMATION_FORMULA_CD,
            dat.SO2_DHV_ADJUSTED_HRLY_VALUE as RPT_SO2_MASS_RATE_ALL_FUELS,
            dat.SO2_DHV_CALC_ADJUSTED_HRLY_VALUE as CALC_SO2_MASS_RATE_ALL_FUELS,
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
                        ems.CHK_SESSION_ID,
                        -- HFF
                        hff.FUEL_CD,
                        hff.FUEL_USAGE_TIME,
                        hff.CALC_MASS_FLOW_RATE,
                        hff.CALC_VOLUMETRIC_FLOW_RATE,
                        hff.VOLUMETRIC_UOM_CD,
                        hff.SOD_MASS_CD,
                        hff.SOD_VOLUMETRIC_CD,
                        sys.SYSTEM_IDENTIFIER,
                        fue.FUEL_GROUP_CD,
                        -- CO2 DHV
                        dhv.ADJUSTED_HRLY_VALUE as SO2_DHV_ADJUSTED_HRLY_VALUE,
                        dhv.CALC_ADJUSTED_HRLY_VALUE as SO2_DHV_CALC_ADJUSTED_HRLY_VALUE,
                        dhv_frm.EQUATION_CD as SO2_DHV_FORMULA_CD,
                        -- SO2 HPFF
                        max( case when hpff.PARAMETER_CD = 'SO2'    then hpff.HRLY_FUEL_FLOW_ID end ) as SO2_HPFF_HRLY_FUEL_FLOW_ID,
                        max( case when hpff.PARAMETER_CD = 'SO2'    then hpff.PARAM_VAL_FUEL end ) as SO2_HPFF_PARAM_VAL_FUEL,
                        max( case when hpff.PARAMETER_CD = 'SO2'    then hpff.CALC_PARAM_VAL_FUEL end ) as SO2_HPFF_CALC_PARAM_VAL_FUEL,
                        max( case when hpff.PARAMETER_CD = 'SO2'    then hpff_frm.EQUATION_CD end ) as SO2_HPFF_FORMULA_CD,
                        -- SO2R HPFF
                        max( case when hpff.PARAMETER_CD = 'SO2R'   then hpff.PARAM_VAL_FUEL end ) as SO2R_PARAM_VAL_FUEL,
                        -- SULFUR HPFF
                        max( case when hpff.PARAMETER_CD = 'SULFUR' then hpff.PARAM_VAL_FUEL end ) as SULFUR_PARAM_VAL_FUEL,
                        max( case when hpff.PARAMETER_CD = 'SULFUR' then hpff.PARAMETER_UOM_CD end ) as SULFUR_PARAMETER_UOM_CD,
                        max( case when hpff.PARAMETER_CD = 'SULFUR' then hpff.SAMPLE_TYPE_CD end ) as SULFUR_SAMPLE_TYPE_CD,
                        -- HI HPFF
                        max( case when hpff.PARAMETER_CD = 'HI'  then hpff.CALC_PARAM_VAL_FUEL end ) as HI_CALC_PARAM_VAL_FUEL
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
                        join camdecmpswks.HRLY_FUEL_FLOW hff
                          on hff.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
                         and hff.MON_LOC_ID = hod.MON_LOC_ID
                         and hff.HOUR_ID = hod.HOUR_ID
                        left join camdecmpswks.MONITOR_SYSTEM sys
                          on sys.MON_SYS_ID = hff.MON_SYS_ID
                        left join camdecmpsmd.FUEL_CODE fue
                          on fue.FUEL_CD = hff.FUEL_CD
                        join camdecmpswks.HRLY_PARAM_FUEL_FLOW hpff
                          on hpff.RPT_PERIOD_ID = hff.RPT_PERIOD_ID
                         and hpff.MON_LOC_ID = hff.MON_LOC_ID
                         and hpff.HRLY_FUEL_FLOW_ID = hff.HRLY_FUEL_FLOW_ID
                         and hpff.PARAMETER_CD in ( 'HI', 'SO2', 'SO2R', 'SULFUR' )
                        left join camdecmpswks.MONITOR_FORMULA hpff_frm
                          on hpff_frm.MON_FORM_ID = hpff.MON_FORM_ID
                        left join camdecmpswks.DERIVED_HRLY_VALUE dhv
                          on dhv.RPT_PERIOD_ID = hff.RPT_PERIOD_ID
                         and dhv.MON_LOC_ID = hff.MON_LOC_ID
                         and dhv.HOUR_ID = hff.HOUR_ID
                         and dhv.PARAMETER_CD = 'SO2'
                        left join camdecmpswks.MONITOR_FORMULA dhv_frm
                          on dhv_frm.MON_FORM_ID = dhv.MON_FORM_ID
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
                        hff.FUEL_CD,
                        hff.FUEL_USAGE_TIME,
                        hff.CALC_MASS_FLOW_RATE,
                        hff.CALC_VOLUMETRIC_FLOW_RATE,
                        hff.VOLUMETRIC_UOM_CD,
                        hff.SOD_MASS_CD,
                        hff.SOD_VOLUMETRIC_CD,
                        sys.SYSTEM_IDENTIFIER,
                        fue.FUEL_GROUP_CD,
                        dhv.ADJUSTED_HRLY_VALUE,
                        dhv.CALC_ADJUSTED_HRLY_VALUE,
                        dhv_frm.EQUATION_CD,
                        ems.CHK_SESSION_ID
            ) dat
     where  dat.SO2_HPFF_HRLY_FUEL_FLOW_ID is not null;

    RAISE NOTICE 'Refreshing view counts...';

    CALL camdecmpswks.refresh_emission_view_count(vmonplanid, vrptperiodid, 'SO2APPD');
END
$procedure$
