-- PROCEDURE: camdecmpswks.refresh_emission_view_nsps4t(character varying, numeric)

DROP PROCEDURE IF EXISTS camdecmpswks.refresh_emission_view_nsps4t(character varying, numeric);

CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_nsps4t(
	vmonplanid character varying,
	vrptperiodid numeric
)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
  CALL camdecmpswks.refresh_emission_view_count(vmonplanid, vrptperiodid, 'NSPS4T');
END
$BODY$;
