CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_lme
(
    IN vmonplanid character varying,
    IN vrptperiodid NUMERIC
)
 LANGUAGE plpgsql
AS $procedure$
DECLARE
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
	DELETE FROM camdecmps.EMISSION_VIEW_LME	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;
    RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmps.EMISSION_VIEW_LME(		MON_PLAN_ID,		MON_LOC_ID,		RPT_PERIOD_ID,		DATE_HOUR,		OP_TIME,		UNIT_LOAD,		LOAD_UOM,		HOUR_ID,		HI_MODC,		RPT_HEAT_INPUT,		CALC_HEAT_INPUT,		SO2M_FUEL_TYPE,		SO2_EMISS_RATE,		RPT_SO2_MASS,		CALC_SO2_MASS,		NOXM_FUEL_TYPE,		OPERATING_CONDITION_CD,		NOX_EMISS_RATE,		RPT_NOX_MASS,		CALC_NOX_MASS,		CO2M_FUEL_TYPE,		CO2_EMISS_RATE,		RPT_CO2_MASS,		CALC_CO2_MASS,		ERROR_CODES	)SELECT  hod.MON_PLAN_ID, 
        hod.MON_LOC_ID, 
        hod.RPT_PERIOD_ID, 
        camdecmps.format_date_hour(hod.BEGIN_DATE, hod.BEGIN_HOUR, null) as DATE_HOUR,
        hod.OP_TIME, 
        hod.HR_LOAD as UNIT_LOAD, 
        hod.LOAD_UOM_CD as LOAD_UOM,
        hod.HOUR_ID, 
        dhv.HIT_MODC_CD as HI_MODC,
        dhv.HIT_ADJUSTED_HRLY_VALUE as RPT_HEAT_INPUT,
        dhv.HIT_CALC_ADJUSTED_HRLY_VALUE as CALC_HEAT_INPUT,
        dhv.SO2M_FUEL_CD as SO2M_FUEL_TYPE,
        so2r_md.DEFAULT_VALUE as SO2_EMISS_RATE,
        dhv.SO2M_ADJUSTED_HRLY_VALUE as RPT_SO2_MASS,
        dhv.SO2M_CALC_ADJUSTED_HRLY_VALUE as CALC_SO2_MASS,
        dhv.NOXM_FUEL_CD as NOXM_FUEL_TYPE,
        dhv.NOXM_OPERATING_CONDITION_CD as OPERATING_CONDITION_CD,
        case
            when noxr_md.MON_LOC_ID is not null then noxr_md.DEFAULT_VALUE
            when norx_md.MON_LOC_ID is not null then norx_md.DEFAULT_VALUE
            else null
        end as NOX_EMISS_RATE,
        dhv.NOXM_ADJUSTED_HRLY_VALUE as RPT_NOX_MASS,
        dhv.NOXM_CALC_ADJUSTED_HRLY_VALUE as CALC_NOX_MASS,
        dhv.CO2M_FUEL_CD as CO2M_FUEL_TYPE,
        co2r_md.DEFAULT_VALUE as CO2_EMISS_RATE,
        dhv.CO2M_ADJUSTED_HRLY_VALUE as RPT_CO2_MASS,
        dhv.CO2M_CALC_ADJUSTED_HRLY_VALUE as CALC_CO2_MASS,
        hod.ERROR_CODES
  FROM  (
            select  sel.MON_PLAN_ID, 
                    hod.MON_LOC_ID, 
                    sel.RPT_PERIOD_ID,
                    hod.HOUR_ID,
                    hod.BEGIN_DATE,
                    hod.BEGIN_HOUR,
                    hod.OP_TIME,
                    hod.HR_LOAD,
                    hod.LOAD_UOM_CD,
                    hod.LOAD_RANGE, 
                    hod.COMMON_STACK_LOAD_RANGE, 
                    hod.FUEL_CD,
                    hod.FC_FACTOR,
                    hod.FD_FACTOR,
                    hod.FW_FACTOR,
                    (
                        select  case when max( coalesce( sev.SEVERITY_LEVEL, 0 ) ) > 0 then 'Y' else null end
                          from  camdecmpsaux.CHECK_LOG chl
                                left join camdecmpsmd.SEVERITY_CODE sev
                                  on sev.SEVERITY_CD = chl.SEVERITY_CD
                         where  chl.CHK_SESSION_ID = ems.CHK_SESSION_ID
                           and  chl.MON_LOC_ID = hod.MON_LOC_ID
                           and  ( chl.OP_BEGIN_DATE < hod.BEGIN_DATE or ( chl.OP_BEGIN_DATE = hod.BEGIN_DATE and chl.OP_BEGIN_HOUR <= hod.BEGIN_HOUR ) )
                           and  ( chl.OP_END_DATE > hod.BEGIN_DATE or ( chl.OP_END_DATE = hod.BEGIN_DATE and chl.OP_END_HOUR >= hod.BEGIN_HOUR ) )
                    ) as ERROR_CODES
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
        join
        (
            select  hod.hour_id,
                    hod.mon_loc_id,
                    hod.rpt_period_id,
                    so2m.hour_id                     as so2m_hour_id,
                    so2m.mon_sys_id                  as so2m_mon_sys_id,
                    so2m.mon_form_id                 as so2m_mon_form_id,
                    so2m.adjusted_hrly_value         as so2m_adjusted_hrly_value,
                    so2m.calc_adjusted_hrly_value    as so2m_calc_adjusted_hrly_value,
                    so2m.unadjusted_hrly_value       as so2m_unadjusted_hrly_value,
                    so2m.calc_unadjusted_hrly_value  as so2m_calc_unadjusted_hrly_value,
                    so2m.applicable_bias_adj_factor  as so2m_applicable_bias_adj_factor,
                    so2m.calc_pct_moisture           as so2m_calc_pct_moisture,
                    so2m.calc_pct_diluent            as so2m_calc_pct_diluent,
                    so2m.pct_available               as so2m_pct_available,
                    so2m.segment_num                 as so2m_segment_num,
                    so2m.operating_condition_cd      as so2m_operating_condition_cd,
                    so2m.fuel_cd                     as so2m_fuel_cd,
                    so2m.modc_cd                     as so2m_modc_cd,
                    noxm.hour_id                     as noxm_hour_id,
                    noxm.mon_sys_id                  as noxm_mon_sys_id,
                    noxm.mon_form_id                 as noxm_mon_form_id,
                    noxm.adjusted_hrly_value         as noxm_adjusted_hrly_value,
                    noxm.calc_adjusted_hrly_value    as noxm_calc_adjusted_hrly_value,
                    noxm.unadjusted_hrly_value       as noxm_unadjusted_hrly_value,
                    noxm.calc_unadjusted_hrly_value  as noxm_calc_unadjusted_hrly_value,
                    noxm.applicable_bias_adj_factor  as noxm_applicable_bias_adj_factor,
                    noxm.calc_pct_moisture           as noxm_calc_pct_moisture,
                    noxm.calc_pct_diluent            as noxm_calc_pct_diluent,
                    noxm.pct_available               as noxm_pct_available,
                    noxm.segment_num                 as noxm_segment_num,
                    noxm.operating_condition_cd      as noxm_operating_condition_cd,
                    noxm.fuel_cd                     as noxm_fuel_cd,
                    noxm.modc_cd                     as noxm_modc_cd,
                    co2m.hour_id                     as co2m_hour_id,
                    co2m.mon_sys_id                  as co2m_mon_sys_id,
                    co2m.mon_form_id                 as co2m_mon_form_id,
                    co2m.adjusted_hrly_value         as co2m_adjusted_hrly_value,
                    co2m.calc_adjusted_hrly_value    as co2m_calc_adjusted_hrly_value,
                    co2m.unadjusted_hrly_value       as co2m_unadjusted_hrly_value,
                    co2m.calc_unadjusted_hrly_value  as co2m_calc_unadjusted_hrly_value,
                    co2m.applicable_bias_adj_factor  as co2m_applicable_bias_adj_factor,
                    co2m.calc_pct_moisture           as co2m_calc_pct_moisture,
                    co2m.calc_pct_diluent            as co2m_calc_pct_diluent,
                    co2m.pct_available               as co2m_pct_available,
                    co2m.segment_num                 as co2m_segment_num,
                    co2m.operating_condition_cd      as co2m_operating_condition_cd,
                    co2m.fuel_cd                     as co2m_fuel_cd,
                    co2m.modc_cd                     as co2m_modc_cd,
                    hit.hour_id                      as hit_hour_id,
                    hit.mon_sys_id                   as hit_mon_sys_id,
                    hit.mon_form_id                  as hit_mon_form_id,
                    hit.adjusted_hrly_value          as hit_adjusted_hrly_value,
                    hit.calc_adjusted_hrly_value     as hit_calc_adjusted_hrly_value,
                    hit.unadjusted_hrly_value        as hit_unadjusted_hrly_value,
                    hit.calc_unadjusted_hrly_value   as hit_calc_unadjusted_hrly_value,
                    hit.applicable_bias_adj_factor   as hit_applicable_bias_adj_factor,
                    hit.calc_pct_moisture            as hit_calc_pct_moisture,
                    hit.calc_pct_diluent             as hit_calc_pct_diluent,
                    hit.pct_available                as hit_pct_available,
                    hit.segment_num                  as hit_segment_num,
                    hit.operating_condition_cd       as hit_operating_condition_cd,
                    hit.fuel_cd                      as hit_fuel_cd,
                    hit.modc_cd                      as hit_modc_cd
              from  camdecmps.HRLY_OP_DATA hod
                    left join
                    (
                        select  hour_id,
                                mon_loc_id,
                                rpt_period_id,
                                mon_sys_id,
                                mon_form_id,
                                adjusted_hrly_value,
                                calc_adjusted_hrly_value,
                                unadjusted_hrly_value,
                                calc_unadjusted_hrly_value,
                                applicable_bias_adj_factor,
                                calc_pct_moisture,
                                calc_pct_diluent,
                                pct_available,
                                segment_num,
                                operating_condition_cd,
                                fuel_cd,
                                modc_cd
                          from  camdecmps.DERIVED_HRLY_VALUE
                         where  mon_loc_id = any( monlocids )
                           and  rpt_period_id = vrptperiodid
                           and  parameter_cd = 'SO2M'
                    ) so2m
                      on so2m.hour_id = hod.hour_id
                     and so2m.mon_loc_id = hod.mon_loc_id
                     and so2m.rpt_period_id = hod.rpt_period_id
                    left join
                    (
                        select  hour_id,
                                mon_loc_id,
                                rpt_period_id,
                                mon_sys_id,
                                mon_form_id,
                                adjusted_hrly_value,
                                calc_adjusted_hrly_value,
                                unadjusted_hrly_value,
                                calc_unadjusted_hrly_value,
                                applicable_bias_adj_factor,
                                calc_pct_moisture,
                                calc_pct_diluent,
                                pct_available,
                                segment_num,
                                operating_condition_cd,
                                fuel_cd,
                                modc_cd
                          from  camdecmps.DERIVED_HRLY_VALUE
                         where  mon_loc_id = any( monlocids )
                           and  rpt_period_id = vrptperiodid
                           and  parameter_cd = 'NOXM'
                    ) noxm
                      on noxm.hour_id = hod.hour_id
                     and noxm.mon_loc_id = hod.mon_loc_id
                     and noxm.rpt_period_id = hod.rpt_period_id
                    left join
                    (
                        select  hour_id,
                                mon_loc_id,
                                rpt_period_id,
                                mon_sys_id,
                                mon_form_id,
                                adjusted_hrly_value,
                                calc_adjusted_hrly_value,
                                unadjusted_hrly_value,
                                calc_unadjusted_hrly_value,
                                applicable_bias_adj_factor,
                                calc_pct_moisture,
                                calc_pct_diluent,
                                pct_available,
                                segment_num,
                                operating_condition_cd,
                                fuel_cd,
                                modc_cd
                          from  camdecmps.DERIVED_HRLY_VALUE
                         where  mon_loc_id = any( monlocids )
                           and  rpt_period_id = vrptperiodid
                           and  parameter_cd = 'CO2M'
                    ) co2m
                      on co2m.hour_id = hod.hour_id
                     and co2m.mon_loc_id = hod.mon_loc_id
                     and co2m.rpt_period_id = hod.rpt_period_id
                    left join
                    (
                        select  hour_id,
                                mon_loc_id,
                                rpt_period_id,
                                mon_sys_id,
                                mon_form_id,
                                adjusted_hrly_value,
                                calc_adjusted_hrly_value,
                                unadjusted_hrly_value,
                                calc_unadjusted_hrly_value,
                                applicable_bias_adj_factor,
                                calc_pct_moisture,
                                calc_pct_diluent,
                                pct_available,
                                segment_num,
                                operating_condition_cd,
                                fuel_cd,
                                modc_cd
                          from  camdecmps.DERIVED_HRLY_VALUE
                         where  mon_loc_id = any( monlocids )
                           and  rpt_period_id = vrptperiodid
                           and  parameter_cd = 'HIT'
                    ) hit
                      on hit.hour_id = hod.hour_id
                     and hit.mon_loc_id = hod.mon_loc_id
                     and hit.rpt_period_id = hod.rpt_period_id
             where  hod.MON_LOC_ID = any( monlocids )
               and  hod.RPT_PERIOD_ID = vrptperiodid
        ) dhv
          on dhv.HOUR_ID = hod.HOUR_ID
         and dhv.MON_LOC_ID = hod.MON_LOC_ID
         and dhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
        left join camdecmps.MONITOR_DEFAULT as so2r_md
          on so2r_md.MON_LOC_ID = hod.MON_LOC_ID
         and camdecmps.emissions_monitor_default_active(so2r_md.BEGIN_DATE, so2r_md.BEGIN_HOUR, so2r_md.END_DATE, so2r_md.END_HOUR, hod.BEGIN_DATE, hod.BEGIN_HOUR) = 1
         and so2r_md.DEFAULT_PURPOSE_CD = 'LM'
         and so2r_md.DEFAULT_UOM_CD = 'LBMMBTU'
         and so2r_md.FUEL_CD = dhv.SO2M_FUEL_CD 
         and so2r_md.PARAMETER_CD = 'SO2R'
        left join camdecmps.MONITOR_DEFAULT as noxr_md
          on noxr_md.MON_LOC_ID = hod.MON_LOC_ID
         and camdecmps.emissions_monitor_default_active(noxr_md.BEGIN_DATE, noxr_md.BEGIN_HOUR, noxr_md.END_DATE, noxr_md.END_HOUR, hod.BEGIN_DATE, hod.BEGIN_HOUR) = 1
         and noxr_md.PARAMETER_CD = 'NOXR'
         and noxr_md.DEFAULT_PURPOSE_CD = 'LM'
         and noxr_md.DEFAULT_UOM_CD = 'LBMMBTU'
         and noxr_md.FUEL_CD = dhv.NOXM_FUEL_CD 
         and noxr_md.OPERATING_CONDITION_CD != 'U'
         and noxr_md.OPERATING_CONDITION_CD = coalesce( dhv.noxm_operating_condition_cd, 'A' )  
        left join camdecmps.MONITOR_DEFAULT as norx_md 
          on norx_md.MON_LOC_ID = HOD.MON_LOC_ID 
         and camdecmps.emissions_monitor_default_active(norx_md.BEGIN_DATE, norx_md.BEGIN_HOUR, norx_md.END_DATE, norx_md.END_HOUR, HOD.BEGIN_DATE, HOD.BEGIN_HOUR) = 1 
         and norx_md.PARAMETER_CD = 'NORX'
         and norx_md.DEFAULT_PURPOSE_CD = 'MD' 
         and norx_md.DEFAULT_UOM_CD = 'LBMMBTU' 
         and norx_md.FUEL_CD = DHV.noxm_fuel_cd 
         and norx_md.OPERATING_CONDITION_CD = 'U' 
        left JOIN camdecmps.MONITOR_DEFAULT as co2r_md 
          on HOD.MON_LOC_ID = co2r_md.MON_LOC_ID
         and camdecmps.emissions_monitor_default_active(co2r_md.BEGIN_DATE, co2r_md.BEGIN_HOUR, co2r_md.END_DATE, co2r_md.END_HOUR, HOD.BEGIN_DATE, HOD.BEGIN_HOUR) = 1 
         and co2r_md.DEFAULT_PURPOSE_CD = 'LM' 
         and co2r_md.DEFAULT_UOM_CD ='TNMMBTU' 
         and co2r_md.FUEL_CD = DHV.co2m_fuel_cd 
         and co2r_md.PARAMETER_CD = 'CO2R'
    where dhv.so2m_hour_id is not null
       or dhv.noxm_hour_id is not null
       or dhv.co2m_hour_id is not null
       or dhv.hit_hour_id is not null;
    
    
    RAISE NOTICE 'Refreshing view counts...';
    CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'LME');
END
$procedure$
