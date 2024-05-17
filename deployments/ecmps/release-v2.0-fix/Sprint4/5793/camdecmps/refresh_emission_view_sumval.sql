CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_sumval(IN vmonplanid character varying, IN vrptperiodid numeric)
 LANGUAGE plpgsql
AS $procedure$
BEGIN
  CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'SUMVAL');
END
$procedure$
