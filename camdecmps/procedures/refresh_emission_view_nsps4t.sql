-- PROCEDURE: camdecmps.refresh_emission_view_nsps4t(character varying, numeric)

DROP PROCEDURE IF EXISTS camdecmps.refresh_emission_view_nsps4t(character varying, numeric);

CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_nsps4t(
	vmonplanid character varying,
	vrptperiodid numeric
)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
  CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'NSPS4T');
END
$BODY$;
