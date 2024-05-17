CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_sumval(IN vmonplanid character varying, IN vrptperiodid numeric)
 LANGUAGE plpgsql
AS $procedure$
BEGIN
  CALL camdecmpswks.refresh_emission_view_count(vmonplanid, vrptperiodid, 'SUMVAL');
END
$procedure$
