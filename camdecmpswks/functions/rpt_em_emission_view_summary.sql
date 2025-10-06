-- FUNCTION: camdecmpswks.rpt_em_emission_view_summary(text, text, text)

-- DROP FUNCTION IF EXISTS camdecmpswks.rpt_em_emission_view_summary(text, text, text);

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_em_emission_view_summary(
	p_mon_plan_id text,
	p_loc_id text,
	p_rpt_period_id text)
    RETURNS TABLE(period_description character varying, row_name text, op_hours numeric, op_time numeric, heat_input numeric, so2_mass numeric, co2_mass numeric, nox_rate numeric, nox_mass numeric) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

BEGIN
  /* get data for target quarter. It's not the same version as in official(camdecmps)
    This Workspace version will get data from both the camdecmps amd camdecmpswks SUMMARY_VALUE 
	tables. if the camdecmpswks.EMISSION_EVALUATION row exists for the MON_PLAN_ID and target quarter RPT_PERIOD_ID, then 
	the data will come from the Workspace (camdecmpswks) SUMMAYR_VALUE table, otherwise the data will come from the 
	Official (camdecmps) SUMMARY_VALUE table.
  */
  RETURN QUERY
  select  cmb.period_description, cmb.row_name, cmb.op_hours, cmb.op_time,
	      cmb.heat_input, cmb.so2_mass, cmb.co2_mass, cmb.nox_rate, cmb.nox_mass
  from (select lst.period_description, lst.summary_name as row_name,
			max( case when lst.parameter_cd = 'OPHOURS' then lst.summary_value end ) as op_hours,
			max( case when lst.parameter_cd = 'OPTIME' then lst.summary_value end ) as op_time,
			max( case when lst.parameter_cd = 'HIT' then lst.summary_value end ) as heat_input,
			max( case when lst.parameter_cd = 'SO2M' then lst.summary_value end ) as so2_mass,
			max( case when lst.parameter_cd = 'CO2M' then lst.summary_value end ) as co2_mass,
			max( case when lst.parameter_cd = 'NOXR' then lst.summary_value end ) as nox_rate,
			max( case when lst.parameter_cd = 'NOXM' then lst.summary_value end ) as nox_mass,
			lst.summary_num
        from (select smv.mon_loc_id,smv.rpt_period_id,prs.period_description,
              smv.parameter_cd, typ.summary_num,typ.summary_type_cd,typ.summary_name,
                    case ( typ.summary_type_cd )
                        when 'QTRRPT'   THEN smv.current_rpt_period_total
                        when 'QTRCALC'  THEN smv.calc_current_rpt_period_total
                        when 'YEARRPT'  THEN smv.year_total
                        when 'YEARCALC' THEN smv.calc_year_total
                        when 'OSRPT'    THEN smv.os_total
                        when 'OSCALC'   THEN smv.calc_os_total
                    end as summary_value
		     from  camdecmps.SUMMARY_VALUE smv
		      join camdecmps.MONITOR_PLAN_LOCATION mpl on mpl.mon_loc_id=smv.mon_loc_id
					and mpl.mon_plan_id = p_mon_plan_id
					and smv.parameter_cd in ('CO2M','HIT','NOXM','NOXR','OPHOURS','OPTIME','SO2M') 
					and smv.mon_loc_id = p_loc_id
  	          join camdecmps.EMISSION_EVALUATION ems on ems.rpt_period_id =smv.rpt_period_id
					and mpl.mon_plan_id=ems.mon_plan_id 
					and smv.rpt_period_id = any( string_to_array( p_rpt_period_id, ',' )::numeric[] )
		      join camdecmpsmd.REPORTING_PERIOD prs on prs.rpt_period_id = ems.rpt_period_id
  		      join( 
			     select 'QTRRPT' as summary_type_cd, 'Quarterly Reported' as summary_name, 1 as summary_num union all
        		 select 'QTRCALC' as summary_type_cd, 'Quarterly Calculated' as summary_name, 2 as summary_num union all
        		 select 'YEARRPT' as summary_type_cd, 'Year to Date Reported' as summary_name, 3 as summary_num union all
         		 select 'YEARCALC' as summary_type_cd, 'Year to Date Calculated' as summary_name, 4 as summary_num union all
        		 select 'OSRPT' as summary_type_cd, 'Ozone Season Reported' as summary_name, 5 as summary_num union all
         		 select 'OSCALC' as summary_type_cd, 'Ozone Season Calculated' as summary_name, 6 as summary_num
                  ) typ
				on null is null
            where not exists
				(select 1 from  camdecmpswks.EMISSION_EVALUATION exs
					where exs.rpt_period_id = prs.rpt_period_id 
					and exs.mon_plan_id = mpl.mon_plan_id)
				) lst   
			group by  lst.mon_loc_id, lst.rpt_period_id,lst.period_description, lst.summary_num,lst.summary_type_cd,lst.summary_name
    union  all
        select  lst.period_description, lst.summary_name as row_name,
            max( case when lst.parameter_cd = 'OPHOURS' then lst.summary_value end ) as op_hours,
            max( case when lst.parameter_cd = 'OPTIME' then lst.summary_value end ) as op_time,
            max( case when lst.parameter_cd = 'HIT' then lst.summary_value end ) as heat_input,
            max( case when lst.parameter_cd = 'SO2M' then lst.summary_value end ) as so2_mass,
			max( case when lst.parameter_cd = 'CO2M' then lst.summary_value end ) as co2_mass,
			max( case when lst.parameter_cd = 'NOXR' then lst.summary_value end ) as nox_rate,
			max( case when lst.parameter_cd = 'NOXM' then lst.summary_value end ) as nox_mass,
             lst.summary_num
        from (select smv.mon_loc_id,smv.rpt_period_id,prs.period_description,
                 smv.parameter_cd, typ.summary_num,typ.summary_type_cd,typ.summary_name,
                     case ( typ.summary_type_cd )
                         when 'QTRRPT'   THEN smv.current_rpt_period_total
                         when 'QTRCALC'  THEN smv.calc_current_rpt_period_total
                         when 'YEARRPT'  THEN smv.year_total
                         when 'YEARCALC' THEN smv.calc_year_total
                         when 'OSRPT'    THEN smv.os_total
                         when 'OSCALC'   THEN smv.calc_os_total
                      end as summary_value
			    from  camdecmpswks.SUMMARY_VALUE smv
				 join camdecmpswks.MONITOR_PLAN_LOCATION mpl on mpl.mon_loc_id=smv.mon_loc_id
						and mpl.mon_plan_id = p_mon_plan_id
						and smv.parameter_cd in ('CO2M','HIT','NOXM','NOXR','OPHOURS','OPTIME','SO2M') 
						and smv.mon_loc_id = p_loc_id
  	    	     join camdecmpswks.EMISSION_EVALUATION ems on ems.rpt_period_id =smv.rpt_period_id
						and mpl.mon_plan_id=ems.mon_plan_id 
						and smv.rpt_period_id = any( string_to_array( p_rpt_period_id, ',' )::numeric[] )
			     join camdecmpsmd.REPORTING_PERIOD prs on prs.rpt_period_id = smv.rpt_period_id
				 join (
				     select 'QTRRPT' as summary_type_cd, 'Quarterly Reported' as summary_name, 1 as summary_num union all
            		 select 'QTRCALC' as summary_type_cd, 'Quarterly Calculated' as summary_name, 2 as summary_num union all
            		 select 'YEARRPT' as summary_type_cd, 'Year to Date Reported' as summary_name, 3 as summary_num union all
            		 select 'YEARCALC' as summary_type_cd, 'Year to Date Calculated' as summary_name, 4 as summary_num union all
            		 select 'OSRPT' as summary_type_cd, 'Ozone Season Reported' as summary_name, 5 as summary_num union all
            		 select 'OSCALC' as summary_type_cd, 'Ozone Season Calculated' as summary_name, 6 as summary_num
                    ) typ
                  on null is null			
         	   ) lst
         group by lst.mon_loc_id, lst.rpt_period_id,lst.period_description,lst.summary_num, lst.summary_type_cd, lst.summary_name
        ) cmb
   order  by  period_description, summary_num;
END;
$BODY$;
