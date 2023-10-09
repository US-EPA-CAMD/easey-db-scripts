-- PROCEDURE: camdecmpswks.refresh_emission_view_dailybackstop(character varying, numeric)

DROP PROCEDURE IF EXISTS camdecmpswks.refresh_emission_view_dailybackstop(character varying, numeric);

CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_dailybackstop(
	vmonplanid character varying,
	vrptperiodid numeric
)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
  CALL camdecmpswks.refresh_emission_view_count(vmonplanid, vrptperiodid, 'DAILYBACKSTOP');
END
$BODY$;
