
----------------------------------------------------------------
-- Replace the date range in the where clause near the bottom --
----------------------------------------------------------------

select  dat.mp_exists,
        dat.qa_exists,
        dat.em_count,
        -- QA Min and Max Counts
        min( dat.qa_count ) as qa_count_min,
        max( dat.qa_count ) as qa_count_max,
        -- Submission Set Count
        count(1) as submission_set_count,
        -- Run Duration
        sum(case when dat.run_seconds <=  5                          then 1 else 0 end) as run_le_5,
        sum(case when dat.run_seconds <= 10 and dat.run_seconds >  5 then 1 else 0 end) as run_le_10,
        sum(case when dat.run_seconds <= 30 and dat.run_seconds > 10 then 1 else 0 end) as run_le_30,
        sum(case when dat.run_seconds <= 60 and dat.run_seconds > 30 then 1 else 0 end) as run_le_60,
        sum(case when                           dat.run_seconds > 60 then 1 else 0 end) as run_gt_60,
        min(dat.run_seconds) as run_seconds_min,
        round(avg(dat.run_seconds)) as run_seconds_avg,
        max(dat.run_seconds) as run_seconds_max,
        -- Wait Duration
        sum(case when dat.wait_seconds <=  5                           then 1 else 0 end) as wait_le_5,
        sum(case when dat.wait_seconds <= 10 and dat.wait_seconds >  5 then 1 else 0 end) as wait_le_10,
        sum(case when dat.wait_seconds <= 30 and dat.wait_seconds > 10 then 1 else 0 end) as wait_le_30,
        sum(case when dat.wait_seconds <= 60 and dat.wait_seconds > 30 then 1 else 0 end) as wait_le_60,
        sum(case when                            dat.wait_seconds > 60 then 1 else 0 end) as wait_gt_60,
        min(dat.wait_seconds) as wait_seconds_min,
        round(avg(dat.wait_seconds)) as wait_seconds_avg,
        max(dat.wait_seconds) as wait_seconds_max,
        -- Total Duration
        sum(case when dat.total_seconds <=  15                             then 1 else 0 end) as total_le_15,
        sum(case when dat.total_seconds <=  30 and dat.total_seconds >  15 then 1 else 0 end) as total_le_30,
        sum(case when dat.total_seconds <=  60 and dat.total_seconds >  30 then 1 else 0 end) as total_le_60,
        sum(case when dat.total_seconds <= 120 and dat.total_seconds >  60 then 1 else 0 end) as total_le_120,
        sum(case when                              dat.total_seconds > 120 then 1 else 0 end) as total_gt_120,
        min(dat.total_seconds) as total_seconds_min,
        round(avg(dat.total_seconds)) as total_seconds_avg,
        max(dat.total_seconds) as total_seconds_max,
        -- Earliest Start Date
        to_char(min(dat.started_time), 'mm/dd/yyyy') as run_min_start_date
  from  (
            select  sbs.submission_set_id,
                    sbs.queued_time,
                    sbs.started_time,
                    sbs.completed_time,
                    ( sbs.completed_time  - sbs.started_time ) as run_duration,
                    extract( epoch from ( sbs.completed_time  - sbs.started_time ) ) as run_seconds,
                    ( sbs.started_time  - sbs.queued_time ) as wait_duration,
                    extract( epoch from ( sbs.started_time  - sbs.queued_time ) ) as wait_seconds,
                    ( sbs.completed_time  - sbs.queued_time ) as total_duration,
                    extract( epoch from ( sbs.completed_time  - sbs.queued_time ) ) as total_seconds,
                    exists
                    (
                        select  1
                          from  camdecmpsaux.SUBMISSION_QUEUE sbq
                         where  sbq.submission_set_id = sbs.submission_set_id
                           and  sbq.process_cd = 'MP'
                    ) as mp_exists,
                    exists
                    (
                        select  1
                          from  camdecmpsaux.SUBMISSION_QUEUE sbq
                         where  sbq.submission_set_id = sbs.submission_set_id
                           and  sbq.process_cd = 'QA'
                    ) as qa_exists,
                    (
                        select  count(1)
                          from  camdecmpsaux.SUBMISSION_QUEUE sbq
                         where  sbq.submission_set_id = sbs.submission_set_id
                           and  sbq.process_cd = 'QA'
                    ) as qa_count,
                    (
                        select  count(1)
                          from  camdecmpsaux.SUBMISSION_QUEUE sbq
                         where  sbq.submission_set_id = sbs.submission_set_id
                           and  sbq.process_cd = 'EM'
                    ) as Em_Count
              from  camdecmpsaux.SUBMISSION_SET sbs
             where  sbs.queued_time::date between '2026-04-01' and '2026-04-30' /* REPLACE DATE RANGE */
               and  sbs.status_cd = 'COMPLETE'
        ) dat
 group
    by  dat.mp_exists,
        dat.em_count,
        dat.qa_exists
 order
    by  ( case when dat.mp_exists then 1 else 0 end + dat.em_count + case when dat.qa_exists then 1 else 0 end ),
        dat.mp_exists desc,
        dat.qa_exists desc,
        dat.em_count desc;
