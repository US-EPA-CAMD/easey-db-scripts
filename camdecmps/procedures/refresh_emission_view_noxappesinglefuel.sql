CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_noxappesinglefuel
(
    IN vmonplanid character varying,
    IN vrptperiodid NUMERIC
)
 LANGUAGE plpgsql
AS $procedure$
declare 
    monlocids text[];
BEGIN    
    select  array
            (
                select  MON_LOC_ID
                  from  camdecmps.MONITOR_PLAN_LOCATION
                 where  MON_PLAN_ID = vmonplanid
            )
      into  monLocIds;
    

    RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmps.EMISSION_VIEW_NOXAPPESINGLEFUEL	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;
    RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmps.EMISSION_VIEW_NOXAPPESINGLEFUEL(
		MON_PLAN_ID,
		MON_LOC_ID,
		RPT_PERIOD_ID,
		DATE_HOUR,
		OP_TIME,
		FUEL_SYS_ID,
		FUEL_TYPE,
		FUEL_USE_TIME,
		UNIT_LOAD,
		LOAD_UOM,
		CALC_HI_RATE,
		OPERATING_CONDITION_CD,
		SEGMENT_NUMBER,
		APP_E_SYS_ID,
		RPT_NOX_EMISSION_RATE,
		CALC_NOX_EMISSION_RATE,
		SUMMATION_FORMULA_CD,
		RPT_NOX_EMISSION_RATE_ALL_FUELS,
		CALC_NOX_EMISSION_RATE_ALL_FUELS,
		CALC_HI_RATE_ALL_FUELS,
		NOX_MASS_RATE_FORMULA_CD,
		RPT_NOX_MASS_ALL_FUELS,
		CALC_NOX_MASS_ALL_FUELS,
		ERROR_CODES
	)
    select  hod.MON_PLAN_ID, 
            hod.MON_LOC_ID, 
            hod.RPT_PERIOD_ID, 
            camdecmps.format_date_hour( hod.BEGIN_DATE, hod.BEGIN_HOUR, null ) as DATE_HOUR,
            hod.OP_TIME, 
            coalesce( ms.SYSTEM_IDENTIFIER, '' ) as FUEL_SYS_ID,
            hff.FUEL_CD as FUEL_TYPE,
            hff.FUEL_USAGE_TIME as FUEL_USE_TIME,
            hod.HR_LOAD as UNIT_LOAD, 
            hod.LOAD_UOM_CD as LOAD_UOM,
            hpff.HI_CALC_PARAM_VAL_FUEL as CALC_HI_RATE,
            hpff.NOXR_OPERATING_CONDITION_CD,
            hpff.NOXR_SEGMENT_NUM as SEGMENT_NUMBER,
            ms_noxr.SYSTEM_IDENTIFIER as APP_E_SYS_ID,
            hpff.NOXR_PARAM_VAL_FUEL as RPT_NOX_EMISSION_RATE,
            hpff.NOXR_CALC_PARAM_VAL_FUEL as CALC_NOX_EMISSION_RATE,
            noxr_mf.EQUATION_CD as SUMMATION_FORMULA_CD,
            dhv.NOXR_ADJUSTED_HRLY_VALUE as RPT_NOX_EMISSION_RATE_ALL_FUELS,
            dhv.NOXR_CALC_ADJUSTED_HRLY_VALUE as CALC_NOX_EMISSION_RATE_ALL_FUELS,
            case 
                when ( dhv.NOXR_HOUR_ID is not null )
                then dhv.HI_CALC_ADJUSTED_HRLY_VALUE
            end as CALC_HI_RATE_ALL_FUELS,
            nox_mf.EQUATION_CD as NOX_MASS_RATE_FORMULA_CD,
            dhv.NOX_ADJUSTED_HRLY_VALUE as RPT_NOX_MASS_ALL_FUELS,
            dhv.NOX_CALC_ADJUSTED_HRLY_VALUE as CALC_NOX_MASS_ALL_FUELS,
            hod.ERROR_CODES
      from  (
                select  sel.MON_PLAN_ID, 
                        hod.MON_LOC_ID, 
                        sel.RPT_PERIOD_ID,
                        hod.HOUR_ID,
                        hod.BEGIN_DATE,
                        hod.BEGIN_HOUR,
                        hod.OP_TIME,
                        hod.HR_LOAD,
                        hod.LOAD_UOM_CD,
                        ' ' as ERROR_CODES
                  from  (
                            select  vmonplanid as MON_PLAN_ID,
                                    vrptperiodid as RPT_PERIOD_ID
                        ) sel
                        join camdecmps.MONITOR_PLAN_LOCATION mpl
                          on mpl.MON_PLAN_ID = sel.MON_PLAN_ID
                        join camdecmps.EMISSION_EVALUATION ems
                          on ems.RPT_PERIOD_ID = sel.RPT_PERIOD_ID
                         and ems.MON_PLAN_ID = mpl.MON_PLAN_ID
                        join camdecmps.HRLY_OP_DATA hod 
                          on hod.rpt_period_id = ems.rpt_period_id
                         and hod.mon_loc_id = mpl.mon_loc_id
            ) as hod
            join camdecmps.HRLY_FUEL_FLOW hff
              on hff.HOUR_ID = hod.HOUR_ID
             and hff.MON_LOC_ID = hod.MON_LOC_ID
             and hff.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
            left join
            (
                select  hff.hrly_fuel_flow_id,
                        hff.hour_id,
                        hff.mon_loc_id,
                        hff.rpt_period_id,
                        noxr.hrly_fuel_flow_id          as noxr_hrly_fuel_flow_id,           
                        noxr.mon_sys_id                 as noxr_mon_sys_id,                  
                        noxr.mon_form_id                as noxr_mon_form_id,                 
                        noxr.param_val_fuel             as noxr_param_val_fuel,              
                        noxr.calc_param_val_fuel        as noxr_calc_param_val_fuel,         
                        noxr.segment_num                as noxr_segment_num,
                        noxr.operating_condition_cd     as noxr_operating_condition_cd,
                        hi.calc_param_val_fuel          as hi_calc_param_val_fuel
                  from  camdecmps.HRLY_FUEL_FLOW hff
                        left join
                        (
                            select  hrly_fuel_flow_id,
                                    mon_loc_id,
                                    rpt_period_id,
                                    mon_sys_id,
                                    mon_form_id,
                                    param_val_fuel,
                                    calc_param_val_fuel,
                                    segment_num,
                                    operating_condition_cd
                              from  camdecmps.HRLY_PARAM_FUEL_FLOW
                             where  mon_loc_id = any( monLocIds )
                               and  rpt_period_id = vrptperiodid
                               and  parameter_cd = 'NOXR'
                        ) noxr
                          on noxr.hrly_fuel_flow_id = hff.hrly_fuel_flow_id
                         and noxr.mon_loc_id = hff.mon_loc_id
                         and noxr.rpt_period_id = hff.rpt_period_id
                        left join
                        (
                            select  hrly_fuel_flow_id,
                                    mon_loc_id,
                                    rpt_period_id,
                                    calc_param_val_fuel
                              from  camdecmps.HRLY_PARAM_FUEL_FLOW
                             where  mon_loc_id = any( monLocIds )
                               and  rpt_period_id = vrptperiodid
                               and  parameter_cd = 'HI'
                        ) hi
                          on hi.hrly_fuel_flow_id = hff.hrly_fuel_flow_id
                         and hi.mon_loc_id = hff.mon_loc_id
                         and hi.rpt_period_id = hff.rpt_period_id
                 where  hff.MON_LOC_ID = any( monLocIds )
                   and  hff.RPT_PERIOD_ID = vrptperiodid
            ) hpff
              on hpff.HRLY_FUEL_FLOW_ID = hff.HRLY_FUEL_FLOW_ID
             and hpff.HOUR_ID = hff.HOUR_ID
             and hpff.MON_LOC_ID = hff.MON_LOC_ID
             and hpff.RPT_PERIOD_ID = hff.RPT_PERIOD_ID
            left join
            (
                select  hod.hour_id,
                        hod.mon_loc_id,
                        hod.rpt_period_id,
                        noxr.hour_id                    as noxr_hour_id,   
                        noxr.mon_sys_id                 as noxr_mon_sys_id,
                        noxr.mon_form_id                as noxr_mon_form_id,
                        noxr.adjusted_hrly_value        as noxr_adjusted_hrly_value,
                        noxr.calc_adjusted_hrly_value   as noxr_calc_adjusted_hrly_value,
                        hi.calc_adjusted_hrly_value     as hi_calc_adjusted_hrly_value,
                        nox.mon_form_id                 as nox_mon_form_id,
                        nox.adjusted_hrly_value         as nox_adjusted_hrly_value,
                        nox.calc_adjusted_hrly_value    as nox_calc_adjusted_hrly_value
                  from  camdecmps.HRLY_OP_DATA hod
                        left join
                        (
                            select  hour_id,
                                    mon_loc_id,
                                    rpt_period_id,
                                    mon_sys_id,
                                    mon_form_id,
                                    adjusted_hrly_value,
                                    calc_adjusted_hrly_value
                              from  camdecmps.DERIVED_HRLY_VALUE
                             where  mon_loc_id = any( monLocIds )
                               and  rpt_period_id = vrptperiodid
                               and  parameter_cd = 'NOXR'
                        ) noxr
                          on noxr.hour_id = hod.hour_id
                         and noxr.mon_loc_id = hod.mon_loc_id
                         and noxr.rpt_period_id = hod.rpt_period_id
                        left join
                        (
                            select  hour_id,
                                    mon_loc_id,
                                    rpt_period_id,
                                    calc_adjusted_hrly_value
                              from  camdecmps.DERIVED_HRLY_VALUE
                             where  mon_loc_id = any( monLocIds )
                               and  rpt_period_id = vrptperiodid
                               and  parameter_cd = 'HI'
                        ) hi
                          on hi.hour_id = hod.hour_id
                         and hi.mon_loc_id = hod.mon_loc_id
                         and hi.rpt_period_id = hod.rpt_period_id
                        left join
                        (
                            select  hour_id,
                                    mon_loc_id,
                                    rpt_period_id,
                                    mon_form_id,
                                    adjusted_hrly_value,
                                    calc_adjusted_hrly_value
                              from  camdecmps.DERIVED_HRLY_VALUE
                             where  mon_loc_id = any( monLocIds )
                               and  rpt_period_id = vrptperiodid
                               and  parameter_cd = 'NOX'
                        ) nox
                          on nox.hour_id = hod.hour_id
                         and nox.mon_loc_id = hod.mon_loc_id
                         and nox.rpt_period_id = hod.rpt_period_id
                 where  hod.MON_LOC_ID = any( monLocIds )
                   and  hod.RPT_PERIOD_ID = vrptperiodid
            ) dhv
              ON dhv.HOUR_ID = hod.HOUR_ID
             AND dhv.MON_LOC_ID = hod.MON_LOC_ID
             AND dhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
            left join camdecmps.MONITOR_SYSTEM ms
                on ms.MON_SYS_ID = hff.MON_SYS_ID
            left join camdecmps.MONITOR_SYSTEM ms_noxr
                on ms_noxr.MON_SYS_ID = hpff.NOXR_MON_SYS_ID
            left join camdecmps.MONITOR_FORMULA noxr_mf
                on noxr_mf.MON_FORM_ID = dhv.NOXR_MON_FORM_ID
            left join camdecmps.MONITOR_FORMULA nox_mf
                on nox_mf.MON_FORM_ID = dhv.NOX_MON_FORM_ID
     WHERE  hpff.noxr_hrly_fuel_flow_id is not null;

	


	


  RAISE NOTICE 'Refreshing view counts...';
  CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'NOXAPPESINGLEFUEL');
END
$procedure$
