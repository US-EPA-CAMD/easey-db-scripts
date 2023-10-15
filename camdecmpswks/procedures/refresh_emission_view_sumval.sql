-- PROCEDURE: camdecmpswks.refresh_emission_view_sumval(character varying, numeric)

DROP PROCEDURE IF EXISTS camdecmpswks.refresh_emission_view_sumval(character varying, numeric);

CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_sumval(
	vmonplanid character varying,
	vrptperiodid numeric
)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
  CALL camdecmpswks.refresh_emission_view_count(vmonplanid, vrptperiodid, 'SUMVAL');
END
$BODY$;
