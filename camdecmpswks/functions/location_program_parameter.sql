-- FUNCTION: camdecmpswks.location_program_parameter(character varying)

DROP FUNCTION IF EXISTS camdecmpswks.location_program_parameter(character varying) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.location_program_parameter(
	monplanid character varying)
    RETURNS TABLE(oris_code numeric, location_name character varying, unit_name character varying, prg_cd character varying, class character varying, os_ind numeric, parameter_cd character varying, required_ind numeric, param_begin_date date, param_end_date date, umcb_date date, erb_date date, prg_end_date date, fac_id numeric, mon_plan_id character varying, mon_loc_id character varying, unit_id numeric, up_id numeric, prg_id numeric, prg_param_id numeric, begin_rpt_period_id numeric, end_rpt_period_id numeric) 
    LANGUAGE 'sql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
select fac.ORIS_CODE, COALESCE(stp.STACK_NAME, unt.UNITID) LOCATION_NAME,     unt.UNITID UNIT_NAME,
         unp.PRG_CD,   unp.CLASS_CD AS CLASS, pc.OS_IND,  pp.PARAMETER_CD,   pp.REQUIRED_IND,     ppb.BEGIN_DATE PARAM_BEGIN_DATE,     ppe.END_DATE PARAM_END_DATE,     unp.UNIT_MONITOR_CERT_BEGIN_DATE UMCB_DATE,
         unp.EMISSIONS_RECORDING_BEGIN_DATE ERB_DATE,   unp.END_DATE PRG_END_DATE,   pln.FAC_ID,
         pln.MON_PLAN_ID,  mpl.MON_LOC_ID,    loc.UNIT_ID,    unp.UP_ID,    unp.PRG_ID,   pp.PRG_PARAM_ID,
         pp.BEGIN_RPT_PERIOD_ID,    pp.END_RPT_PERIOD_ID
    from camdecmpswks.MONITOR_PLAN pln
         join camdecmpsmd.REPORTING_PERIOD mpb             on mpb.RPT_PERIOD_ID = pln.BEGIN_RPT_PERIOD_ID
         left join camdecmpsmd.REPORTING_PERIOD mpe          on mpe.RPT_PERIOD_ID = pln.END_RPT_PERIOD_ID
         join camdecmpswks.MONITOR_PLAN_LOCATION mpl             on mpl.MON_PLAN_ID = pln.MON_PLAN_ID
         join camdecmpswks.MONITOR_LOCATION loc                 on loc.MON_LOC_ID = mpl.MON_LOC_ID
         left join camdecmpswks.STACK_PIPE stp          	 on stp.STACK_PIPE_ID = loc.STACK_PIPE_ID
         left join camdecmpswks.UNIT_STACK_CONFIGURATION usc  on usc.STACK_PIPE_ID = loc.STACK_PIPE_ID
         join camd.UNIT unt                   on unt.UNIT_ID in (loc.UNIT_ID, usc.UNIT_ID)
         join camd.plant fac                    on fac.FAC_ID = unt.FAC_ID
         join camd.UNIT_PROGRAM unp                 on unp.UNIT_ID = unt.UNIT_ID
         join camdecmpsaux.program_parameter pp on pp.PRG_ID = unp.PRG_ID
         JOIN camd.program p ON p.prg_id = pp.prg_id
         JOIN camdmd.program_code pc ON pc.prg_cd::text = p.prg_cd::text
         join camdecmpsmd.REPORTING_PERIOD ppb    on ppb.RPT_PERIOD_ID = pp.BEGIN_RPT_PERIOD_ID
         left join camdecmpsmd.REPORTING_PERIOD ppe      on ppe.RPT_PERIOD_ID = pp.END_RPT_PERIOD_ID
    WHERE (monplanid is null or mpl.MON_PLAN_ID = monplanid)
$BODY$;
