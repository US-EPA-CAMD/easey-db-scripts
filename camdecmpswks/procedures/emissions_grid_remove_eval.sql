CREATE OR REPLACE PROCEDURE camdecmpswks.emissions_grid_remove_eval(
	monplanid varchar(200),
	reportperiod integer,
	INOUT p_V_RESULT  char(1),
	INOUT p_V_ERROR_MSG  varchar(200))
AS $$
BEGIN
	p_V_RESULT := 'F';
	p_V_ERROR_MSG := 'Not Executed';
	
	/****** Object:  StoredProcedure [UES].[EmissionsGridRemoveEval]    Script Date: 4/17/2023 11:32:30 AM ******/
	
	-- =====================================================================================
	-- Author:		Dwayne Whitten (Peter Robie updated to use XML table - 7/29/2011)
	-- Create date: 2008-03-01
	-- Description:	Clear error and calculated fields in Pre-rendered View Emissions tables.
	-- =====================================================================================

	--
	-- Expected XML structure is
	-- <MonitoringPlans>
	--   <MonitoringPlan MON_PLAN_ID="MDC-50103043449C4E92A6CC2A279C52F874" RPT_PERIOD_ID="68" />
	--   <MonitoringPlan MON_PLAN_ID="MDC-1CDDECD122944982AAA7B3376CC4D80A" RPT_PERIOD_ID="66" />
	-- </MonitoringPlans>
	--

	--
	-- NOTE: if you modify this, also check Client.DeleteEMGridTables procedure too!
	--
	
	
	BEGIN

		UPDATE em SET	CALC_HI_RATE = NULL,
			CALC_CO2_MASS_RATE = NULL,
			CALC_CO2_MASS_RATE_ALL_FUELS = NULL,
			ERROR_CODES = NULL
		FROM camdecmpswks.EMISSION_VIEW_CO2APPD em
			INNER JOIN (SELECT monplanid as MON_PLAN_ID, reportperiod as RPT_PERIOD_ID ) as MPs
				 on em.MON_PLAN_ID = MPs.MON_PLAN_ID and em.RPT_PERIOD_ID = MPs.RPT_PERIOD_ID;
	
		UPDATE em SET	CALC_PCT_CO2 = NULL,
			ERROR_CODES = NULL
		FROM camdecmpswks.EMISSION_VIEW_CO2CALC em
			INNER JOIN ( SELECT monplanid as MON_PLAN_ID, reportperiod as RPT_PERIOD_ID  ) as MPs
				 on em.MON_PLAN_ID = MPs.MON_PLAN_ID and em.RPT_PERIOD_ID = MPs.RPT_PERIOD_ID;

		UPDATE em SET	CALC_FLOW_BAF = NULL,
			CALC_CO2_MASS_RATE = NULL,
			ERROR_CODES = NULL
		FROM camdecmpswks.EMISSION_VIEW_CO2CEMS em
			INNER JOIN ( SELECT monplanid as MON_PLAN_ID, reportperiod as RPT_PERIOD_ID  ) as MPs
				 on em.MON_PLAN_ID = MPs.MON_PLAN_ID and em.RPT_PERIOD_ID = MPs.RPT_PERIOD_ID;

		UPDATE em SET	ERROR_CODES = NULL
		FROM camdecmpswks.EMISSION_VIEW_CO2DAILYFUEL em
			INNER JOIN ( SELECT monplanid as MON_PLAN_ID, reportperiod as RPT_PERIOD_ID  ) as MPs
				 on em.MON_PLAN_ID = MPs.MON_PLAN_ID and em.RPT_PERIOD_ID = MPs.RPT_PERIOD_ID;

		UPDATE em SET	CALC_TEST_RESULT = NULL,
			CALC_UPSCALE_CE_OR_MEAN_DIFF = NULL,
			CALC_UPSCALE_APS_IND = NULL,
			CALC_ZERO_CE_OR_MEAN_DIFF = NULL,
			CALC_ZERO_APS_IND = NULL,
			CALC_ONLINE_OFFLINE_IND = NULL,
			ERROR_CODES = NULL
		FROM camdecmpswks.EMISSION_VIEW_DAILYCAL em
			INNER JOIN ( SELECT monplanid as MON_PLAN_ID, reportperiod as RPT_PERIOD_ID  ) as MPs
				 on em.MON_PLAN_ID = MPs.MON_PLAN_ID and em.RPT_PERIOD_ID = MPs.RPT_PERIOD_ID;

		UPDATE em SET	CALC_FUEL_FLOW = NULL,
			CALC_HI_RATE = NULL,
			ERROR_CODES = NULL
		FROM camdecmpswks.EMISSION_VIEW_HIAPPD em
			INNER JOIN ( SELECT monplanid as MON_PLAN_ID, reportperiod as RPT_PERIOD_ID  ) as MPs
				 on em.MON_PLAN_ID = MPs.MON_PLAN_ID and em.RPT_PERIOD_ID = MPs.RPT_PERIOD_ID;

		UPDATE em SET	CALC_HI_RATE = NULL,
			CALC_FLOW_BAF = NULL,
			ERROR_CODES = NULL
		FROM camdecmpswks.EMISSION_VIEW_HICEMS em
			INNER JOIN ( SELECT monplanid as MON_PLAN_ID, reportperiod as RPT_PERIOD_ID  ) as MPs
				 on em.MON_PLAN_ID = MPs.MON_PLAN_ID and em.RPT_PERIOD_ID = MPs.RPT_PERIOD_ID;

		UPDATE em SET	CALC_HI_RATE = NULL,
			ERROR_CODES = NULL
		FROM camdecmpswks.EMISSION_VIEW_HIUNITSTACK em
			INNER JOIN ( SELECT monplanid as MON_PLAN_ID, reportperiod as RPT_PERIOD_ID  ) as MPs
				 on em.MON_PLAN_ID = MPs.MON_PLAN_ID and em.RPT_PERIOD_ID = MPs.RPT_PERIOD_ID;

		UPDATE em SET	CALC_HEAT_INPUT = NULL,
			CALC_SO2_MASS = NULL,
			CALC_NOX_MASS = NULL,
			CALC_CO2_MASS = NULL,
			ERROR_CODES = NULL
		FROM camdecmpswks.EMISSION_VIEW_LME em
			INNER JOIN ( SELECT monplanid as MON_PLAN_ID, reportperiod as RPT_PERIOD_ID  ) as MPs
				 on em.MON_PLAN_ID = MPs.MON_PLAN_ID and em.RPT_PERIOD_ID = MPs.RPT_PERIOD_ID;

		UPDATE em SET	CALC_VOLUMETRIC_OIL_FLOW = NULL,
			CALC_MASS_OIL_FLOW = NULL,
			ERROR_CODES = NULL
		FROM camdecmpswks.EMISSION_VIEW_MASSOILCALC em
			INNER JOIN ( SELECT monplanid as MON_PLAN_ID,reportperiod  as RPT_PERIOD_ID  ) as MPs
				 on em.MON_PLAN_ID = MPs.MON_PLAN_ID and em.RPT_PERIOD_ID = MPs.RPT_PERIOD_ID;

		UPDATE em SET	CALC_PCT_H2O = NULL,
			ERROR_CODES = NULL
		FROM camdecmpswks.EMISSION_VIEW_MOISTURE em
			INNER JOIN ( SELECT monplanid as MON_PLAN_ID, reportperiod as RPT_PERIOD_ID  ) as MPs
				 on em.MON_PLAN_ID = MPs.MON_PLAN_ID and em.RPT_PERIOD_ID = MPs.RPT_PERIOD_ID;

		UPDATE em SET	CALC_HI_RATE = NULL,
			CALC_NOX_EMISSION_RATE = NULL,
			CALC_NOX_MASS_RATE = NULL,
			ERROR_CODES = NULL
		FROM camdecmpswks.EMISSION_VIEW_NOXAPPEMIXEDFUEL em
			INNER JOIN ( SELECT monplanid as MON_PLAN_ID, reportperiod as RPT_PERIOD_ID  ) as MPs
				 on em.MON_PLAN_ID = MPs.MON_PLAN_ID and em.RPT_PERIOD_ID = MPs.RPT_PERIOD_ID;

		UPDATE em SET	CALC_HI_RATE = NULL,
			CALC_NOX_EMISSION_RATE = NULL,
			CALC_NOX_EMISSION_RATE_ALL_FUELS = NULL,
			CALC_HI_RATE_ALL_FUELS = NULL,
			CALC_NOX_MASS_ALL_FUELS = NULL,
			ERROR_CODES = NULL
		FROM camdecmpswks.EMISSION_VIEW_NOXAPPESINGLEFUEL em
			INNER JOIN ( SELECT monplanid as MON_PLAN_ID, reportperiod as RPT_PERIOD_ID ) as MPs
				 on em.MON_PLAN_ID = MPs.MON_PLAN_ID and em.RPT_PERIOD_ID = MPs.RPT_PERIOD_ID;

		UPDATE em SET	CALC_NOX_BAF = NULL,
			CALC_FLOW_BAF = NULL,
			CALC_NOX_MASS = NULL,
			ERROR_CODES = NULL
		FROM camdecmpswks.EMISSION_VIEW_NOXMASSCEMS em
			INNER JOIN ( SELECT monplanid as MON_PLAN_ID,reportperiod  as RPT_PERIOD_ID  ) as MPs
				 on em.MON_PLAN_ID = MPs.MON_PLAN_ID and em.RPT_PERIOD_ID = MPs.RPT_PERIOD_ID;

		UPDATE em SET	CALC_UNADJ_NOX_RATE = NULL,
			CALC_NOX_BAF = NULL,
			CALC_ADJ_NOX_RATE = NULL,
			CALC_HI_RATE = NULL,
			CALC_NOX_MASS = NULL,
			ERROR_CODES = NULL
		FROM camdecmpswks.EMISSION_VIEW_NOXRATECEMS em
			INNER JOIN ( SELECT monplanid as MON_PLAN_ID, reportperiod as RPT_PERIOD_ID  ) as MPs
				 on em.MON_PLAN_ID = MPs.MON_PLAN_ID and em.RPT_PERIOD_ID = MPs.RPT_PERIOD_ID;

		UPDATE em SET	ERROR_CODES = NULL
		FROM camdecmpswks.EMISSION_VIEW_OTHERDAILY em
			INNER JOIN ( SELECT monplanid as MON_PLAN_ID, reportperiod as RPT_PERIOD_ID  ) as MPs
				 on em.MON_PLAN_ID = MPs.MON_PLAN_ID and em.RPT_PERIOD_ID = MPs.RPT_PERIOD_ID;

		UPDATE em SET	CALC_FUEL_FLOW = NULL,
			CALC_HI_RATE = NULL,
			CALC_SO2_MASS_RATE = NULL,
			CALC_SO2_MASS_RATE_ALL_FUELS = NULL,
			ERROR_CODES = NULL
		FROM camdecmpswks.EMISSION_VIEW_SO2APPD em
			INNER JOIN ( SELECT monplanid as MON_PLAN_ID,reportperiod  as RPT_PERIOD_ID ) as MPs
				 on em.MON_PLAN_ID = MPs.MON_PLAN_ID and em.RPT_PERIOD_ID = MPs.RPT_PERIOD_ID;

		UPDATE em SET	CALC_ADJ_SO2 = NULL,
			CALC_SO2_MASS_RATE = NULL,
			CALC_HI_RATE = NULL,
			ERROR_CODES = NULL
		FROM camdecmpswks.EMISSION_VIEW_SO2CEMS em
			INNER JOIN ( SELECT monplanid as MON_PLAN_ID, reportperiod as RPT_PERIOD_ID  ) as MPs
				 on em.MON_PLAN_ID = MPs.MON_PLAN_ID and em.RPT_PERIOD_ID = MPs.RPT_PERIOD_ID;

		UPDATE em SET CALC_ADJ_NOX_RATE = NULL,
			CALC_CO2_MASS_RATE = NULL,
			CALC_HI_RATE = NULL,
			CALC_NOX_MASS = NULL,
			CALC_SO2_MASS_RATE = NULL,
			ERROR_CODES = NULL
		FROM camdecmpswks.EMISSION_VIEW_ALL em
			INNER JOIN ( SELECT monplanid as MON_PLAN_ID, reportperiod as RPT_PERIOD_ID  ) as MPs
				 on em.MON_PLAN_ID = MPs.MON_PLAN_ID and em.RPT_PERIOD_ID = MPs.RPT_PERIOD_ID;

		p_V_RESULT := 'T';
		p_V_ERROR_MSG := '';
	EXCEPTION WHEN OTHERS THEN
		p_V_ERROR_MSG := 'UES.' || Error_Procedure() || ': ' || ERROR_MESSAGE() || ' (' || cast(Error_Line() as varchar(30)) || ')';
		p_V_RESULT := 'F';
	END;
END;
$$ LANGUAGE plpgsql;
 

