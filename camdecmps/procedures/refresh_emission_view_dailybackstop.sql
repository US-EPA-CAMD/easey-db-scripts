-- PROCEDURE: camdecmps.refresh_emission_view_dailybackstop(character varying, numeric)

DROP PROCEDURE IF EXISTS camdecmps.refresh_emission_view_dailybackstop(character varying, numeric);

CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_dailybackstop(
	vmonplanid character varying,
	vrptperiodid numeric
)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
  CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'DAILYBACKSTOP');
END
$BODY$;
