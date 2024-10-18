CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_noxratecems
(
    IN vmonplanid character varying, 
    IN vrptperiodid numeric
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

	DELETE FROM camdecmps.EMISSION_VIEW_NOXRATECEMS 	WHERE MON_PLAN_ID = vmonplanid AND RPT_PERIOD_ID = vrptperiodid;

    RAISE NOTICE 'Refreshing view data...';

	INSERT INTO camdecmps.EMISSION_VIEW_NOXRATECEMS(		MON_PLAN_ID,		MON_LOC_ID,		RPT_PERIOD_ID,		DATE_HOUR,		OP_TIME,		UNIT_LOAD,		LOAD_UOM,		NOX_RATE_MODC,		NOX_RATE_PMA,		UNADJ_NOX,		NOX_MODC,		DILUENT_PARAM,		PCT_DILUENT_USED,		DILUENT_MODC,		RPT_DILUENT,		PCT_H2O_USED,		SOURCE_H2O_VALUE,		F_FACTOR,		NOX_RATE_FORMULA_CD,		RPT_UNADJ_NOX_RATE,		CALC_UNADJ_NOX_RATE,		CALC_NOX_BAF,		RPT_ADJ_NOX_RATE,		CALC_ADJ_NOX_RATE,		CALC_HI_RATE,		NOX_MASS_FORMULA_CD,		RPT_NOX_MASS,		CALC_NOX_MASS,		ERROR_CODES	)    select  HOD.MON_PLAN_ID, 
            HOD.MON_LOC_ID, 
            HOD.RPT_PERIOD_ID, 
            camdecmps.format_date_hour(hod.BEGIN_DATE, hod.BEGIN_HOUR, null),
            HOD.OP_TIME, 
            HOD.HR_LOAD as UNIT_LOAD, 
            HOD.LOAD_UOM_CD as LOAD_UOM, 
            DHV.NOXR_MODC_CD as NOX_RATE_MODC, 
            DHV.NOXR_PCT_AVAILABLE as NOX_RATE_PMA,
            MHV.NOXC_UNADJUSTED_HRLY_VALUE as UNADJ_NOX, 
            MHV.NOXC_MODC_CD as NOX_MODC, 
            case when (MF.EQUATION_CD in ('19-6', '19-7', '19-8', '19-9', 'F-6')) then 'CO2' 
                 when (MF.EQUATION_CD in ('19-1', '19-2', '19-3', '19-3D', '19-4', '19-5', '19-5D', 'F-5')) then 'O2' 
                 else null 
            end as DILUENT_PARAM, 
            DHV.NOXR_CALC_PCT_DILUENT as PCT_DILUENT_USED, 
            case when (MF.EQUATION_CD in ('19-6', '19-7', '19-8', '19-9', 'F-6')) then MHV.CO2C_MODC_CD
                 when (MF.EQUATION_CD in ('19-1', '19-4', 'F-5')) then MHV.O2C_D_MODC_CD
                 when (MF.EQUATION_CD in ('19-2', '19-3', '19-5', '19-3D', '19-5D')) then MHV.O2C_W_MODC_CD      
            end as DILUENT_MODC, 
            case when (MF.EQUATION_CD in ('19-6', '19-7', '19-8', '19-9', 'F-6')) then MHV.CO2C_UNADJUSTED_HRLY_VALUE
                 when (MF.EQUATION_CD in ('19-1', '19-4', 'F-5')) then MHV.O2C_D_UNADJUSTED_HRLY_VALUE
                 when (MF.EQUATION_CD in ('19-2', '19-3', '19-5', '19-3D', '19-5D')) then MHV.O2C_W_UNADJUSTED_HRLY_VALUE        
            end as RPT_DILUENT,
            DHV.NOXR_CALC_PCT_MOISTURE as PCT_H2O_USED, 
            case 
                when (DHV.NOXR_CALC_PCT_MOISTURE is not null) then 
                    case when (DHV.H2O_MODC_CD is not null) then DHV.H2O_MODC_CD 
                         when (MHV.H2O_MODC_CD is not null) then MHV.H2O_MODC_CD 
                         else 'DF'
                    end 
                else null
            end as SOURCE_H2O_VALUE, 
            case when (MF.EQUATION_CD in ('19-6', '19-7', '19-8', '19-9', 'F-6')) then HOD.FC_FACTOR 
                 when (MF.EQUATION_CD in ('19-1', '19-3', '19-3D', '19-4', '19-5', '19-5D', 'F-5')) then HOD.FD_FACTOR 
                 when (MF.EQUATION_CD = '19-2') then FW_FACTOR 
            end as F_FACTOR, 
            MF.EQUATION_CD as nox_rate_formula_cd, 
            DHV.NOXR_UNADJUSTED_HRLY_VALUE as RPT_UNADJ_NOX_RATE, 
            DHV.NOXR_CALC_UNADJUSTED_HRLY_VALUE as CALC_UNADJ_NOX_RATE, 
            DHV.NOXR_APPLICABLE_BIAS_ADJ_FACTOR as CALC_NOX_BAF, 
            DHV.NOXR_ADJUSTED_HRLY_VALUE as RPT_ADJ_NOX_RATE, 
            DHV.NOXR_CALC_ADJUSTED_HRLY_VALUE as CALC_ADJ_NOX_RATE, 
            case when NOX_MF.EQUATION_CD = 'F-24A' then DHV.HI_CALC_ADJUSTED_HRLY_VALUE 
                 else null
            end as CALC_HI_RATE, 
            case when NOX_MF.EQUATION_CD = 'F-24A' then NOX_MF.EQUATION_CD
                 else null
            end as nox_mass_formula_cd,
            case when NOX_MF.EQUATION_CD = 'F-24A' then DHV.NOX_ADJUSTED_HRLY_VALUE
                 else null
            end as RPT_NOX_MASS, 
            case when NOX_MF.EQUATION_CD = 'F-24A' then DHV.NOX_CALC_ADJUSTED_HRLY_VALUE
                 else null
            end as CALC_NOX_MASS, 
            HOD.ERROR_CODES
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
                        hod.LOAD_RANGE, 
                        hod.COMMON_STACK_LOAD_RANGE, 
                        hod.FUEL_CD,
                        hod.FC_FACTOR,
                        hod.FD_FACTOR,
                        hod.FW_FACTOR, 
                        (
                            select  case when max( coalesce( sev.SEVERITY_LEVEL, 0 ) ) > 0 then 'Y' else NULL end
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
            ) AS hod
            left join
            (
                select  hod.hour_id,
                        hod.mon_loc_id,
                        hod.rpt_period_id,
                        noxr.hour_id                      as noxr_hour_id,
                        noxr.mon_form_id                  as noxr_mon_form_id,
                        noxr.adjusted_hrly_value          as noxr_adjusted_hrly_value,
                        noxr.calc_adjusted_hrly_value     as noxr_calc_adjusted_hrly_value,
                        noxr.unadjusted_hrly_value        as noxr_unadjusted_hrly_value,
                        noxr.calc_unadjusted_hrly_value   as noxr_calc_unadjusted_hrly_value,
                        noxr.applicable_bias_adj_factor   as noxr_applicable_bias_adj_factor,
                        noxr.calc_pct_moisture            as noxr_calc_pct_moisture,
                        noxr.calc_pct_diluent             as noxr_calc_pct_diluent,
                        noxr.pct_available                as noxr_pct_available,
                        noxr.modc_cd                      as noxr_modc_cd,
                        hi.calc_adjusted_hrly_value       as hi_calc_adjusted_hrly_value,
                        nox.mon_form_id                   as nox_mon_form_id,
                        nox.adjusted_hrly_value           as nox_adjusted_hrly_value,
                        nox.calc_adjusted_hrly_value      as nox_calc_adjusted_hrly_value,
                        h2o.modc_cd                       as h2o_modc_cd
                  from  camdecmps.HRLY_OP_DATA hod
                        left join
                        (
                            select  hour_id,
                                    mon_loc_id,
                                    rpt_period_id,
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
                                    modc_cd
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
                        left join
                        (
                            select  hour_id,
                                    mon_loc_id,
                                    rpt_period_id,
                                    modc_cd
                              from  camdecmps.DERIVED_HRLY_VALUE
                             where  mon_loc_id = any( monLocIds )
                               and  rpt_period_id = vrptperiodid
                               and  parameter_cd = 'H2O'
                        ) h2o
                          on h2o.hour_id = hod.hour_id
                         and h2o.mon_loc_id = hod.mon_loc_id
                         and h2o.rpt_period_id = hod.rpt_period_id
                 where  hod.MON_LOC_ID = any( monLocIds )
                   and  hod.RPT_PERIOD_ID = vrptperiodid
            ) dhv
              ON dhv.HOUR_ID = hod.HOUR_ID
             and dhv.MON_LOC_ID = hod.MON_LOC_ID
             and dhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
            left join
            (
                select  hod.hour_id,
                        hod.mon_loc_id,
                        hod.rpt_period_id,
                        noxc.unadjusted_hrly_value        as noxc_unadjusted_hrly_value,
                        noxc.modc_cd                      as noxc_modc_cd,
                        co2c.unadjusted_hrly_value        as co2c_unadjusted_hrly_value,
                        co2c.modc_cd                      as co2c_modc_cd,
                        h2o.modc_cd                       as h2o_modc_cd,
                        o2c_d.hour_id                     as o2c_d_hour_id,
                        o2c_d.unadjusted_hrly_value       as o2c_d_unadjusted_hrly_value,
                        o2c_d.modc_cd                     as o2c_d_modc_cd,
                        o2c_w.hour_id                     as o2c_w_hour_id,
                        o2c_w.unadjusted_hrly_value       as o2c_w_unadjusted_hrly_value,
                        o2c_w.modc_cd                     as o2c_w_modc_cd
                  from  camdecmps.HRLY_OP_DATA hod
                        left join
                        (
                            select  hour_id,
                                    mon_loc_id,
                                    rpt_period_id,
                                    unadjusted_hrly_value,
                                    modc_cd
                              from  camdecmps.MONITOR_HRLY_VALUE
                             where  mon_loc_id = any( monLocIds )
                               and  rpt_period_id = vrptperiodid
                               and  parameter_cd = 'NOXC'
                               and  modc_cd not in ( '47', '48' )
                        ) noxc
                          on noxc.hour_id = hod.hour_id
                         and noxc.mon_loc_id = hod.mon_loc_id
                         and noxc.rpt_period_id = hod.rpt_period_id
                        left join
                        (
                            select  hour_id,
                                    mon_loc_id,
                                    rpt_period_id,
                                    unadjusted_hrly_value,
                                    modc_cd
                              from  camdecmps.MONITOR_HRLY_VALUE
                             where  mon_loc_id = any( monLocIds )
                               and  rpt_period_id = vrptperiodid
                               and  parameter_cd = 'CO2C'
                               and  modc_cd not in ( '47', '48' )
                        ) co2c
                          on co2c.hour_id = hod.hour_id
                         and co2c.mon_loc_id = hod.mon_loc_id
                         and co2c.rpt_period_id = hod.rpt_period_id
                        left join
                        (
                            select  hour_id,
                                    mon_loc_id,
                                    rpt_period_id,
                                    modc_cd
                              from  camdecmps.MONITOR_HRLY_VALUE
                             where  mon_loc_id = any( monLocIds )
                               and  rpt_period_id = vrptperiodid
                               and  parameter_cd = 'H2O'
                        ) h2o
                          on h2o.hour_id = hod.hour_id
                         and h2o.mon_loc_id = hod.mon_loc_id
                         and h2o.rpt_period_id = hod.rpt_period_id
                        left join
                        (
                            select  hour_id,
                                    mon_loc_id,
                                    rpt_period_id,
                                    unadjusted_hrly_value,
                                    modc_cd
                              from  camdecmps.MONITOR_HRLY_VALUE
                             where  mon_loc_id = any( monLocIds )
                               and  rpt_period_id = vrptperiodid
                               and  parameter_cd = 'O2C'
                               and  moisture_basis = 'D'
                               and  modc_cd not in ( '47', '48' )
                        ) o2c_d
                          on o2c_d.hour_id = hod.hour_id
                         and o2c_d.mon_loc_id = hod.mon_loc_id
                         and o2c_d.rpt_period_id = hod.rpt_period_id
                        left join
                        (
                            select  hour_id,
                                    mon_loc_id,
                                    rpt_period_id,
                                    unadjusted_hrly_value,
                                    modc_cd
                              from  camdecmps.MONITOR_HRLY_VALUE
                             where  mon_loc_id = any( monLocIds )
                               and  rpt_period_id = vrptperiodid
                               and  parameter_cd = 'O2C'
                               and  moisture_basis = 'W'
                               and  modc_cd not in ( '47', '48' )
                        ) o2c_w
                          on o2c_w.hour_id = hod.hour_id
                         and o2c_w.mon_loc_id = hod.mon_loc_id
                         and o2c_w.rpt_period_id = hod.rpt_period_id
                 where  hod.MON_LOC_ID = any( monLocIds )
                   and  hod.RPT_PERIOD_ID = vrptperiodid
            ) mhv
              ON mhv.HOUR_ID = hod.HOUR_ID
             and mhv.MON_LOC_ID = hod.MON_LOC_ID
             and mhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
            left join camdecmps.MONITOR_FORMULA mf
              ON mf.MON_FORM_ID = dhv.NOXR_MON_FORM_ID
            left join camdecmps.MONITOR_FORMULA nox_mf
              ON nox_mf.MON_FORM_ID = dhv.NOX_MON_FORM_ID
     where dhv.noxr_modc_cd is not null and dhv.noxr_hour_id is not null;
	    
    
    RAISE NOTICE 'Refreshing view counts...';

    CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'NOXRATECEMS');
END
$procedure$
