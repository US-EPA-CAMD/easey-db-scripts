-- FUNCTION: camdecmpswks.rpt_get_facility_header(character varying, numeric)

-- DROP FUNCTION camdecmpswks.rpt_get_facility_header(character varying, numeric);

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_get_facility_header(
	v_fac_name character varying,
	v_oris_code numeric)
    RETURNS character varying
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
DECLARE v_FacilityHeader character varying (77);

BEGIN
SELECT ( CASE WHEN v_FAC_NAME IS NULL THEN NULL 
		  ELSE 'Facility Name: ' || v_FAC_NAME ||'  Facility ID (ORISPL): ' 
		|| CAST(v_ORIS_CODE AS VARCHAR(6)) END )
   into v_FacilityHeader;
return v_FacilityHeader;
END;
$BODY$;