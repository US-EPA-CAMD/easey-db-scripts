-- FUNCTION: camdecmpswks.mats_sorbent_trap_record(character varying, numeric)

DROP FUNCTION IF EXISTS camdecmpswks.mats_sorbent_trap_record(character varying, numeric) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.mats_sorbent_trap_record(
	monplanid character varying,
	rptperiodid numeric)
    RETURNS TABLE(location_name character varying, begin_datehour timestamp without time zone, end_datehour timestamp without time zone, system_identifier character varying, sys_type_cd character varying, paired_trap_agreement numeric, absolute_difference_ind numeric, modc_cd character varying, hg_concentration character varying, trap_id character varying, begin_date date, begin_hour numeric, end_date date, end_hour numeric, rata_ind numeric, sorbent_trap_aps_cd character varying, system_begin_datehour timestamp without time zone, system_end_datehour timestamp without time zone, border_trap_ind integer, supp_data_ind integer, mon_sys_id character varying, mon_loc_id character varying, mon_plan_id character varying, rpt_period_id numeric) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
BEGIN
return query
 (with sel as
    (select  mpl.MON_PLAN_ID, prd.RPT_PERIOD_ID, mpl.MON_LOC_ID, prd.BEGIN_DATE, prd.END_DATE
          from  camdecmpswks.MONITOR_PLAN_LOCATION mpl,
                camdecmpsMD.REPORTING_PERIOD prd
         where  (monPlanId is null or mpl.MON_PLAN_ID = monPlanId)
           and  (rptPeriodId is null or prd.RPT_PERIOD_ID = rptPeriodId)
    )
select	COALESCE(unt.UNITID, stp.STACK_NAME) LOCATION_NAME,
			camdecmpswks.Format_Date_Time(dat.BEGIN_DATE, dat.BEGIN_HOUR, 0, null) BEGIN_DATEHOUR,
			camdecmpswks.Format_Date_Time(dat.END_DATE, dat.END_HOUR, 0, null) END_DATEHOUR,
   			sys.SYSTEM_IDENTIFIER,
            sys.SYS_TYPE_CD,
            dat.PAIRED_TRAP_AGREEMENT,
            dat.ABSOLUTE_DIFFERENCE_IND,
            dat.MODC_CD,
            dat.HG_CONCENTRATION,
            dat.TRAP_ID,
            dat.BEGIN_DATE,
             dat.BEGIN_HOUR,
            --convert(int, dat.BEGIN_HOUR) BEGIN_HOUR,
            dat.END_DATE,
  			dat.END_HOUR,
          --  convert(int, dat.END_HOUR) END_HOUR,
            dat.RATA_IND,
            dat.SORBENT_TRAP_APS_CD,
  			camdecmpswks.Format_Date_Time(sys.BEGIN_DATE, sys.BEGIN_HOUR, 00, null) SYS_BEGIN_DATEHOUR,
			camdecmpswks.Format_Date_Time(sys.END_DATE, sys.END_HOUR, 00, null) SYS_END_DATEHOUR,
            dat.BORDER_TRAP_IND,
            dat.SUPP_DATA_IND,
            dat.MON_SYS_ID,
            dat.MON_LOC_ID,
            dat.MON_PLAN_ID,
            dat.RPT_PERIOD_ID
      from  (      -- Emission Report Trap
                select  trp.TRAP_ID,
                        trp.MON_SYS_ID,
                        trp.BEGIN_DATE,
                        trp.BEGIN_HOUR,
                        trp.END_DATE,
                        trp.END_HOUR,
                        trp.HG_CONCENTRATION,
                        trp.MODC_CD,
                        trp.PAIRED_TRAP_AGREEMENT,
                        trp.ABSOLUTE_DIFFERENCE_IND,
                        trp.RATA_IND,
                        trp.SORBENT_TRAP_APS_CD,
                        case when sel.END_DATE < trp.END_DATE then 1 else 0 end BORDER_TRAP_IND,
                        0 SUPP_DATA_IND,
                        sel.MON_PLAN_ID,
                        sel.RPT_PERIOD_ID,
                        sel.MON_LOC_ID
                    from  sel
		               join  camdecmpswks.SORBENT_TRAP trp on trp.MON_LOC_ID = sel.MON_LOC_ID 
                         and trp.RPT_PERIOD_ID = sel.RPT_PERIOD_ID               
                union   all
                -- Supplemental Train
                 select  trp.TRAP_ID,
                        trp.MON_SYS_ID,
                        trp.BEGIN_DATE,
                        trp.BEGIN_HOUR,
                        trp.END_DATE,
                        trp.END_HOUR,
                        trp.HG_CONCENTRATION,
                        trp.MODC_CD,
                        null PAIRED_TRAP_AGREEMENT,
                        null ABSOLUTE_DIFFERENCE_IND,
                        trp.RATA_IND,
                        trp.SORBENT_TRAP_APS_CD,
                        1 BORDER_TRAP_IND,
                        1 SUPP_DATA_IND,
                        sel.MON_PLAN_ID,
                        sel.RPT_PERIOD_ID,
                        sel.MON_LOC_ID
                    from  sel
					  join camdecmpswks.SORBENT_TRAP_SUPP_DATA trp on trp.MON_LOC_ID = sel.MON_LOC_ID
                         and trp.RPT_PERIOD_ID != sel.RPT_PERIOD_ID -- Only pull supplemental if it was not reported in the quarter of the current emissions report.
                         and trp.BEGIN_DATE < sel.BEGIN_DATE
                         and trp.END_DATE >= sel.BEGIN_DATE
              ) dat
        join camdecmpswks.MONITOR_LOCATION loc on loc.MON_LOC_ID = dat.MON_LOC_ID
            left join camd.UNIT unt on unt.UNIT_ID = loc.UNIT_ID
            left join camdecmpswks.STACK_PIPE stp on stp.STACK_PIPE_ID = loc.STACK_PIPE_ID
            left join camdecmpswks.MONITOR_SYSTEM sys on sys.MON_SYS_ID = dat.MON_SYS_ID
	);
end;
$BODY$;
