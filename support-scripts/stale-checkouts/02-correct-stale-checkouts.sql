delete
  from  camdecmpswks.USER_CHECK_OUT uco
 where  (  uco.checked_out_on::date <= current_date - interval '2 days' );

commit;
