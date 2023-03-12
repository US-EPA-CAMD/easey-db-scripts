CREATE OR REPLACE 
FUNCTION camdecmpswks.noxr_summary_required_for_lme_annual
(
	monPlanId       character varying,
	rptPeriodId     numeric
)
    RETURNS TABLE   (
                        mon_plan_id             character varying,
                        rpt_period_id           numeric,
                        mon_loc_id              character varying,
                        location_name           character varying,
                        calendar_year           numeric,  
                        quarter                 numeric,  
                        lme_noxr_summary_ind    integer,
                        lme_noxr_begin          timestamp without time zone
                    ) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN  
    RETURN QUERY
    select  dat.MON_PLAN_ID,
            dat.RPT_PERIOD_ID,
            dat.MON_LOC_ID,
            dat.LOCATION_NAME,
            dat.CALENDAR_YEAR,
            dat.QUARTER,
            case
                when dat.NOXM_IND = 1 then 1
                when dat.NOXR_IND = 1 then 1
                when dat.MS_CONFIG_IND = 1 and dat.MS_NOXR_IND = 1 then 1
                else 0 
            end LME_NOXR_SUMMARY_IND,
            case
                when dat.NOXM_IND = 1 or dat.NOXR_IND = 1 then dat.NOXR_NOXM_BEGIN
                when dat.MS_CONFIG_IND = 1 and dat.MS_NOXR_IND = 1 then dat.MS_NOXR_BEGIN
            end LME_NOXR_BEGIN
      from  (
                /* For each location and quarter, determine whether the configruation is a MS configuration. */
                select  fin.MON_PLAN_ID,
                        fin.RPT_PERIOD_ID,
                        fin.MON_LOC_ID,
                        coalesce(unt.Unitid, stp.Stack_Name) LOCATION_NAME,
                        fin.CALENDAR_YEAR,
                        fin.QUARTER,
                        case when fin.UN_CNT = 1 and fin.CS_CNT = 0 and fin.CP_CNT = 0 and fin.MS_CNT > 1 and fin.MP_CNT = 0 then 1 else 0 end MS_CONFIG_IND,
                        fin.NOXM_IND,
                        fin.NOXR_IND,
                        fin.NOXR_NOXM_BEGIN,
                        fin.MS_NOXR_IND,
                        fin.MS_NOXR_BEGIN
                  from  (
                            /* For each location and quarter, determine the count of location types.  This must occur after aggregating method information to 
                               prevent double counting. */
                            select  agg.MON_PLAN_ID,
                                    agg.RPT_PERIOD_ID,
                                    agg.MON_LOC_ID,
                                    agg.CALENDAR_YEAR,
                                    agg.QUARTER,
                                    max(agg.NOXM_IND) NOXM_IND,
                                    max(agg.NOXR_IND) NOXR_IND,
                                    min(agg.NOXR_NOXM_BEGIN) NOXR_NOXM_BEGIN,
                                    max(agg.MS_NOXR_IND) MS_NOXR_IND,
                                    min(agg.MS_NOXR_BEGIN) MS_NOXR_BEGIN,
                                    sum(case when agg.LOCATION_TYPE_CD = 'UN' then 1 else 0 end) UN_CNT,
                                    sum(case when agg.LOCATION_TYPE_CD = 'CS' then 1 else 0 end) CS_CNT,
                                    sum(case when agg.LOCATION_TYPE_CD = 'CP' then 1 else 0 end) CP_CNT,
                                    sum(case when agg.LOCATION_TYPE_CD = 'MS' then 1 else 0 end) MS_CNT,
                                    sum(case when agg.LOCATION_TYPE_CD = 'MP' then 1 else 0 end) MP_CNT
                              from  (
                                        /* For each location and quarter, determine whether a NOXM or MOXR method exists at the location, and whether NOXR method exists 
                                           at a MS for the quarter. */
                                        select  cor.MON_PLAN_ID,
                                                cor.RPT_PERIOD_ID,
                                                cor.MON_LOC_ID,
                                                cor.CALENDAR_YEAR,
                                                cor.QUARTER,
                                                cor.METH_LOC_ID,
                                                cor.LOCATION_TYPE_CD,
                                                max(case when cor.METH_LOC_ID = cor.MON_LOC_ID and cor.PARAMETER_CD = 'NOXM' then 1 else 0 end) NOXM_IND,
                                                max(case when cor.METH_LOC_ID = cor.MON_LOC_ID and cor.PARAMETER_CD = 'NOXR' then 1 else 0 end) NOXR_IND,
                                                min(case when cor.METH_LOC_ID = cor.MON_LOC_ID and cor.PARAMETER_CD in ('NOXM', 'NOXR') then cor.METHOD_BEGIN end) NOXR_NOXM_BEGIN,
                                                max(case when cor.LOCATION_TYPE_CD = 'MS' and cor.PARAMETER_CD = 'NOXR' then 1 else 0 end) MS_NOXR_IND,
                                                min(case when cor.LOCATION_TYPE_CD = 'MS' and cor.PARAMETER_CD = 'NOXR' then cor.METHOD_BEGIN end)MS_NOXR_BEGIN
                                          from  (
                                                    /* Determine the other MP to which each location belongs and get the locations and method information for those locations. */
                                                    select  sel.MON_PLAN_ID,
                                                            sel.RPT_PERIOD_ID,
                                                            sel.MON_LOC_ID,
                                                            sel.CALENDAR_YEAR,
                                                            prd.QUARTER,
                                                            mth.MON_LOC_ID METH_LOC_ID,
                                                            camdecmpswks.DATE_ADD('hour', mth.BEGIN_HOUR, mth.BEGIN_DATE) METHOD_BEGIN,
                                                            case when loc.UNIT_ID is not null then 'UN' else substring(stp.STACK_NAME, 1, 2) end LOCATION_TYPE_CD,
                                                            mth.PARAMETER_CD,
                                                            mth.METHOD_CD
                                                      from  (
                                                                /* Determine the emission report(s) to include and return them with the associated locations. */
                                                                select  prd.RPT_PERIOD_ID,
                                                                        ems.MON_PLAN_ID,
                                                                        mpl.MON_LOC_ID,
                                                                        prd.CALENDAR_YEAR,
                                                                        prd.QUARTER
                                                                  from  (
                                                                            /* Provides the core selection criteria. */
                                                                            select monPlanId MON_PLAN_ID, rptPeriodId RPT_PERIOD_ID
                                                                        ) sel
                                                                        join camdecmpswks.EMISSION_EVALUATION ems on (sel.MON_PLAN_ID is null or ems.MON_PLAN_ID = sel.MON_PLAN_ID) and (sel.RPT_PERIOD_ID is null or ems.RPT_PERIOD_ID = sel.RPT_PERIOD_ID)
                                                                        join camdecmpsmd.REPORTING_PERIOD prd on prd.RPT_PERIOD_ID = ems.RPT_PERIOD_ID
                                                                        join camdecmpswks.MONITOR_PLAN_LOCATION mpl on mpl.MON_PLAN_ID = ems.MON_PLAN_ID
                                                                        join camdecmpswks.MONITOR_LOCATION loc on loc.MON_LOC_ID = mpl.MON_LOC_ID
                                                            ) sel
                                                            join camdecmpsmd.REPORTING_PERIOD prd on prd.CALENDAR_YEAR = sel.CALENDAR_YEAR and prd.QUARTER <= sel.QUARTER
                                                            join camdecmpswks.MONITOR_PLAN_LOCATION lnk on lnk.MON_LOC_ID = sel.MON_LOC_ID
                                                            join camdecmpswks.MONITOR_PLAN pln on pln.MON_PLAN_ID = lnk.MON_PLAN_ID
                                                            join camdecmpsmd.REPORTING_PERIOD prb on prb.RPT_PERIOD_ID = pln.BEGIN_RPT_PERIOD_ID
                                                            join camdecmpsmd.REPORTING_PERIOD pre on pln.END_RPT_PERIOD_ID is null and pre.CALENDAR_YEAR = sel.CALENDAR_YEAR and pre.QUARTER = 4 or pre.RPT_PERIOD_ID = pln.END_RPT_PERIOD_ID
                                                            join camdecmpswks.MONITOR_PLAN_LOCATION mpl on mpl.MON_PLAN_ID = pln.MON_PLAN_ID
                                                            join camdecmpswks.MONITOR_LOCATION loc on loc.MON_LOC_ID = mpl.MON_LOC_ID
                                                            left join camd.UNIT unt on unt.UNIT_ID = loc.UNIT_ID
                                                            left join camdecmpswks.STACK_PIPE stp on stp.STACK_PIPE_ID = loc.STACK_PIPE_ID
                                                            left join camdecmpswks.MONITOR_METHOD mth on mth.MON_LOC_ID  = mpl.MON_LOC_ID and mth.BEGIN_DATE <= prd.END_DATE and coalesce(mth.END_DATE, prd.END_DATE) >= prd.BEGIN_DATE
                                                ) cor
                                         group
                                            by  cor.MON_PLAN_ID,
                                                cor.RPT_PERIOD_ID,
                                                cor.MON_LOC_ID,
                                                cor.CALENDAR_YEAR,
                                                cor.QUARTER,
                                                cor.METH_LOC_ID,
                                                cor.LOCATION_TYPE_CD
                                    ) agg
                             group
                                by  agg.MON_PLAN_ID,
                                    agg.RPT_PERIOD_ID,
                                    agg.MON_LOC_ID,
                                    agg.CALENDAR_YEAR,
                                    agg.QUARTER
                        ) fin
                        join camdecmpswks.MONITOR_LOCATION loc on loc.MON_LOC_ID = fin.MON_LOC_ID
                        left join camd.UNIT unt on unt.UNIT_ID = loc.UNIT_ID
                        left join camdecmpswks.STACK_PIPE stp on stp.STACK_PIPE_ID = loc.STACK_PIPE_ID
            ) dat;

END;
$BODY$;