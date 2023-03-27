-- FUNCTION: camdecmpswks.reporting_frequency_by_location_quarter(character varying)

DROP FUNCTION IF EXISTS camdecmpswks.reporting_frequency_by_location_quarter(character varying);

CREATE OR REPLACE FUNCTION camdecmpswks.reporting_frequency_by_location_quarter(
	monplanid character varying)
    RETURNS TABLE(mon_loc_id character varying, oris_code numeric, location_name character varying, calendar_year numeric, quarter numeric, report_freq_cd character varying) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
BEGIN
RETURN QUERY
( with  sel as (select loc.Mon_Loc_Id,
                     fac.Oris_COde,
			       	COALESCE(unt.UNITID, stp.STACK_NAME) Location_Name,
                     fac.Fac_Id
                from camdecmpswks.MONITOR_PLAN pln
			       join camd.plant fac  on fac.Fac_Id = pln.Fac_Id
                   join camdecmpswks.MONITOR_PLAN_LOCATION mpl on mpl.Mon_Plan_Id = pln.Mon_Plan_Id
                   join camdecmpswks.MONITOR_LOCATION loc  on loc.Mon_Loc_Id = mpl.Mon_Loc_Id
                   left join camd.UNIT unt  on unt.Unit_Id = loc.Unit_Id
                   left join camdecmpswks.STACK_PIPE stp   on stp.Stack_Pipe_Id = loc.Stack_Pipe_Id
                where pln.Mon_Plan_Id = monPlanId
           ),
  rng as (select sel.Mon_Loc_Id,
                     sel.Oris_Code,
                     sel.Location_Name,
                     rpf.Report_Freq_Cd,
                     prb.Begin_Date,
                     pre.End_Date
                from sel
                     join camdecmpswks.MONITOR_PLAN_LOCATION mpl  on mpl.Mon_Loc_Id = sel.Mon_Loc_Id
                     join camdecmpswks.MONITOR_PLAN_REPORTING_FREQ rpf on rpf.Mon_Plan_Id = mpl.Mon_Plan_Id
                     join camdecmpsmd.REPORTING_PERIOD prb on prb.Rpt_Period_Id = rpf.Begin_Rpt_Period_Id
                     join camdecmpsmd.REPORTING_PERIOD pre on (rpf.End_Rpt_Period_Id is not null 
							and pre.Rpt_Period_Id = rpf.End_Rpt_Period_Id or
                           rpf.End_Rpt_Period_Id is null and now() between pre.Begin_Date and pre.End_Date)
           )
 select rng.Mon_Loc_Id,
         rng.Oris_Code,
         rng.Location_Name,
         prd.Calendar_Year,
         prd.Quarter,
         rng.Report_Freq_Cd
    from rng
         join camdecmpsmd.REPORTING_PERIOD prd
             on prd.Begin_Date <= rng.End_Date
             and prd.End_Date >= rng.Begin_Date);

END;
$BODY$;
