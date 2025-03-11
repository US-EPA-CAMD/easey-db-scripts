DROP FUNCTION IF EXISTS GET_QUARTERLY_EM_SUBMISSION_WINDOWS_REPORT_DATA(numeric, character varying, character varying, numeric, numeric) CASCADE;

CREATE OR REPLACE FUNCTION GET_QUARTERLY_EM_SUBMISSION_WINDOWS_REPORT_DATA(
    V_FAC_ID            numeric,
    V_FACILITY_NAME     character varying,
    V_SUBMISSION_STATUS character varying,
    V_YEAR              numeric,
    V_QUARTER           numeric
)
RETURNS TABLE (
    ORIS_CODE                       character varying,
    FACILITY_NAME                   character varying,
    STATE                           character varying,
    LOCATIONS                       character varying,
    PERIOD                          numeric,
    ACCESS_BEGIN_DATE               date,
    ACCESS_END_DATE                 date,
    EM_SUB_TYPE_CD_DESCRIPTION      character varying,
    WINDOW_STATUS                   character varying,
    LAST_WINDOW                     character varying,
    SUBMISSION_STATUS               character varying,
    USERID                          character varying, 
    ACCEPTED_SUBMISSION_IN_PERIOD   character varying, 
    LAST_WINDOW_WITH_OK_SUBMISSION  character varying,
    SUBMISSION_ID                   bigint,
    SUBMISSION_DATE                 date,
    SEVERITY_CD_DESCRIPTION         character varying,
    SUBMITTER_USER_ID               character varying
) AS $BODY$
DECLARE
    V_RPT_PERIOD_ID numeric;
BEGIN
    SELECT RPT_PERIOD_ID
      INTO V_RPT_PERIOD_ID
      FROM camdecmpsmd.reporting_period
     WHERE calendar_year = V_YEAR
       AND quarter = V_QUARTER;
       
    RETURN QUERY
    SELECT DISTINCT 
        V.ORIS_CODE,
        V.FACILITY_NAME,
        V.STATE,
        camdecmps.get_mp_location_list(V.MON_PLAN_ID) AS LOCATIONS,
        V.PERIOD,
        V.ACCESS_BEGIN_DATE,
        V.ACCESS_END_DATE,
        V.EM_SUB_TYPE_CD_DESCRIPTION,
        V.WINDOW_STATUS,
        V.LAST_WINDOW,
        V.SUBMISSION_STATUS,
        V.USERID, 
        V.ACCEPTED_SUBMISSION_IN_PERIOD, 
        V.LAST_WINDOW_WITH_OK_SUBMISSION,
        V.SUBMISSION_ID,
        V.SUBMISSION_DATE,
        V.SEVERITY_CD_DESCRIPTION,
        V.SUBMITTER_USER_ID
    FROM CAMDECMPSAUX.VW_EM_SUBMISSION_ACCESS V
    WHERE V.FAC_ID = COALESCE(V_FAC_ID, V.FAC_ID)
      AND V.FACILITY_NAME = COALESCE(V_FACILITY_NAME, V.FACILITY_NAME)
      AND V.RPT_PERIOD_ID = COALESCE(V_RPT_PERIOD_ID, V.RPT_PERIOD_ID)
      AND V.SUBMISSION_STATUS = COALESCE(V_SUBMISSION_STATUS, V.SUBMISSION_STATUS)
    ORDER BY V.ORIS_CODE ASC, V.PERIOD DESC;
END;
$BODY$ LANGUAGE plpgsql;
