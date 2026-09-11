select  mds.mats_data_sub_id,
        mds.mats_status_cd,
        mds.add_time,
        (
            select  'ORIS ' || fac.oris_code || ' (' || fac.facility_name || '), Location ' || coalesce( unt.unitid, stp.stack_name )
              from  camdecmps.MONITOR_LOCATION loc
                    left join camd.UNIT unt using ( unit_id )
                    left join camdecmps.STACK_PIPE stp using ( stack_pipe_id )
                    join camd.PLANT fac on fac.fac_id in ( unt.fac_id, stp.fac_id )
             where  loc.mon_loc_id = mds.mon_loc_id
        ) as location,
        mds.mats_rpt_type_cd,
        (
            ( select 'Report Type: "' || cod.mats_rpt_type_description || '"' from camdecmpsmd.MATS_REPORT_TYPE_CODE cod where cod.mats_rpt_type_cd = mds.mats_rpt_type_cd )
            || case when mds.mats_avg_group_cd is not null then E'\r\n' || ( select 'Averaging Group: "' || cod.mats_avg_group_description || '"' from camdecmpsmd.MATS_AVERAGING_GROUP_CODE cod where cod.mats_avg_group_cd = mds.mats_avg_group_cd ) else '' end
            || case when mds.test_number is not null then E'\r\n' || ( 'Test Number: "' || mds.test_number || '"' ) else '' end
            || case when mds.test_date is not null then E'\r\n' || ( 'Test Date: ' || mds.test_date ) else '' end
            || case when mds.test_comment is not null then E'\r\n' || ( 'Test Comment: "' || mds.test_comment || '"' ) else '' end
            || case when mds.year is not null then E'\r\n' || ( 'Quarter: ' || mds.year || ' Q' || mds.quarter ) else '' end
        ) as metadata,
        ( 
            select  'Location' || case when pln.locations like '%,%' then 's' else '' end || ': ' || pln.locations
                    || case when pln.mp_end_year is not null then ' (' || pln.mp_end_year || ' Q' || pln.mp_end_quarter || ')' else '' end
              from  camdecmps.VW_MONITOR_PLAN pln
             where  pln.mon_plan_id = mds.mon_plan_id
        ) as monitor_plan,
        mds.queued_time,
        mds.started_time,
        mds.completed_time,
        mds.note,
        mds.note_time,
        mds.mon_loc_id,
        mds.fac_id,
        mds.mon_plan_id,
        mds.user_id,
        mds.user_email,
        mds.update_time
  from  camdecmpsaux.MATS_DATA_SUBMISSION mds
 where  mds.mats_status_cd not in ( 'COMPLETE', 'ERROR' );
