CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_ltff(IN vmonplanid character varying, IN vrptperiodid numeric)
 LANGUAGE plpgsql
AS $procedure$
BEGIN
  CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'LTFF');
END
$procedure$
