-- FUNCTION: camdecmpswks.update_collateral_em_data_for_em_changes(character varying, integer)

-- DROP FUNCTION IF EXISTS camdecmpswks.update_collateral_em_data_for_em_changes(character varying, integer);

CREATE OR REPLACE FUNCTION camdecmpswks.update_collateral_em_data_for_esa_changes
(
	vMonPlanId character varying,
	vRptPeriodId integer
)
RETURNS TABLE( result text, error_msg character varying )

LANGUAGE 'plpgsql'
COST 100
VOLATILE PARALLEL UNSAFE
ROWS 1000

AS $BODY$

DECLARE
    
    dat record;
    
    loopResult text;
    loopErrorMsg character varying;
    
BEGIN
    
    error_msg := '';
    result := 'T';
    
    for dat in
    (
        select  distinct
                uem.mon_plan_id,
                uem.rpt_period_id
          from  camdecmps.EMISSION_EVALUATION sem
                join camdecmpsmd.REPORTING_PERIOD srp
                  on srp.rpt_period_id = sem.rpt_period_id
                join camdecmps.MONITOR_PLAN_LOCATION spl
                  on spl.mon_plan_id = sem.mon_plan_id
                join camdecmps.MONITOR_PLAN_LOCATION upl
                  on upl.mon_loc_id = spl.mon_loc_id
                join camdecmps.EMISSION_EVALUATION uem
                  on uem.mon_plan_id = upl.mon_plan_id
                 and exists
                     (
                        select  1
                          from  camdecmpsaux.EM_SUBMISSION_ACCESS esa
                         where  esa.mon_plan_id = uem.mon_plan_id
                           and  esa.rpt_period_id = uem.rpt_period_id
                           and  esa.sub_availability_cd in ( 'GRANTED', 'REQUIRE' )
                     )
                join camdecmpsmd.REPORTING_PERIOD urp
                  on urp.rpt_period_id = uem.rpt_period_id
         where  sem.rpt_period_id = vRptPeriodId
           and  sem.mon_plan_id = vMonPlanId
           and  (
                    urp.calendar_year > srp.calendar_year
                    or
                    urp.calendar_year = srp.calendar_year and
                    urp.quarter >= srp.quarter
                )
    )
    loop
    
        select  *
          into  loopResult, loopErrorMsg
          from  camdecmpswks.delete_calculated_em_data_from_workspace( dat.mon_plan_id, dat.rpt_period_id::int );
        
        if ( coalesce( loopResult, 'F' ) != 'T' )
        then
            error_msg := coalesce( loopErrorMsg, 'delete_calculated_em_data_from_workspace error' );
            result := coalesce( loopResult, 'F' );
            exit;
        end if;
    
    end loop;

    return next; -- Add row to return table.
  
EXCEPTION WHEN OTHERS THEN

    get stacked diagnostics error_msg:= message_text;
    result = 'F';
    error_msg :='From update_collateral_em_data_for_esa_changes' ||' '|| error_msg;
	 
    return next; -- Add row to return table.

END;

$BODY$;

