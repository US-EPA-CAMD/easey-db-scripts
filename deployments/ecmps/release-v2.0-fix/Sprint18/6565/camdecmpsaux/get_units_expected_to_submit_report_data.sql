CREATE OR REPLACE FUNCTION camdecmpsaux.get_units_expected_to_submit_report_data(
    V_FAC_ID            numeric,
    V_FACILITY_NAME     character varying,
    V_STATE             character varying,
    V_PRG_CODE          character varying,
    V_YEAR              numeric,
    V_QUARTER           numeric,
    V_WINDOW_STATUS     character varying
)
RETURNS TABLE (
    ORIS_CODE                     numeric,
    FACILITY_NAME                 character varying,
    STATE                         character varying,
    UNITID                        character varying,
    LOCATIONS                     text,
    EM_SUB_TYPE_CD_DESCRIPTION    character varying,
    ACCESS_BEGIN_DATE             date,
    ACCESS_END_DATE               date,
    WINDOW_STATUS                 text,
    SUBMISSION_STATUS             text,
    SUBMISSION_ID                 bigint,
    SUBMISSION_DATE               timestamp,
    SEVERITY_CD_DESCRIPTION       character varying
)
AS $BODY$
DECLARE
    v_rpt_period_id numeric;
BEGIN

    IF V_PRG_CODE IS NULL OR TRIM(BOTH FROM V_PRG_CODE) = '' THEN
        RAISE NOTICE 'Required input parameter [V_PRG_CODE] (program) was not provided or is empty.';
    END IF;

    IF V_YEAR IS NULL THEN
        RAISE NOTICE 'Required input parameter [V_YEAR] (year) was not provided.';
    END IF;

    IF V_QUARTER IS NULL THEN
        RAISE NOTICE 'Required input parameter [V_QUARTER] (quarter) was not provided.';
    END IF;

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
        U_SUB.UNITID,
        COALESCE(camdecmps.get_mp_location_list(U_SUB.MON_PLAN_ID), U_SUB.MON_PLAN_ID) AS LOCATIONS,
        ESA_SUB.EM_SUB_TYPE_CD_DESCRIPTION,
        ESA_SUB.ACCESS_BEGIN_DATE::date AS ACCESS_BEGIN_DATE,
        ESA_SUB.ACCESS_END_DATE::date AS ACCESS_END_DATE,
        COALESCE(ESA_SUB.WINDOW_STATUS, 'No Window') AS WINDOW_STATUS,
        ESA_SUB.SUBMISSION_STATUS,
        ESA_SUB.SUBMISSION_ID,
        ESA_SUB.SUBMISSION_DATE,
        ESA_SUB.SEVERITY_CD_DESCRIPTION
    FROM
        (
         SELECT 
             U.UNIT_ID,
             U.UNITID,
             U.FAC_ID,
             camdecmps.get_em_reporting_status(U.UNIT_ID, v_rpt_period_id, V_PRG_CODE) AS MON_PLAN_ID
         FROM camd.UNIT U
        ) U_SUB
    JOIN camd.plant F
        ON U_SUB.FAC_ID = F.FAC_ID
    LEFT JOIN 
        (
         SELECT 
             ESA.MON_PLAN_ID,
             ESA.EM_SUB_TYPE_CD_DESCRIPTION,
             ESA.ACCESS_BEGIN_DATE,
             ESA.ACCESS_END_DATE,
             ESA.WINDOW_STATUS,
             ESA.SUBMISSION_STATUS,
             ESA.SUBMISSION_ID,
             ESA.SUBMISSION_DATE,
             ESA.SEVERITY_CD_DESCRIPTION
         FROM camdecmpsaux.VW_EM_SUBMISSION_ACCESS ESA
         WHERE ESA.RPT_PERIOD_ID = v_rpt_period_id
           AND (ESA.LAST_WINDOW = 'Yes' OR (ESA.EM_SUB_TYPE_CD = 'INITIAL' AND ESA.SUB_AVAILABILITY_CD = 'DELETE'))
        ) ESA_SUB
        ON U_SUB.MON_PLAN_ID = ESA_SUB.MON_PLAN_ID
    WHERE U_SUB.MON_PLAN_ID IS NOT NULL
      AND U_SUB.FAC_ID = COALESCE(V_FAC_ID, U_SUB.FAC_ID)
      AND F.FACILITY_NAME = COALESCE(V_FACILITY_NAME, F.FACILITY_NAME)
      AND F.STATE = COALESCE(V_STATE, F.STATE)
      AND COALESCE(ESA_SUB.WINDOW_STATUS, 'No Window') = COALESCE(V_WINDOW_STATUS, COALESCE(ESA_SUB.WINDOW_STATUS, 'No Window'))
    ORDER BY F.ORIS_CODE;
END;
$BODY$ LANGUAGE plpgsql;
