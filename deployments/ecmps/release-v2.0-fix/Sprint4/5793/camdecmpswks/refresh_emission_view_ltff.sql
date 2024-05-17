CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_ltff(IN vmonplanid character varying, IN vrptperiodid numeric)
 LANGUAGE plpgsql
AS $procedure$
BEGIN
  CALL camdecmpswks.refresh_emission_view_count(vmonplanid, vrptperiodid, 'LTFF');
END
$procedure$
