-- FUNCTION: camdecmps.get_last_em_submission(character varying, numeric, date, date)

DROP FUNCTION IF EXISTS camdecmps.get_last_em_submission(character varying, numeric, date, date) CASCADE;

CREATE OR REPLACE FUNCTION camdecmps.get_last_em_submission(
	inmonplanid character varying,
	inrptperiodid numeric,
	inbegindate date,
	inenddate date)
    RETURNS numeric
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
DECLARE
	V_SUBMISSION_ID numeric := NULL;
BEGIN
	SELECT SL2.SUBMISSION_ID INTO V_SUBMISSION_ID
	FROM CAMDECMPSAUX.SUBMISSION SL2,
	(
		SELECT
			SL.MON_PLAN_ID,
			SL.RPT_PERIOD_ID,
			MAX(SL.ADD_DATE) AS ADD_DATE
		FROM CAMDECMPSAUX.SUBMISSION AS SL
		LEFT JOIN CAMDECMPSAUX.EM_SUBMISSION_ACCESS USING(MON_PLAN_ID),
		(
			SELECT MON_PLAN_ID,
				MIN(
					CASE
						WHEN ACCESS_BEGIN_DATE > ADD_DATE THEN ACCESS_BEGIN_DATE
						ELSE ADD_DATE
					END
				) AS ACCESS_BEGIN_DATE
			FROM CAMDECMPSAUX.EM_SUBMISSION_ACCESS
			WHERE MON_PLAN_ID = INMONPLANID AND
				RPT_PERIOD_ID = INRPTPERIODID AND
				ACCESS_BEGIN_DATE > INBEGINDATE 
			GROUP BY MON_PLAN_ID
		) AS ESA
		WHERE SUBMISSION_TYPE_CD = 'EM' AND
			SL.MON_PLAN_ID = INMONPLANID AND
			SL.RPT_PERIOD_ID = INRPTPERIODID AND
			CAST(SL.ADD_DATE AS date) >= CAST(INBEGINDATE AS date) AND
			CAST(SL.ADD_DATE AS date) <= CAST(INENDDATE AS date) AND (
				ESA.MON_PLAN_ID IS NULL OR
				SL.ADD_DATE < ESA.ACCESS_BEGIN_DATE
			)
		 GROUP BY SL.MON_PLAN_ID, SL.RPT_PERIOD_ID
	) AS MAXSUB
	WHERE SL2.MON_PLAN_ID = MAXSUB.MON_PLAN_ID AND
		SL2.RPT_PERIOD_ID = MAXSUB.RPT_PERIOD_ID AND
		SL2.ADD_DATE = MAXSUB.ADD_DATE AND
		SL2.MON_PLAN_ID = INMONPLANID AND
		SL2.SUBMISSION_TYPE_CD = 'EM' AND
		SL2.RPT_PERIOD_ID = INRPTPERIODID;
	
	RETURN V_SUBMISSION_ID;
END;
$BODY$;
