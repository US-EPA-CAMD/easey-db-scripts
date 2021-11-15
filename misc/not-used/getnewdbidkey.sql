-- FUNCTION: camdecmpswks.getnewdbidkey(uuid)

-- DROP FUNCTION camdecmpswks.getnewdbidkey(uuid);

CREATE OR REPLACE FUNCTION camdecmpswks.getnewdbidkey(
	p_guid uuid)
    RETURNS character varying
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
DECLARE v_Newkey character varying;

BEGIN
SELECT  Left(PARAM_VALUE1, 10) || '-' || Replace( Cast(p_guid as VarChar(36) ), '-', '' )
into v_Newkey
from camdecmpsmd.SYSTEM_PARAMETER
WHERE SYS_PARAM_NAME = 'DB_SETTINGS'	  AND PARAM_NAME1='DatabasePrefix' ;

return v_Newkey;
END;
$BODY$;