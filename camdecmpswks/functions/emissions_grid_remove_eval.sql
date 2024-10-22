-- FUNCTION: camdecmpswks.emissions_grid_remove_eval(character varying, integer)

-- DROP FUNCTION IF EXISTS camdecmpswks.emissions_grid_remove_eval(character varying, integer);

CREATE OR REPLACE FUNCTION camdecmpswks.emissions_grid_remove_eval(
	vmonplan_id character varying,
	vrptperiod_id integer)
    RETURNS TABLE(result text, error_msg character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

BEGIN
    error_msg := '';
    result := 'T';

	--AY keep the line below for 'Client.DeleteEMGridTables', in case we do need take care of it
	-- NOTE: if you modify this, also check Client.DeleteEMGridTables procedure too!
	--
	
	UPDATE camdecmpswks.EMISSION_VIEW_CO2APPD
		SET	CALC_HI_RATE = NULL,
			CALC_CO2_MASS_RATE = NULL,
			CALC_CO2_MASS_RATE_ALL_FUELS = NULL,
			ERROR_CODES = NULL
		where MON_PLAN_ID =vmonplan_id
			and RPT_PERIOD_ID = vrptperiod_id;
	
	UPDATE camdecmpswks.EMISSION_VIEW_CO2CALC
		SET	CALC_PCT_CO2 = NULL,
			ERROR_CODES = NULL
		where MON_PLAN_ID =vmonplan_id
			and RPT_PERIOD_ID = vrptperiod_id;
			
	UPDATE camdecmpswks.EMISSION_VIEW_CO2CEMS 
		SET	CALC_FLOW_BAF = NULL,
			CALC_CO2_MASS_RATE = NULL,
			ERROR_CODES = NULL
		where MON_PLAN_ID =vmonplan_id
			and RPT_PERIOD_ID = vrptperiod_id;
			
	UPDATE camdecmpswks.EMISSION_VIEW_CO2DAILYFUEL 
		SET	ERROR_CODES = NULL
		where MON_PLAN_ID =vmonplan_id
		  and RPT_PERIOD_ID = vrptperiod_id;
	
	UPDATE camdecmpswks.EMISSION_VIEW_DAILYCAL
		SET	CALC_TEST_RESULT_CD = NULL,
			CALC_UPSCALE_CE_OR_MEAN_DIFF = NULL,
			CALC_UPSCALE_APS_IND = NULL,
			CALC_ZERO_CE_OR_MEAN_DIFF = NULL,
			CALC_ZERO_APS_IND = NULL,
			CALC_ONLINE_OFFLINE_IND = NULL,
			ERROR_CODES = NULL
		where MON_PLAN_ID =vmonplan_id
		  and RPT_PERIOD_ID = vrptperiod_id;
		  
	UPDATE camdecmpswks.EMISSION_VIEW_HIAPPD 
		SET	CALC_FUEL_FLOW = NULL,
			CALC_HI_RATE = NULL,
			ERROR_CODES = NULL
		where MON_PLAN_ID =vmonplan_id
		  and RPT_PERIOD_ID = vrptperiod_id;

	UPDATE camdecmpswks.EMISSION_VIEW_HICEMS 
		SET	CALC_HI_RATE = NULL,
			CALC_FLOW_BAF = NULL,
			ERROR_CODES = NULL
		where MON_PLAN_ID =vmonplan_id
		  and RPT_PERIOD_ID = vrptperiod_id;

	UPDATE camdecmpswks.EMISSION_VIEW_HIUNITSTACK
		SET	CALC_HI_RATE = NULL,
			ERROR_CODES = NULL
		where MON_PLAN_ID =vmonplan_id
		  and RPT_PERIOD_ID = vrptperiod_id;

	UPDATE camdecmpswks.EMISSION_VIEW_LME 
		SET	CALC_HEAT_INPUT = NULL,
			CALC_SO2_MASS = NULL,
			CALC_NOX_MASS = NULL,
			CALC_CO2_MASS = NULL,
			ERROR_CODES = NULL
		where MON_PLAN_ID =vmonplan_id
		  and RPT_PERIOD_ID = vrptperiod_id;

	UPDATE camdecmpswks.EMISSION_VIEW_MASSOILCALC 
		SET	CALC_VOLUMETRIC_OIL_FLOW = NULL,
			CALC_MASS_OIL_FLOW = NULL,
			ERROR_CODES = NULL
		where MON_PLAN_ID =vmonplan_id
		  and RPT_PERIOD_ID = vrptperiod_id;

	UPDATE camdecmpswks.EMISSION_VIEW_MOISTURE 
		SET	CALC_PCT_H2O = NULL,
			ERROR_CODES = NULL
		where MON_PLAN_ID =vmonplan_id
		  and RPT_PERIOD_ID = vrptperiod_id;

	UPDATE camdecmpswks.EMISSION_VIEW_NOXAPPEMIXEDFUEL
		SET	CALC_HI_RATE = NULL,
			CALC_NOX_EMISSION_RATE = NULL,
			CALC_NOX_MASS_RATE = NULL,
			ERROR_CODES = NULL
		where MON_PLAN_ID =vmonplan_id
		  and RPT_PERIOD_ID = vrptperiod_id;

	UPDATE camdecmpswks.EMISSION_VIEW_NOXAPPESINGLEFUEL 
		SET	CALC_HI_RATE = NULL,
			CALC_NOX_EMISSION_RATE = NULL,
			CALC_NOX_EMISSION_RATE_ALL_FUELS = NULL,
			CALC_HI_RATE_ALL_FUELS = NULL,
			CALC_NOX_MASS_ALL_FUELS = NULL,
			ERROR_CODES = NULL
		where MON_PLAN_ID =vmonplan_id
		  and RPT_PERIOD_ID = vrptperiod_id;

	UPDATE camdecmpswks.EMISSION_VIEW_NOXMASSCEMS 
		SET	CALC_NOX_BAF = NULL,
			CALC_FLOW_BAF = NULL,
			CALC_NOX_MASS = NULL,
			ERROR_CODES = NULL
		where MON_PLAN_ID =vmonplan_id
		  and RPT_PERIOD_ID = vrptperiod_id;

	UPDATE camdecmpswks.EMISSION_VIEW_NOXRATECEMS
		SET	CALC_UNADJ_NOX_RATE = NULL,
			CALC_NOX_BAF = NULL,
			CALC_ADJ_NOX_RATE = NULL,
			CALC_HI_RATE = NULL,
			CALC_NOX_MASS = NULL,
			ERROR_CODES = NULL
		where MON_PLAN_ID =vmonplan_id
		  and RPT_PERIOD_ID = vrptperiod_id;

	UPDATE camdecmpswks.EMISSION_VIEW_OTHERDAILY
		SET	ERROR_CODES = NULL
		where MON_PLAN_ID =vmonplan_id
		  and RPT_PERIOD_ID = vrptperiod_id;

	UPDATE camdecmpswks.EMISSION_VIEW_SO2APPD 
		SET	CALC_FUEL_FLOW = NULL,
			CALC_HI_RATE = NULL,
			CALC_SO2_MASS_RATE = NULL,
			CALC_SO2_MASS_RATE_ALL_FUELS = NULL,
			ERROR_CODES = NULL
		where MON_PLAN_ID =vmonplan_id
		  and RPT_PERIOD_ID = vrptperiod_id;

	UPDATE camdecmpswks.EMISSION_VIEW_SO2CEMS
		SET	CALC_ADJ_SO2 = NULL,
			CALC_SO2_MASS_RATE = NULL,
			CALC_HI_RATE = NULL,
			ERROR_CODES = NULL
		where MON_PLAN_ID =vmonplan_id
		  and RPT_PERIOD_ID = vrptperiod_id;

	UPDATE camdecmpswks.EMISSION_VIEW_ALL
		SET CALC_ADJ_NOX_RATE = NULL,
			CALC_CO2_MASS_RATE = NULL,
			CALC_HI_RATE = NULL,
			CALC_NOX_MASS = NULL,
			CALC_SO2_MASS_RATE = NULL,
			ERROR_CODES = NULL
		where MON_PLAN_ID =vmonplan_id
		  and RPT_PERIOD_ID = vrptperiod_id;

 return next;

exception when others then
    get stacked diagnostics error_msg := message_text;
    result = 'F';  
	error_msg :='From emissions_grid_remove_eval '||' '|| message_text;
	
   return next;
END;
$BODY$;
