-- FUNCTION: camdecmpswks.rpt_em_fuel_operating_hours(text, numeric)

DROP FUNCTION IF EXISTS camdecmpswks.rpt_em_fuel_operating_hours(text, numeric) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_em_fuel_operating_hours(
	monplanid text,
	vyear numeric)
    RETURNS TABLE(location character varying, "calendar_year" numeric, "period" text,"fuel_cd" character varying, "op_hours" numeric) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$

BEGIN
    RETURN QUERY
    (with lst as (
        select 
            pln.mon_plan_id, 
            prd.rpt_period_id, 
            mpl.mon_loc_id, 
            pln.fac_id, 
            prd.calendar_year, 
            prd.quarter 
        from 
            camdecmpswks.monitor_plan pln, 
            camdecmpswks.monitor_plan_location mpl, 
            camdecmpsmd.reporting_period prd 
        where 
            pln.mon_plan_id = monplanid
            and mpl.mon_plan_id = pln.mon_plan_id 
            and (vyear is null or prd.calendar_year = vyear)
    ) 
    select 
    coalesce(unt.unitid, stp.stack_name) as location, 
    cmb.calendar_year, 
    cmb.Period, 
    cmb.fuel_cd,
    cmb.Op_Hours
    from 
    (
        --
        -- Quarterly Data for the Non-Fuel-Specific and Fuel-Specific Report Report Tables
        --
        select 
        sel.mon_plan_id, 
        sel.fuel_ind, 
        sel.rpt_period_id, 
        sel.mon_loc_id, 
        prd.calendar_year, 
        ('QTR ' || prd.quarter) as Period, 
        case when sel.fuel_ind = 1 then null else coalesce(osd.fuel_cd, 'NO DATA') end as fuel_cd, 
        max(
            case when osd.op_type_cd = 'OPHOURS' then osd.Op_Value end
        ) as Op_Hours
        from 
        (
            select 
            lst.mon_plan_id, 
            lst.rpt_period_id, 
            lst.mon_loc_id, 
            ind.fuel_ind, 
            -- Indicates whether fuel specific data was reported for the location in the emission report
            max(
                case when osd.fuel_cd is null then 0 else 1 end
            ) as Fuel_Exists_Ind 
            from 
            lst 
            join (
                select 
                0 as fuel_ind
            ) ind on null is null 
            join camdecmpswks.operating_supp_data osd on osd.mon_loc_id = lst.mon_loc_id 
            and osd.rpt_period_id = lst.rpt_period_id 
            and osd.op_type_cd in (
                'BCO2', 'CO2M', 'HIT', 'NOXM', 'NOXR', 
                'OPDAYS', 'OPHOURS', 'OPTIME', 'SO2M'
            ) 
            group by 
            lst.mon_plan_id, 
            lst.rpt_period_id, 
            lst.mon_loc_id, 
            ind.fuel_ind
        ) sel 
        join camdecmpsmd.reporting_period prd on prd.rpt_period_id = sel.rpt_period_id 
        left join camdecmpswks.operating_supp_data osd on osd.mon_loc_id = sel.mon_loc_id 
        and osd.rpt_period_id = sel.rpt_period_id 
        
        
        group by 
        sel.mon_plan_id, 
        sel.fuel_ind, 
        sel.rpt_period_id, 
        sel.mon_loc_id, 
        prd.calendar_year, 
        prd.quarter, 
        osd.fuel_cd
        
    ) cmb 
    join camdecmpswks.monitor_plan pln on pln.mon_plan_id = cmb.mon_plan_id 
    join camd.plant fac on fac.fac_id = pln.fac_id 
    join camdecmpswks.monitor_location loc on loc.mon_loc_id = cmb.mon_loc_id 
    left join camd.unit unt on unt.unit_id = loc.unit_id 
    left join camdecmpswks.stack_pipe stp on stp.stack_pipe_id = loc.stack_pipe_id 
    order by 
    oris_code, 
    case when cmb.fuel_cd is null then 0 else 1 end, 
    location, 
    cmb.calendar_year, 
    cmb.Period, 
    cmb.fuel_cd
    );
END;
$BODY$;