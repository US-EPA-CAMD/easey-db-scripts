-- FUNCTION: camdecmpswks.unit_program_parameter(character varying)

-- DROP FUNCTION camdecmpswks.unit_program_parameter(character varying);

CREATE OR REPLACE FUNCTION camdecmpswks.unit_program_parameter(
	monplanid character varying)
    RETURNS TABLE(oris_code numeric, unit_name character varying, prg_cd character varying, class character varying, os_ind numeric, parameter_cd character varying, required_ind numeric, param_begin_date date, param_end_date date, umcb_date date, erb_date date, prg_end_date date, fac_id numeric, mon_plan_id character varying, mon_loc_id character varying, unit_id numeric, up_id numeric, prg_id numeric, prg_param_id numeric, begin_rpt_period_id numeric, end_rpt_period_id numeric) 
    LANGUAGE 'sql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
select fac.ORIS_CODE,
         unt.UNITID UNIT_NAME,
         unp.PRG_CD,
         unp.CLASS_cd as class,
         ppr.OS_IND,
         ppr.PARAMETER_CD,
         ppr.REQUIRED_IND,
         ppb.BEGIN_DATE PARAM_BEGIN_DATE,
         ppe.END_DATE PARAM_END_DATE,
         unp.UNIT_MONITOR_CERT_BEGIN_DATE UMCB_DATE,
         unp.EMISSIONS_RECORDING_BEGIN_DATE ERB_DATE,
         unp.END_DATE PRG_END_DATE,
         pln.FAC_ID,
         pln.MON_PLAN_ID,
         mpl.MON_LOC_ID,
         loc.UNIT_ID,
         unp.UP_ID,
         unp.PRG_ID,
         ppr.PRG_PARAM_ID,
         ppr.BEGIN_RPT_PERIOD_ID,
         ppr.END_RPT_PERIOD_ID
    from camdecmpswks.MONITOR_PLAN pln
         join camdecmpsmd.REPORTING_PERIOD mpb
           on mpb.RPT_PERIOD_ID = pln.BEGIN_RPT_PERIOD_ID
         left join camdecmpsmd.REPORTING_PERIOD mpe
           on mpe.RPT_PERIOD_ID = pln.END_RPT_PERIOD_ID
         join camdecmpswks.MONITOR_PLAN_LOCATION mpl
           on mpl.MON_PLAN_ID = pln.MON_PLAN_ID
         join camdecmpswks.MONITOR_LOCATION loc
           on loc.MON_LOC_ID = mpl.MON_LOC_ID
              and loc.UNIT_ID is not null
         join camd.UNIT unt
           on unt.UNIT_ID = loc.UNIT_ID
         join camd.plant fac
           on fac.FAC_ID = unt.FAC_ID
         join camd.UNIT_PROGRAM unp
           on unp.UNIT_ID = loc.UNIT_ID
         join camdecmpswks.vw_program_parameter ppr
           on ppr.PRG_ID = unp.PRG_ID
         join camdecmpsmd.REPORTING_PERIOD ppb
           on ppb.RPT_PERIOD_ID = ppr.BEGIN_RPT_PERIOD_ID
              and (mpe.END_DATE is null or ppb.BEGIN_DATE <= mpe.END_DATE)
         left join camdecmpsmd.REPORTING_PERIOD ppe
           on ppe.RPT_PERIOD_ID = ppr.END_RPT_PERIOD_ID
              and (ppe.END_DATE is null or ppe.END_DATE >= mpb.BEGIN_DATE)
		WHERE (monplanid /*Replace Parameter*/ is null or pln.MON_PLAN_ID = monplanid /*Replace Parameter*/);
$BODY$;
