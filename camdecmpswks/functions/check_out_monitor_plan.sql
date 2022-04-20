-- FUNCTION: camdecmpswks.check_out_monitor_plan(text, text)

-- DROP FUNCTION camdecmpswks.check_out_monitor_plan(text, text);

CREATE OR REPLACE FUNCTION camdecmpswks.check_out_monitor_plan(
	monplanid text,
	username text)
    RETURNS SETOF camdecmpswks.user_check_out 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
DECLARE
	fac 			record;
	rec 			record;
	planName 	text;
BEGIN

	-- GET FACILITY --
	SELECT fac_id, facility_name INTO fac
	FROM camdecmps.monitor_plan
	JOIN camd.plant
		USING (fac_id)
	WHERE mon_plan_id = monPlanId;

	IF EXISTS (
		SELECT * FROM camdecmpswks.user_check_out WHERE mon_plan_id = monPlanId
	) THEN

		-- GET USER CHECK OUT --
		SELECT checked_out_by, checked_out_on INTO rec
		FROM camdecmpswks.user_check_out
		WHERE mon_plan_id = monPlanId;			

		-- GET CONFIGURATION --
		SELECT string_agg(unitStack, ', ') INTO planName
		FROM (
			SELECT unitid AS unitStack
			FROM camdecmps.monitor_plan
			JOIN camdecmps.monitor_plan_location
				USING (mon_plan_id)
			JOIN camdecmps.monitor_location
				USING (mon_loc_id)
			JOIN camd.unit
				USING (unit_id)
			WHERE mon_plan_id = monPlanId

			UNION

			SELECT stack_name AS unitStack
			FROM camdecmps.monitor_plan
			JOIN camdecmps.monitor_plan_location
				USING (mon_plan_id)
			JOIN camdecmps.monitor_location
				USING (mon_loc_id)
			JOIN camdecmps.stack_pipe
				USING (stack_pipe_id)
			WHERE mon_plan_id = monPlanId
		) AS unitStack;

		RAISE EXCEPTION 'Monitor Plan % (%) currently checked out by % on %', fac.facility_name, planName, rec.checked_out_by, rec.checked_out_on;
	END IF;

	-- CHECK OUT MONITOR PLAN --	
	INSERT INTO camdecmpswks.user_check_out(
		facility_id, mon_plan_id, checked_out_on, checked_out_by, last_activity
	)
	VALUES(fac.fac_id, monPlanId, CURRENT_TIMESTAMP, userName, CURRENT_TIMESTAMP);
	
	RETURN QUERY SELECT *
	FROM camdecmpswks.user_check_out
	WHERE mon_plan_id = monPlanId;

END;
$BODY$;
