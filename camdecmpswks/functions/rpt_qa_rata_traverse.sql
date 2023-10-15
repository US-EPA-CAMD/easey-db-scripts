CREATE OR REPLACE FUNCTION camdecmpswks.rpt_qa_rata_traverse(
	testsumid text,
	oplevelcd text)
    RETURNS TABLE(
		"runNum" numeric,
		"traverseId" text,
		"probeType" text,
		"pressureDeviceType" text,
		"probeId" text,
		"velocityCoef" numeric,
		"lastProbeDate" text,
		"avgDiff" numeric,
		"avgSqrDiffPress" numeric,
		"stackTemp" numeric,
		"yawAngle" numeric,
		"pitchAngle" numeric,
		"unadjRep" numeric,
		"unadjCalc" numeric,
		"pointUsed" numeric,
		"noWallEffect" numeric,
		"repVelocity" numeric
		) 
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
SELECT
	rr.run_num as "runNum",
	rt.method_traverse_point_id as "traverseId",
	rt.probe_type_cd as "probeType",
	rt.pressure_meas_cd as "pressureDeviceType",
	rt.probeid as "probeId",
	rt.vel_cal_coef as "velocityCoef",
	TO_CHAR(rt.last_probe_date, 'YYYY-MM-DD') as "lastProbeDate",
	rt.avg_vel_diff_pressure as "avgDiff",
	rt.avg_sq_vel_diff_pressure as "avgSqrDiffPress",
	rt.t_stack_temp as "stackTemp",
	rt.yaw_angle as "yawAngle",
	rt.pitch_angle as "pitchAngle",
	rt.calc_vel as "unadjRep",
	rt.calc_calc_vel as "unadjCalc",
	rt.point_used_ind as "pointUsed",
	rt.num_wall_effects_points as "noWallEffect",
	rt.rep_vel as"repVelocity"
	FROM camdecmpswks.rata_traverse rt
	join camdecmpswks.flow_rata_run frr using(flow_rata_run_id)
	join camdecmpswks.rata_run rr using(rata_run_id)
	join camdecmpswks.rata_summary rs using(rata_sum_id)
	join camdecmpswks.rata r using(rata_id)
	WHERE test_sum_id = testSumId
	AND rs.op_level_cd = oplevelcd
	ORDER BY "runNum";
$BODY$;