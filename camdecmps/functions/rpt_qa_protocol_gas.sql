-- FUNCTION: camdecmps.rpt_qa_protocol_gas(text)

DROP FUNCTION IF EXISTS camdecmps.rpt_qa_protocol_gas(text) CASCADE;

CREATE OR REPLACE FUNCTION camdecmps.rpt_qa_protocol_gas(
	testsumid text)
    RETURNS TABLE("rowNumber" integer, "unitStack" text, "gasLevelCode" text, "gasTypeCode" text, "vendorIdentifier" text, "cylinderIdentifier" text, "expirationDate" text) 
    LANGUAGE 'sql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
SELECT
		CASE
			WHEN pg.gas_level_cd = 'HIGH' THEN 1
			WHEN pg.gas_level_cd = 'MID' THEN 2
			WHEN pg.gas_level_cd = 'LOW' THEN 3
		END AS "rowNumber",
		CASE
			WHEN ml.stack_pipe_id IS NOT NULL THEN sp.stack_name
			WHEN ml.unit_id IS NOT NULL THEN u.unitid
			ELSE '*'
		END AS "unitStack",
		pg.gas_level_cd AS "gasLevelCode",
		pg.gas_type_cd AS "gasTypeCode",
		pg.vendor_id AS "vendorIdentifier",
		pg.cylinder_id AS "cylinderIdentifier",
		camdecmps.format_date_hour(pg.expiration_date, null, null) AS "expirationDate"
	FROM camdecmps.protocol_gas pg
	JOIN camdecmps.test_summary ts USING(test_sum_id)
	JOIN camdecmps.monitor_location ml USING(mon_loc_id)
	LEFT JOIN camdecmps.stack_pipe sp USING(stack_pipe_id)
	LEFT JOIN camd.unit u USING(unit_id)
	WHERE ts.test_sum_id = testSumId
	ORDER BY "rowNumber";
$BODY$;
