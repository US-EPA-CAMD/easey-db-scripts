-- FUNCTION: camdecmps.get_oris_codes_for_configurations_last_updated(timestamp without time zone)

-- DROP FUNCTION camdecmps.get_oris_codes_for_configurations_last_updated(timestamp without time zone);

CREATE OR REPLACE FUNCTION camdecmps.get_oris_codes_for_configurations_last_updated(
	p_date timestamp without time zone)
    RETURNS TABLE(oris_code numeric, last_updated_time timestamp without time zone) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
BEGIN
	
	Return Query Select pl.oris_code, records.update_date
	FROM(
	(
		Select mp.fac_id, mp.last_updated as update_date
		From camdecmps.monitor_plan mp
		WHERE last_updated >= p_date
	)
	Union -- Mon Loc
	(
		Select mp.fac_id, ml.update_date
		From camdecmps.monitor_location ml
		Join camdecmps.monitor_plan_location mpl
			On ml.mon_loc_id = mpl.mon_loc_id
		Join camdecmps.monitor_plan mp
			On mpl.mon_plan_id = mp.mon_plan_id
		WHERE ml.update_date >= p_date
	)
	Union -- Stack Pipe
	(
		Select mp.fac_id, sp.update_date
		From camdecmps.stack_pipe sp
		Join camdecmps.monitor_location ml
			On sp.stack_pipe_id = ml.stack_pipe_id
		Join camdecmps.monitor_plan_location mpl
			On ml.mon_loc_id = mpl.mon_loc_id
		Join camdecmps.monitor_plan mp
			On mpl.mon_plan_id = mp.mon_plan_id
		WHERE sp.update_date >= p_date
	)
	Union --Unit Stack Config
	(
		Select mp.fac_id, usc.update_date
		From camdecmps.unit_stack_configuration usc
		Join camdecmps.monitor_location ml
			On usc.stack_pipe_id = ml.stack_pipe_id or usc.unit_id = ml.unit_id
		Join camdecmps.monitor_plan_location mpl
			On ml.mon_loc_id = mpl.mon_loc_id
		Join camdecmps.monitor_plan mp
			On mpl.mon_plan_id = mp.mon_plan_id
		WHERE usc.update_date >= p_date
	)) records
	Join camd.plant pl
		On records.fac_id = pl.fac_id 
	Order By records.update_date Desc;

END;
$BODY$;
