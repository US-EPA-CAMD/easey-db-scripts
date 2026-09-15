select  pdm.status_cd,
        count( 1 ) as row_count,
        min( pdm.queued_time ) as min_queued_time,
        max( pdm.queued_time ) as max_queued_time
  from  camdecmpsaux.PDEM_REPORT pdm
 group
    by  pdm.status_cd
 order
    by  case ( pdm.status_cd )
            when 'WIP' then 1
            when 'QUEUED' then 2
            when 'FAILED' then 3
            when 'COMPLETE' then 4
            else 0
        end,
        pdm.status_cd
;
