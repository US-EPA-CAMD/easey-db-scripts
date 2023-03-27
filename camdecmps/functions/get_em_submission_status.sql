-- FUNCTION: camdecmps.get_em_submission_status(character varying, numeric, numeric)

DROP FUNCTION IF EXISTS camdecmps.get_em_submission_status(character varying, numeric, numeric);

CREATE OR REPLACE FUNCTION camdecmps.get_em_submission_status(
	inmonplanid character varying,
	incalendaryear numeric,
	inquarter numeric)
    RETURNS text
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
DECLARE
	LENDDATE   date;
	LBEGINDATE date;
	LSTATUS    text := NULL;
	LPROGNOREP text := NULL;
	ACTIVE_PROGRAM_REC RECORD;
	ACTIVE_PROGRAM_CUR REFCURSOR;
BEGIN
/*
	1.  At least one unit in the MP has a current Unit Operating Status equal to OPR unless the EndDate in the Unit Operating Status record is prior to May 1 in the reporting period (for OS reporters during Q2)
    2.  At least one operating unit in the MP has an active Unit Program record.  For a Unit Program record to be active, all of the following must be true:
        a. The associated program must be active.
        b. The UMCBD must be on or prior to the reporting period end date and EndDate must be null or on or after the reporting period begin date.
        c. There are no active associated Unit Program Exemption records.
    3.  The reporting period is the 2nd or 3rd quarter or the active Reporting Frequency Code of the MP is equal to �Q�.
    4.  (NOT YET IMPLEMENTED) The Actual 90th Operating Days is not null if unit reported 90 days of operating data    
*/

	IF INQUARTER = 1 THEN
		LBEGINDATE := TO_DATE('01/01/' || INCALENDARYEAR, 'mm/dd/yyyy');
		LENDDATE   := TO_DATE('03/31/' || INCALENDARYEAR, 'mm/dd/yyyy');
	ELSIF INQUARTER = 2 THEN
		LBEGINDATE := TO_DATE('04/01/' || INCALENDARYEAR, 'mm/dd/yyyy');
		LENDDATE   := TO_DATE('06/30/' || INCALENDARYEAR, 'mm/dd/yyyy');
	ELSIF INQUARTER = 3 THEN
		LBEGINDATE := TO_DATE('07/01/' || INCALENDARYEAR, 'mm/dd/yyyy');
		LENDDATE   := TO_DATE('09/30/' || INCALENDARYEAR, 'mm/dd/yyyy');
	ELSIF INQUARTER = 4 THEN
		LBEGINDATE := TO_DATE('10/01/' || INCALENDARYEAR, 'mm/dd/yyyy');
		LENDDATE   := TO_DATE('12/31/' || INCALENDARYEAR, 'mm/dd/yyyy');
	END IF;

	OPEN ACTIVE_PROGRAM_CUR FOR
		SELECT DISTINCT
			UNIT_MONITOR_CERT_BEGIN_DATE,
			EMISSIONS_RECORDING_BEGIN_DATE,
			CAMDECMPS.HAS_ACTIVE_REP(UP.UP_ID) AS HASREP,
			P.PRG_CD
		FROM CAMD.UNIT_PROGRAM AS UP
			LEFT JOIN (
				SELECT UNIT_ID 
				FROM CAMD.UNIT_PROGRAM 
				WHERE PRG_CD = 'OTC'
			) AS OTC ON UP.UNIT_ID = OTC.UNIT_ID
			LEFT JOIN (
				SELECT UP_ID
				FROM camdecmps.vw_unit_program_exemption
				WHERE BEGIN_DATE <= LBEGINDATE AND (
					END_DATE IS NULL OR 
					END_DATE >= LENDDATE
				)
			) AS UPE ON UP.UP_ID = UPE.UP_ID,
			CAMD.PROGRAM AS P,
			CAMD.PROGRAM_PHASE AS PP,
			CAMD.UNIT AS U,
			CAMDECMPS.MONITOR_LOCATION AS ML,
			CAMDECMPS.MONITOR_PLAN_LOCATION AS MPL,
			CAMDECMPS.GET_OPERATING_UNIT_RETIRE_DATE(LBEGINDATE, LENDDATE) AS RET,
			CAMDECMPS.GET_MONITOR_PLAN_REPORTING_FREQ(INCALENDARYEAR, INQUARTER) AS RF
			WHERE UP.PRG_ID = P.PRG_ID AND
				P.PRG_ID = PP.PRG_ID AND
			 	UP.UNIT_ID = U.UNIT_ID AND
				UP.UNIT_ID = RET.UNIT_ID AND (
					(
						P.PRG_CD = 'ARP' AND
						UP.CLASS_CD = PP.PHASE
					) OR (
						P.PRG_CD IN ('NBP', 'NHNOX') AND
						OTC.UNIT_ID IS NOT NULL AND
						PP.PHASE = 'OTC'
					) OR (
						P.PRG_CD IN ('NBP', 'NHNOX') AND
						OTC.UNIT_ID IS NULL AND
						COALESCE(PP.PHASE, ' ') <> 'OTC'
					) OR (
						P.PRG_CD NOT IN ('NBP', 'NHNOX', 'ARP') AND
						PP.PHASE IS NULL
					)
				) AND (
					PHASE_MONITOR_CERT_DEADLINE <= LENDDATE OR
					EMISSIONS_RECORDING_BEGIN_DATE <= LENDDATE
				) AND (
					UNIT_MONITOR_CERT_BEGIN_DATE <= LENDDATE OR
					EMISSIONS_RECORDING_BEGIN_DATE <= LENDDATE
				) AND (
					UP.END_DATE IS NULL OR
					UP.END_DATE >= LBEGINDATE
				) AND 
				UPE.UP_ID IS NULL AND (
					RET.RETIRE_DATE IS NULL OR (
						(
							INQUARTER <> 2 OR
							RF.REPORT_FREQ_CD = 'Q'
						) AND
						RET.RETIRE_DATE >= LBEGINDATE
					) OR (
						INQUARTER = 2 AND
						RF.REPORT_FREQ_CD = 'OS' AND
						CAST(TO_CHAR(RET.RETIRE_DATE, 'yyyy') AS numeric) = INCALENDARYEAR AND
						CAST(TO_CHAR(RET.RETIRE_DATE, 'mm') AS numeric) >= 5
					)
				) AND
				UP.UNIT_ID = ML.UNIT_ID AND
				ML.MON_LOC_ID = MPL.MON_LOC_ID AND
				MPL.MON_PLAN_ID = RF.MON_PLAN_ID AND
				MPL.MON_PLAN_ID = INMONPLANID AND (
					INQUARTER IN (2, 3) OR
					RF.REPORT_FREQ_CD = 'Q'
				)
            ORDER BY P.PRG_CD; -- order the PRG_CD list so duplicates can properly be removed
	
	LOOP
		FETCH ACTIVE_PROGRAM_CUR INTO ACTIVE_PROGRAM_REC;
		EXIT WHEN NOT FOUND;
	
		IF (ACTIVE_PROGRAM_REC.EMISSIONS_RECORDING_BEGIN_DATE IS NOT NULL AND
			ACTIVE_PROGRAM_REC.EMISSIONS_RECORDING_BEGIN_DATE <= LENDDATE) OR
			(ACTIVE_PROGRAM_REC.EMISSIONS_RECORDING_BEGIN_DATE IS NULL AND
			ACTIVE_PROGRAM_REC.UNIT_MONITOR_CERT_BEGIN_DATE + 180 <= LENDDATE) THEN
			BEGIN
				LSTATUS := 'REQUIRE';
				IF ACTIVE_PROGRAM_REC.HASREP = 'F' THEN
					IF LPROGNOREP IS NULL THEN
						LPROGNOREP := ACTIVE_PROGRAM_REC.PRG_CD;
					ELSE
						LPROGNOREP := LPROGNOREP || ',' || ACTIVE_PROGRAM_REC.PRG_CD;
					END IF;
				END IF;
			END;
		ELSE
			IF ACTIVE_PROGRAM_REC.EMISSIONS_RECORDING_BEGIN_DATE IS NULL THEN
				LSTATUS := 'GRANTED';
				IF ACTIVE_PROGRAM_REC.HASREP = 'F' THEN
					IF LPROGNOREP IS NULL THEN
						LPROGNOREP := ACTIVE_PROGRAM_REC.PRG_CD;
					ELSE
						LPROGNOREP := LPROGNOREP || ',' || ACTIVE_PROGRAM_REC.PRG_CD;
					END IF;
				END IF;
			END IF;
		END IF;
		
	END LOOP;

	CLOSE ACTIVE_PROGRAM_CUR;
	
	--Remove duplicate program codes from the list and append to the status	
	IF LPROGNOREP IS NOT NULL AND LSTATUS IS NOT NULL THEN
		-- THIS WAS NOT WORKING
		-- LPROGNOREP := RTRIM(REGEXP_REPLACE(LPROGNOREP, '([^,]*)(,\1)+($|,)', '\1\3'),',');
		-- CHANGED TO THE FOLLOWING
		LPROGNOREP := RTRIM(LPROGNOREP, ',');
		SELECT array_to_string(
			ARRAY(
				SELECT DISTINCT trim(x)
				FROM unnest(string_to_array(LPROGNOREP, ',')) AS x
			), ', '
		);
		LSTATUS := LSTATUS || ';' || LPROGNOREP;
	END IF;

	RETURN LSTATUS;	
END;
$BODY$;
