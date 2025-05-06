CREATE OR REPLACE FUNCTION camdecmpsaux.get_quarterly_em_submission_windows_report_data(
    V_FAC_ID            numeric,
    V_FACILITY_NAME     character varying,
    V_SUBMISSION_STATUS character varying,
    V_YEAR              numeric,
    V_QUARTER           numeric
)
RETURNS TABLE (
    ORIS_CODE                       numeric,
    FACILITY_NAME                   text,
    STATE                           text,
    LOCATIONS                       text,
    PERIOD_ABBREVIATION             character varying,
    ACCESS_BEGIN_DATE               date,
    ACCESS_END_DATE                 date,
    EM_SUB_TYPE_CD_DESCRIPTION      text,
    WINDOW_STATUS                   text,
    LAST_WINDOW                     text,
    SUBMISSION_STATUS               text,
    ACCEPTED_SUBMISSION_IN_PERIOD   text, 
    LAST_WINDOW_WITH_OK_SUBMISSION  text,
    SUBMISSION_ID                   bigint,
    SUBMISSION_DATE                 timestamp,
    SEVERITY_CD_DESCRIPTION         character varying,
    SUBMITTER_USER_ID               character varying
) AS $BODY$
DECLARE
    V_RPT_PERIOD_ID numeric;
BEGIN

    IF ( (V_YEAR IS NULL AND V_QUARTER IS NOT NULL) OR (V_YEAR IS NOT NULL AND V_QUARTER IS NULL) ) THEN
        RAISE NOTICE 'Please pass both year and quarter OR neither.';
        RETURN;
    END IF;
    
    IF V_YEAR IS NOT NULL AND V_QUARTER IS NOT NULL THEN
        SELECT RPT_PERIOD_ID
          INTO V_RPT_PERIOD_ID
          FROM camdecmpsmd.reporting_period
         WHERE calendar_year = V_YEAR
           AND quarter = V_QUARTER;
    ELSE
        V_RPT_PERIOD_ID := NULL;
    END IF;
       
    RETURN QUERY
    SELECT DISTINCT 
        V.ORIS_CODE,
        V.FACILITY_NAME,
        V.STATE,
        V.LOCATIONS,
        V.PERIOD_ABBREVIATION,
        V.ACCESS_BEGIN_DATE,
        V.ACCESS_END_DATE,
        V.EM_SUB_TYPE_CD_DESCRIPTION,
        V.WINDOW_STATUS,
        V.LAST_WINDOW,
        V.SUBMISSION_STATUS,
        V.ACCEPTED_SUBMISSION_IN_PERIOD, 
        V.LAST_WINDOW_WITH_OK_SUBMISSION,
        V.SUBMISSION_ID,
        V.SUBMISSION_DATE,
        V.SEVERITY_CD_DESCRIPTION,
        V.SUBMITTER_USER_ID
    FROM camdecmpsaux.vw_em_submission_access V
    WHERE V.FAC_ID = COALESCE(V_FAC_ID, V.FAC_ID)
      AND V.FACILITY_NAME = COALESCE(V_FACILITY_NAME, V.FACILITY_NAME)
      AND V.RPT_PERIOD_ID = COALESCE(V_RPT_PERIOD_ID, V.RPT_PERIOD_ID)
      AND V.SUBMISSION_STATUS = COALESCE(V_SUBMISSION_STATUS, V.SUBMISSION_STATUS)
    ORDER BY V.ORIS_CODE ASC, V.PERIOD_ABBREVIATION DESC;
END;
$BODY$ LANGUAGE plpgsql;
