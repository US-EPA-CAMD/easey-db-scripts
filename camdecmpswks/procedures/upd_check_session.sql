-- PROCEDURE: camdecmpswks.upd_check_session()

DROP PROCEDURE IF EXISTS camdecmpswks.upd_check_session();

CREATE OR REPLACE PROCEDURE camdecmpswks.upd_check_session(
	)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    v_result text;
	v_error_msg  text;
	v_severity_cd  text;
BEGIN
    v_result := 't';
    v_error_msg := 'check session entry successfully updated.';

    if v_severity_cd is null or v_severity_cd = '' 
    then
        v_severity_cd := 'none';
    end if;

    update check_session
    set session_end_date = v_session_end_date,
		session_comment = v_session_comment,
		severity_cd = v_severity_cd,
		eval_score_cd = -2,
		updated_status_flg = 'y',
		last_updated = current_date
		where chk_session_id = v_chk_session_id;
exception when others then
    get stacked diagnostics v_error_msg := message_text;
    v_result = 'f';
END;
$BODY$;
