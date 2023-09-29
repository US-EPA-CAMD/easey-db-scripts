-- FUNCTION: camdecmpswks.mats_sorbent_trap_supplemental_data_record(character varying, numeric)

DROP FUNCTION IF EXISTS camdecmpswks.mats_sorbent_trap_supplemental_data_record(character varying, numeric) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.mats_sorbent_trap_supplemental_data_record(
	monplanid character varying,
	rptperiodid numeric)
    RETURNS TABLE(location_name character varying, begin_datehour timestamp without time zone, end_datehour timestamp without time zone, system_identifier character varying, sys_type_cd character varying, modc_cd character varying, hg_concentration character varying, trap_id character varying, begin_date date, begin_hour numeric, end_date date, end_hour numeric, rata_ind numeric, sorbent_trap_aps_cd character varying, mon_sys_id character varying, mon_loc_id character varying, mon_plan_id character varying, rpt_period_id numeric) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
BEGIN
  -- Returns the Sorbent Trap Supplemental Data for each location that spans the beginning of the reporting period.
RETURN QUERY
select	COALESCE(unt.UNITID, stp.STACK_NAME) LOCATION_NAME,
			camdecmpswks.Format_Date_Time(sup.BEGIN_DATE, sup.BEGIN_HOUR, 0) BEGIN_DATEHOUR,
			camdecmpswks.Format_Date_Time(sup.END_DATE, sup.END_HOUR, 0) END_DATEHOUR,
			sys.SYSTEM_IDENTIFIER,
			sys.SYS_TYPE_CD,
			sup.MODC_CD,
			sup.HG_CONCENTRATION,
			sup.TRAP_ID,
			sup.BEGIN_DATE,
			sup.BEGIN_HOUR,
			sup.END_DATE,
			sup.END_HOUR,
			sup.RATA_IND,
			sup.SORBENT_TRAP_APS_CD,
			sup.MON_SYS_ID,
			mpl.MON_LOC_ID,
			ems.MON_PLAN_ID,
			ems.RPT_PERIOD_ID
		from	 camdecmpswks.EMISSION_EVALUATION ems 
		   join  camdecmpsmd.REPORTING_PERIOD prd on	prd.RPT_PERIOD_ID = ems.RPT_PERIOD_ID
		   join  camdecmpswks.MONITOR_PLAN_LOCATION mpl on	mpl.MON_PLAN_ID = ems.MON_PLAN_ID
		   join  camdecmpswks.MONITOR_LOCATION loc 	on	loc.MON_LOC_ID = mpl.MON_LOC_ID
			left join camd.UNIT unt on	unt.UNIT_ID = loc.UNIT_ID
			left join  camdecmpswks.STACK_PIPE stp on	stp.STACK_PIPE_ID = loc.STACK_PIPE_ID
			join  camdecmpswks.SORBENT_TRAP_SUPP_DATA sup 	on	sup.MON_LOC_ID = mpl.MON_LOC_ID
						and sup.RPT_PERIOD_ID != prd.RPT_PERIOD_ID -- Ensure original data for suplemental was not reported in the quarter of the current emissions.
						and sup.BEGIN_DATE < prd.BEGIN_DATE
						and sup.END_DATE >= prd.BEGIN_DATE
			left join  camdecmpswks.MONITOR_SYSTEM sys on	sys.MON_SYS_ID = sup.MON_SYS_ID
		where	(monPlanId is null or ems.MON_PLAN_ID = monPlanId)
				and (rptPeriodId is null or ems.RPT_PERIOD_ID = rptPeriodId);
end;
$BODY$;
