update camdecmpsaux.em_submission_access esa 
set sub_availability_cd = 'REQUIRE', update_date = now()
where rpt_period_id = [replace with correct rpt_period_id]
and sub_availability_cd is null
and em_status_cd = 'APPRVD';