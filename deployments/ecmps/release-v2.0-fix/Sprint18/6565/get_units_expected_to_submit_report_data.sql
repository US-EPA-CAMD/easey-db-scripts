DROP FUNCTION IF EXISTS get_units_expected_to_submit_report_data(numeric, character varying, character varying, character varying, numeric, numeric, character varying);

CREATE OR REPLACE FUNCTION get_units_expected_to_submit_report_data(
    V_FAC_ID            numeric,
    V_FACILITY_NAME     character varying,
    V_STATE             character varying,
    V_PRG_CODE          character varying,
    V_YEAR              numeric,
    V_QUARTER           numeric,
    V_WINDOW_STATUS     character varying
)
RETURNS TABLE (
    
    ORIS_CODE                     character varying,
    FACILITY_NAME                 character varying,
    STATE                         character varying,
    UNIT_ID                       numeric,
    LOCATIONS                     character varying,
    EM_SUB_TYPE_CD_DESCRIPTION    character varying,
    ACCESS_BEGIN_DATE             date,
    ACCESS_END_DATE               date,
    WINDOW_STATUS                 character varying,
    SUBMISSION_STATUS             character varying,
    SUBMISSION_ID                 bigint,
    SUBMIT_DATE                   timestamp,
    SEVERITY_CD_DESCRIPTION       character varying
)
AS $BODY$
DECLARE
    v_rpt_period_id numeric;
BEGIN
    SELECT RPT_PERIOD_ID
      INTO v_rpt_period_id
      FROM camdecmpsmd.reporting_period
     WHERE calendar_year = V_YEAR
       AND quarter = V_QUARTER;

    RETURN QUERY
    SELECT DISTINCT
        F.ORIS_CODE,
        F.FACILITY_NAME,
        F.STATE,
        U.UNIT_ID,
        COALESCE(camdecmps.get_mp_location_list(U.MON_PLAN_ID), U.MON_PLAN_ID) AS LOCATIONS,
        ESA.EM_SUB_TYPE_CD_DESCRIPTION,
        ESA.ACCESS_BEGIN_DATE::date AS ACCESS_BEGIN_DATE,
        ESA.ACCESS_END_DATE::date AS ACCESS_END_DATE,
        COALESCE(ESA.WINDOW_STATUS, 'No Window') AS WINDOW_STATUS,
        ESA.SUBMISSION_STATUS,
        ESA.SUBMISSION_ID,
        ESA.SUBMIT_DATE,
        ESA.SEVERITY_CD_DESCRIPTION
    FROM
        (
         SELECT 
             UNIT_ID,
             FAC_ID,
             camdecmps.get_em_reporting_status(UNIT_ID, v_rpt_period_id, V_PRG_CODE) AS MON_PLAN_ID
         FROM camd.UNIT
        ) U
    JOIN camd.plant F
        ON U.FAC_ID = F.FAC_ID
    LEFT JOIN 
        (
         SELECT 
             MON_PLAN_ID,
             EM_SUB_TYPE_CD_DESCRIPTION,
             ACCESS_BEGIN_DATE,
             ACCESS_END_DATE,
             WINDOW_STATUS,
             SUBMISSION_STATUS,
             SUBMISSION_ID,
             SUBMIT_DATE,
             SEVERITY_CD_DESCRIPTION
         FROM camdecmpsaux.VW_EM_SUBMISSION_ACCESS
         WHERE RPT_PERIOD_ID = v_rpt_period_id
           AND (LAST_WINDOW = 'Yes' OR (EM_SUB_TYPE_CD = 'INITIAL' AND SUB_AVAILABILITY_CD = 'DELETE'))
        ) ESA 
        ON U.MON_PLAN_ID = ESA.MON_PLAN_ID
    WHERE U.MON_PLAN_ID IS NOT NULL
      AND U.FAC_ID = COALESCE(V_FAC_ID, U.FAC_ID)
      AND F.FACILITY_NAME = COALESCE(V_FACILITY_NAME, F.FACILITY_NAME)
      AND F.STATE = COALESCE(V_STATE, F.STATE)
      AND COALESCE(ESA.WINDOW_STATUS, 'No Window') = COALESCE(V_WINDOW_STATUS, COALESCE(ESA.WINDOW_STATUS, 'No Window'))
    ORDER BY F.ORIS_CODE;
END;
$BODY$ LANGUAGE plpgsql;
