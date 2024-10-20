-- FUNCTION: camdecmps.get_oris_codes_for_configurations_last_updated(timestamp without time zone)

DROP FUNCTION IF EXISTS camdecmps.get_oris_codes_for_configurations_last_updated(timestamp without time zone) CASCADE;

CREATE OR REPLACE FUNCTION camdecmps.get_oris_codes_for_configurations_last_updated(
	p_date timestamp without time zone)
    RETURNS TABLE(oris_code numeric, last_updated_time timestamp without time zone) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
	
	Return Query Select distinct pl.oris_code, records.update_date
	FROM(
	(
		Select mp.fac_id, coalesce(mp.update_date, mp.add_date) as update_date
		From camdecmps.monitor_plan mp
		WHERE coalesce(update_date, add_date) > p_date
	)
	Union -- Mon Loc
	(
		Select mp.fac_id, coalesce(ml.update_date, ml.add_date) as update_date
		From camdecmps.monitor_location ml
		Join camdecmps.monitor_plan_location mpl
			On ml.mon_loc_id = mpl.mon_loc_id
		Join camdecmps.monitor_plan mp
			On mpl.mon_plan_id = mp.mon_plan_id
		WHERE coalesce(ml.update_date, ml.add_date) > p_date
	)
	Union -- Stack Pipe
	( 
		Select mp.fac_id, coalesce(sp.update_date, sp.add_date) as update_date
		From camdecmps.stack_pipe sp
		Join camdecmps.monitor_location ml
			On sp.stack_pipe_id = ml.stack_pipe_id
		Join camdecmps.monitor_plan_location mpl
			On ml.mon_loc_id = mpl.mon_loc_id
		Join camdecmps.monitor_plan mp
			On mpl.mon_plan_id = mp.mon_plan_id
		WHERE coalesce(sp.update_date, sp.add_date) > p_date
	)
	Union --Unit Stack Config
	(
		Select mp.fac_id, coalesce(usc.update_date, usc.add_date) as update_date
		From camdecmps.unit_stack_configuration usc
		Join camdecmps.monitor_location ml
			On usc.stack_pipe_id = ml.stack_pipe_id or usc.unit_id = ml.unit_id
		Join camdecmps.monitor_plan_location mpl
			On ml.mon_loc_id = mpl.mon_loc_id
		Join camdecmps.monitor_plan mp
			On mpl.mon_plan_id = mp.mon_plan_id
		WHERE coalesce(usc.update_date, usc.add_date) > p_date
	)) records
	Join camd.plant pl
		On records.fac_id = pl.fac_id 
	Order By records.update_date Desc;

END;
$BODY$;