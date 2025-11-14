-- FUNCTION: camdecmps.rpt_em_emission_view_summary(text, text, text)

-- DROP FUNCTION IF EXISTS camdecmps.rpt_em_emission_view_summary(text, text, text);

CREATE OR REPLACE FUNCTION camdecmps.rpt_em_emission_view_summary
(
    monitorplanid text, 
    locationid text, 
    reportingperiodids text
)
    RETURNS TABLE
    (
        period_description character varying,
        op_hours numeric,
        op_time numeric,
        heat_input numeric,
        so2_mass numeric,
        co2_mass numeric,
        nox_rate numeric,
        nox_mass numeric
    )
LANGUAGE plpgsql
AS $function$
BEGIN
    
    RETURN QUERY
        select  cmb.period_description, 
                cmb.op_hours,
                cmb.op_time,
                cmb.heat_input,
                cmb.so2_mass,
                cmb.co2_mass,
                cmb.nox_rate,
                cmb.nox_mass
          from  (
                    select  lst.calendar_year,
                            lst.period_description, 
                            lst.summary_name as row_name,
                            max( case when lst.parameter_cd = 'OPHOURS' then lst.summary_value end ) as op_hours,
                            max( case when lst.parameter_cd = 'OPTIME' then lst.summary_value end ) as op_time,
                            max( case when lst.parameter_cd = 'HIT' then lst.summary_value end ) as heat_input,
                            max( case when lst.parameter_cd = 'SO2M' then lst.summary_value end ) as so2_mass,
                            max( case when lst.parameter_cd = 'CO2M' then lst.summary_value end ) as co2_mass,
                            max( case when lst.parameter_cd = 'NOXR' then lst.summary_value end ) as nox_rate,
                            max( case when lst.parameter_cd = 'NOXM' then lst.summary_value end ) as nox_mass,
                            lst.summary_num
                      from  (
                                select  smv.mon_loc_id,
                                        smv.rpt_period_id,
                                        prd.calendar_year,
                                        case ( typ.summary_type_cd )
                                            when 'QTRRPT'   THEN prd.period_description
                                            when 'OSRPT'    THEN prd.calendar_year || ' Ozone Season'
                                            when 'YEARRPT'  THEN prd.calendar_year || ' Year-to-Date'
                                        end as period_description,
                                        smv.parameter_cd,
                                        typ.summary_num,   
                                        typ.summary_type_cd,
                                        typ.summary_name,
                                        case ( typ.summary_type_cd )
                                            when 'QTRRPT'   THEN smv.current_rpt_period_total
                                            when 'YEARRPT'  THEN smv.year_total
                                            when 'OSRPT'    THEN smv.os_total
                                        end as summary_value
                                  from  (
                                            select  sel.mon_plan_id,
                                                    sel.mon_loc_id,
                                                    (
                                                        select  sub.rpt_period_id
                                                          from  camdecmpsmd.REPORTING_PERIOD sub
                                                         where  sub.calendar_year = prd.calendar_year
                                                           and  sub.quarter = max( prd.quarter )
                                                    ) as rpt_period_id
                                              from  (
                                                        select  monitorplanid as mon_plan_id,
                                                                reportingperiodids as rpt_period_id_list,
                                                                locationid as mon_loc_id
                                                    ) sel
                                                    join camdecmpsmd.REPORTING_PERIOD prd
                                                      on prd.rpt_period_id in ( select unnest( string_to_array( sel.rpt_period_id_list, ',' )::numeric[] ) )
                                             group
                                                by  sel.mon_plan_id,
                                                    sel.mon_loc_id,
                                                    prd.calendar_year
                                        ) sel
                                        join camdecmps.EMISSION_EVALUATION ems using ( mon_plan_id, rpt_period_id )
                                        join camdecmpsmd.REPORTING_PERIOD prs using ( rpt_period_id )
                                        join camdecmpsmd.REPORTING_PERIOD prd
                                          on prd.calendar_year = prs.calendar_year
                                         and prd.quarter <= prs.quarter
                                        join camdecmps.MONITOR_PLAN_LOCATION mpl using ( mon_plan_id, mon_loc_id )
                                        join camdecmps.SUMMARY_VALUE smv
                                          on smv.rpt_period_id = prd.rpt_period_id
                                         and smv.mon_loc_id = mpl.mon_loc_id
                                         and smv.parameter_cd in ( 'CO2M', 'HIT', 'NOXM', 'NOXR', 'OPHOURS', 'OPTIME', 'SO2M' )
                                        join (
                                                select 'QTRRPT' as summary_type_cd, 'Quarterly Reported' as summary_name, 1 as summary_num union all
                                                select 'OSRPT' as summary_type_cd, 'Ozone Season Reported' as summary_name, 2 as summary_num union all
                                                select 'YEARRPT' as summary_type_cd, 'Year to Date Reported' as summary_name, 3 as summary_num
                                             ) typ
                                          on null is null
                                 where  (
                                            typ.summary_type_cd = 'QTRRPT'
                                            or
                                            prd.rpt_period_id = sel.rpt_period_id
                                        )
                            ) lst
                     group
                        by  lst.mon_loc_id,
                            lst.rpt_period_id,
                            lst.calendar_year,
                            lst.period_description,
                            lst.summary_num,   
                            lst.summary_type_cd,
                            lst.summary_name
                ) cmb
         order
            by  calendar_year,
                summary_num,
                period_description;
    
END;
$function$
;
