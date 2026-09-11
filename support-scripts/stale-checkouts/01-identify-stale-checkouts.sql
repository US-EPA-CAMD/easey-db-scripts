select  (  uco.checked_out_on::date <= current_date - interval '2 days' ) as stale_ind,
        uco.checked_out_on,
        uco.last_activity,
        uco.facility_id,
        uco.mon_plan_id,
        uco.checked_out_by
  from  camdecmpswks.USER_CHECK_OUT uco
 order
    by  uco.checked_out_on
;
