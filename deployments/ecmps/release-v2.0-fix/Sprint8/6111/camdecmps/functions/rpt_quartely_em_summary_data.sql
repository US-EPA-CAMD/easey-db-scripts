-- FUNCTION: camdecmps.rpt_quartely_em_summary_data(text, numeric)

DROP FUNCTION IF EXISTS camdecmps.rpt_quartely_em_summary_data(text, numeric) CASCADE;

CREATE OR REPLACE FUNCTION camdecmps.rpt_quartely_em_summary_data(
	monplanid text,
	vyear numeric)
    RETURNS TABLE(location character varying, "calendar_year" numeric, "period" text, "op_hours" numeric, "op_days" numeric, "op_time" numeric, "hit" numeric, "so2m" numeric, "co2m" numeric, "noxr" numeric, "noxm" numeric, "bco2" numeric) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
DECLARE 
    monLocIds character varying[];

BEGIN
    RETURN QUERY
    (with lst as
        (
            select  pln.mon_plan_id,
                    prd.rpt_period_id,
                    mpl.mon_loc_id,
                    pln.fac_id,
                    prd.calendar_year,
                    prd.quarter
            from  camdecmps.monitor_plan pln,
                    camdecmps.monitor_plan_location mpl,
                    camdecmpsmd.reporting_period prd
            where  pln.mon_plan_id = monplanid
            and  mpl.mon_plan_id  = pln.mon_plan_id
            and  (vyear is null or prd.calendar_year = vyear)
        )
        select
                coalesce( unt.unitid, stp.stack_name) as location,
                cmb.calendar_year,
                cmb.Period,
                cmb.Op_Hours,
                cmb.Op_Days,
                cmb.Op_Time,
                cmb.Hit,
                cmb.So2m,
                cmb.Co2m,
                cmb.Noxr,
                cmb.Noxm,
                cmb.Bco2
        from  (
                    --
                    -- Quarterly Data for the Non-Fuel-Specific and Fuel-Specific Report Report Tables
                    --
                    select  sel.mon_plan_id,
                            sel.fuel_ind,
                            sel.rpt_period_id,
                            sel.mon_loc_id,
                            prd.calendar_year,
                            ( 'QTR ' || prd.quarter ) as Period,
                            case 
                                when sel.fuel_ind = 0
                                then null
                                else coalesce( osd.fuel_cd, 'NO DATA' )
                            end as fuel_cd,
                            max( case when osd.op_type_cd = 'OPHOURS'   then osd.Op_Value end ) as Op_Hours,
                            max( case when osd.op_type_cd = 'OPDAYS'    then osd.Op_Value end ) as Op_Days,
                            max( case when osd.op_type_cd = 'OPTIME'    then osd.Op_Value end ) as Op_Time,
                            max( case when osd.op_type_cd = 'HIT'       then osd.Op_Value end ) as Hit,
                            max( case when osd.op_type_cd = 'SO2M'      then osd.Op_Value end ) as So2m,
                            max( case when osd.op_type_cd = 'CO2M'      then osd.Op_Value end ) as Co2m,
                            max( case when osd.op_type_cd = 'NOXR'      then osd.Op_Value end ) as Noxr,
                            max( case when osd.op_type_cd = 'NOXM'      then osd.Op_Value end ) as Noxm,
                            max( case when osd.op_type_cd = 'BCO2'      then osd.Op_Value end ) as Bco2
                    from  (
                                select  lst.mon_plan_id,
                                        lst.rpt_period_id,
                                        lst.mon_loc_id,
                                        ind.fuel_ind,
                                        -- Indicates whether fuel specific data was reported for the location in the emission report
                                        max(case when osd.fuel_cd is null then 0 else 1 end) as Fuel_Exists_Ind
                                from  lst
                                        join (select 0 as fuel_ind) ind
                                        on null is null
                                        join camdecmps.operating_supp_data osd
                                        on osd.mon_loc_id = lst.mon_loc_id
                                        and osd.rpt_period_id = lst.rpt_period_id
                                        and osd.op_type_cd in ( 'BCO2', 'CO2M', 'HIT', 'NOXM', 'NOXR', 'OPDAYS', 'OPHOURS', 'OPTIME', 'SO2M' )
                                group
                                    by  lst.mon_plan_id,
                                        lst.rpt_period_id,
                                        lst.mon_loc_id,
                                        ind.fuel_ind
                            ) sel
                            join camdecmpsmd.reporting_period prd
                            on prd.rpt_period_id = sel.rpt_period_id
                            left join camdecmps.operating_supp_data osd
                            on osd.mon_loc_id = sel.mon_loc_id
                            and osd.rpt_period_id = sel.rpt_period_id
                            and osd.op_type_cd in ( 'BCO2', 'CO2M', 'HIT', 'NOXM', 'NOXR', 'OPDAYS', 'OPHOURS', 'OPTIME', 'SO2M' )
                            and (
                                    -- Gets non fuel specific data for non fuel rows
                                    sel.fuel_ind = 0 and osd.fuel_cd is null
                                    or
                                    -- Gets Op Hours for fuel rows when no fuel specific data exists for the emission report
                                    sel.fuel_ind = 1 and sel.Fuel_Exists_Ind = 0 and osd.op_type_cd = 'OPHOURS'
                                    or
                                    -- Gets fuel specirfic data for fuel rows
                                    sel.fuel_ind = 1 and osd.fuel_cd is not null
                                )
                    group
                        by  sel.mon_plan_id,
                            sel.fuel_ind,
                            sel.rpt_period_id,
                            sel.mon_loc_id,
                            prd.calendar_year,
                            prd.quarter,
                            osd.fuel_cd
                    union   all
                    --
                    -- Ozone-Season-to-Date Data for the Non-Fuel-Specific Report Tables
                    --
                    select  lst.mon_plan_id,
                            0 as fuel_ind,
                            null as rpt_period_id,
                            lst.mon_loc_id,
                            lst.calendar_year,
                            ( 'Ozone Season To Date' ) as Period,
                            osd.fuel_cd,
                            sum( case when osd.op_type_cd in ( 'OPHOURS', 'OSHOURS' )   then osd.Op_Value end ) as Op_Hours,
                            null as Op_Days,
                            sum( case when osd.op_type_cd in ( 'OPTIME', 'OSTIME')      then osd.Op_Value end ) as Op_Time,
                            sum( case when osd.op_type_cd in ( 'HIT', 'HITOS' )         then osd.Op_Value end ) as Hit,
                            null as So2m,
                            null as Co2m,
                            null as Noxr,
                            sum( case when osd.op_type_cd in ( 'NOXM', 'NOXMOS' )       then osd.Op_Value end ) as Noxm,
                            null as Bco2
                    from  lst
                            join camdecmps.operating_supp_data osd
                            on osd.mon_loc_id = lst.mon_loc_id
                            and osd.rpt_period_id = lst.rpt_period_id
                            and osd.fuel_cd is null
                            join camdecmpsmd.reporting_period prd
                            on prd.rpt_period_id = osd.rpt_period_id
                            and prd.quarter in ( 2, 3 )
                    where  case 
                                when prd.quarter = 2 and osd.op_type_cd in ( 'HITOS', 'NOXMOS', 'OSHOURS', 'OSTIME' ) then 1
                                when prd.quarter = 3 and osd.op_type_cd in ( 'HIT', 'NOXM', 'OPHOURS', 'OPTIME' ) then 1
                                else 0
                            end = 1
                            -- Ensure that the location had an active ozone season program during Op Supp Data quarter.
                    and  exists
                            (
                                select  1
                                from  (
                                            select  loc.mon_loc_id,
                                                    unp.Prg_Cd,
                                                    unp.Class_Cd,
                                                    case
                                                        when usc.Begin_Date is null
                                                            then unp.Unit_Monitor_Cert_Begin_Date
                                                        when unp.Unit_Monitor_Cert_Begin_Date is null
                                                            then usc.Begin_Date
                                                        when unp.Unit_Monitor_Cert_Begin_Date >= usc.Begin_Date
                                                            then unp.Unit_Monitor_Cert_Begin_Date
                                                        else usc.Begin_Date
                                                    end as Unit_Monitor_Cert_Begin_Date,
                                                    case
                                                        when usc.End_Date is null
                                                            then unp.End_Date
                                                        when unp.End_Date is null
                                                            then usc.End_Date
                                                        when unp.End_Date <= usc.End_Date
                                                            then unp.End_Date
                                                        else usc.End_Date
                                                    end as End_Date
                                            from  camdecmps.monitor_location loc
                                                    left join camdecmps.unit_stack_configuration usc
                                                    on usc.stack_pipe_id = loc.stack_pipe_id
                                                    left join camdecmps.stack_pipe stp
                                                    on stp.stack_pipe_id = loc.stack_pipe_id
                                                    join camd.unit_program unp
                                                    on unp.unit_id = coalesce( loc.unit_id, usc.unit_id )
                                                    join camdmd.program_code prc
                                                    on prc.prg_cd = unp.prg_cd
                                                    and prc.os_ind = 1
                                            where  loc.mon_loc_id = lst.mon_loc_id
                                        ) sub
                                where  sub.Unit_Monitor_Cert_Begin_Date <= to_date( prd.calendar_year || '-09-30', 'yyyy-mm-dd' )
                                and  coalesce( sub.End_Date, to_date( '9999-12-31', 'yyyy-mm-dd' ) ) >= to_date( prd.calendar_year || '-05-01', 'yyyy-mm-dd' )
                            )
                            -- Ensure that the OPERATING_SUPP_DATA quarter is after the "first" ozone quarter (usually 2) for the location and year.
                    and  exists
                            (
                                select  1
                                from   (
                                            select  dat.mon_loc_id,
                                                    (
                                                        select  case
                                                                    when sub.calendar_year = lst.calendar_year then
                                                                        case
                                                                            when sub.quarter < 2
                                                                            then 2
                                                                            else sub.quarter
                                                                        end
                                                                    else 2
                                                                end
                                                        from  camdecmpsmd.reporting_period sub
                                                        where  sub.Begin_Date = dat.First_Begin_Date
                                                    ) as First_Quarter
                                            from  (
                                                        select  mpl.mon_loc_id,
                                                                min( prd.Begin_Date ) as First_Begin_Date
                                                        from  camdecmps.monitor_plan_location mpl
                                                                join camdecmps.monitor_plan pln
                                                                on pln.mon_plan_id = mpl.mon_plan_id
                                                                join camdecmpsmd.reporting_period prd
                                                                on prd.rpt_period_id = pln.Begin_Rpt_Period_Id
                                                        where  mpl.mon_loc_id = lst.mon_loc_id
                                                        group
                                                            by  mpl.mon_loc_id
                                                    ) dat
                                        ) agg
                                where  ( agg.First_Quarter <= prd.quarter )
                            )
                    group
                        by  lst.mon_plan_id,
                            lst.mon_loc_id,
                            lst.calendar_year,
                            osd.fuel_cd
                    union   all
                    --
                    -- Year-to-Date Data for the Non-Fuel-Specific Report Tables
                    --
                    select  lst.mon_plan_id,
                            0 as fuel_ind,
                            null as rpt_period_id,
                            mpl.mon_loc_id,
                            prd.calendar_year,
                            ( 'Year To Date' ) as Period,
                            osd.fuel_cd,
                            sum( case when osd.op_type_cd = 'OPHOURS'   then osd.Op_Value end ) as Op_Hours,
                            sum( case when osd.op_type_cd = 'OPDAYS'    then osd.Op_Value end ) as Op_Days,
                            sum( case when osd.op_type_cd = 'OPTIME'    then osd.Op_Value end ) as Op_Time,
                            sum( case when osd.op_type_cd = 'HIT'       then osd.Op_Value end ) as Hit,
                            sum( case when osd.op_type_cd = 'SO2M'      then osd.Op_Value end ) as So2m,
                            sum( case when osd.op_type_cd = 'CO2M'      then osd.Op_Value end ) as Co2m,
                            max
                            ( 
                                case
                                    when osd.op_type_cd = 'NOXRYTD' then
                                    (
                                        select  (
                                                    select  max( osd_sub.Op_Value )
                                                    from  camdecmps.operating_supp_data osd_sub
                                                            join camdecmpsmd.reporting_period prd_sub
                                                            on prd_sub.rpt_period_id = osd_sub.rpt_period_id
                                                    where  osd_sub.mon_loc_id = sub.mon_loc_id
                                                    and  prd_sub.calendar_year = sub.calendar_year
                                                    and  prd_sub.quarter = sub.quarter
                                                    and  osd_sub.op_type_cd = 'NOXRYTD'
                                                )
                                        from  (
                                                    select  osd.mon_loc_id,
                                                            prd.calendar_year,
                                                            max( prd.quarter ) as quarter
                                                    from  camdecmps.operating_supp_data osd
                                                            join camdecmpsmd.reporting_period prd
                                                            on prd.rpt_period_id = osd.rpt_period_id
                                                    where  osd.mon_loc_id = lst.mon_loc_id
                                                    and  prd.calendar_year = lst.calendar_year
                                                    group
                                                        by  osd.mon_loc_id,
                                                            prd.calendar_year
                                                ) sub
                                )
                                end
                            ) as Noxr,
                            sum( case when osd.op_type_cd = 'NOXM'      then osd.Op_Value end ) as Noxm,
                            sum( case when osd.op_type_cd = 'BCO2'      then osd.Op_Value end ) as Bco2
                    from  lst
                            join camdecmpsmd.reporting_period prd
                            on prd.rpt_period_id = lst.rpt_period_id
                            join camdecmps.monitor_plan pln
                            on pln.Fac_Id = lst.Fac_Id
                            join camdecmps.emission_evaluation ems
                            on ems.mon_plan_id = pln.mon_plan_id
                            and ems.rpt_period_id = prd.rpt_period_id
                            join camdecmps.monitor_plan_location mpl
                            on mpl.mon_plan_id = pln.mon_plan_id
                            and mpl.mon_loc_id = lst.mon_loc_id
                            join camdecmps.operating_supp_data osd
                            on  osd.mon_loc_id = mpl.mon_loc_id
                            and  osd.rpt_period_id = prd.rpt_period_id
                            and  osd.op_type_cd in ( 'BCO2', 'CO2M', 'HIT', 'NOXM', 'NOXRYTD', 'OPDAYS', 'OPHOURS', 'OPTIME', 'SO2M' )
                            and  osd.fuel_cd is null
                            join camdecmps.monitor_plan_reporting_freq frq
                            on frq.mon_plan_id = pln.mon_plan_id
                            and frq.Report_Freq_Cd = 'Q'
                            join camdecmpsmd.reporting_period prb
                            on prb.rpt_period_id = frq.Begin_Rpt_Period_Id
                            left join camdecmpsmd.reporting_period pre
                            on pre.rpt_period_id = frq.End_Rpt_Period_Id
                    where  prb.calendar_year <= prd.calendar_year
                    and  coalesce( pre.calendar_year, 9999 ) >= prd.calendar_year
                    group
                        by  lst.mon_plan_id,
                            mpl.mon_loc_id,
                            prd.calendar_year,
                            osd.fuel_cd
                ) cmb
                join camdecmps.monitor_plan pln
                on pln.mon_plan_id = cmb.mon_plan_id
                join camd.plant fac
                on fac.fac_id = pln.fac_id 
                join camdecmps.monitor_location loc
                on loc.mon_loc_id = cmb.mon_loc_id
                left join camd.unit unt
                on unt.unit_id = loc.unit_id
                left join camdecmps.stack_pipe stp
                on stp.stack_pipe_id = loc.stack_pipe_id
        order
            by  oris_code,
                case when  cmb.fuel_cd is null then 0 else 1 end,
                location,
                cmb.calendar_year,
                case when cmb.Period = 'Ozone Season To Date' then 1 when cmb.Period = 'Year To Date' then 2 else 0 end,
                cmb.Period,
                cmb.fuel_cd
    );
END;
$BODY$;