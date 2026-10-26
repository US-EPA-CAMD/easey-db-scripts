/*
    NEEDED UPDATE:
    
    Add a call to camdecmpswks.UPDATE_COLLATERAL_EM_DATA_FOR_ESA_CHANGES( vmonplanid character varying, vrptperiodid integer ) 
    - Possibly reading the affected ESA MP into an array before the update below occurs, and then using the array of MP and the RPT_PERIOD_ID to call the SF in a loop.
*/
update camdecmpsaux.em_submission_access esa 
set sub_availability_cd = 'REQUIRE', update_date = now()
where rpt_period_id = [replace with correct rpt_period_id]
and sub_availability_cd is null
and em_status_cd = 'APPRVD';