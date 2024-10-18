CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_massoilcalc
(
    IN vmonplanid character varying,
    IN vrptperiodid numeric
)
 LANGUAGE plpgsql
AS $procedure$
DECLARE
BEGIN
    RAISE NOTICE 'Deleting existing records...';
    DELETE FROM camdecmpswks.EMISSION_VIEW_MASSOILCALC	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;

    RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmpswks.EMISSION_VIEW_MASSOILCALC(
		MON_PLAN_ID,
		MON_LOC_ID,
		RPT_PERIOD_ID,
		DATE_HOUR,
		OP_TIME,
		FUEL_SYS_ID,
		OIL_TYPE,
		FUEL_USE_TIME,
		RPT_VOLUMETRIC_OIL_FLOW,
		CALC_VOLUMETRIC_OIL_FLOW,
		VOLUMETRIC_OIL_FLOW_UOM,
		VOLUMETRIC_OIL_FLOW_SODC,
		OIL_DENSITY,
		OIL_DENSITY_UOM,
		OIL_DENSITY_SAMPLING_TYPE,
		RPT_MASS_OIL_FLOW,
		CALC_MASS_OIL_FLOW,
		ERROR_CODES
	)
    select  mpl.MON_PLAN_ID, 
            hod.MON_LOC_ID, 
            hod.RPT_PERIOD_ID,
            camdecmpswks.format_date_hour( hod.BEGIN_DATE, hod.BEGIN_HOUR, null ) AS DATE_HOUR,
            hod.OP_TIME,
            COALESCE( sys.SYSTEM_IDENTIFIER, '' ) AS FUEL_SYS_ID,
            hff.FUEL_CD AS FUEL_TYPE,
            hff.FUEL_USAGE_TIME AS FUEL_USE_TIME,
            hff.VOLUMETRIC_FLOW_RATE AS RPT_VOLUMETRIC_OIL_FLOW,
            hff.CALC_VOLUMETRIC_FLOW_RATE AS CALC_VOLUMETRIC_OIL_FLOW,
            hff.VOLUMETRIC_UOM_CD AS VOLUMETRIC_OIL_FLOW_UOM,
            hff.SOD_VOLUMETRIC_CD AS VOLUMETRIC_OIL_FLOW_SODC,
            hpff.PARAM_VAL_FUEL AS OIL_DENSITY,
            hpff.PARAMETER_UOM_CD AS OIL_DENSITY_UOM,
            hpff.SAMPLE_TYPE_CD AS OIL_DENSITY_SAMPLING_TYPE,
            hff.MASS_FLOW_RATE AS RPT_MASS_OIL_FLOW,
            hff.CALC_MASS_FLOW_RATE AS CALC_MASS_OIL_FLOW,
            (
                select  case when max( coalesce( sev.SEVERITY_LEVEL, 0 ) ) > 0 then 'Y' else NULL end
                  from  camdecmpswks.CHECK_LOG chl
                        left join camdecmpsmd.SEVERITY_CODE sev
                          on sev.SEVERITY_CD = chl.SEVERITY_CD
                 where  chl.CHK_SESSION_ID = ems.CHK_SESSION_ID
                   and  chl.MON_LOC_ID = hod.MON_LOC_ID
                   and  ( chl.OP_BEGIN_DATE < hod.BEGIN_DATE or ( chl.OP_BEGIN_DATE = hod.BEGIN_DATE and chl.OP_BEGIN_HOUR <= hod.BEGIN_HOUR ) )
                   and  ( chl.OP_END_DATE > hod.BEGIN_DATE or ( chl.OP_END_DATE = hod.BEGIN_DATE and chl.OP_END_HOUR >= hod.BEGIN_HOUR ) )
            ) as ERROR_CODES
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
            left join camdecmpswks.HRLY_PARAM_FUEL_FLOW hpff
              on hpff.RPT_PERIOD_ID = hff.RPT_PERIOD_ID
             and hpff.MON_LOC_ID = hff.MON_LOC_ID
             and hpff.HRLY_FUEL_FLOW_ID = hff.HRLY_FUEL_FLOW_ID
             and hpff.PARAMETER_CD = 'DENSOIL'
     where  hff.VOLUMETRIC_FLOW_RATE > 0
       and  hff.MASS_FLOW_RATE > 0;

  RAISE NOTICE 'Refreshing view counts...';
  CALL camdecmpswks.refresh_emission_view_count(vmonplanid, vrptperiodid, 'MASSOILCALC');
END
$procedure$
