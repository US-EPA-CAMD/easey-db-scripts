CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_matshg
(
    IN vmonplanid character varying,
    IN vrptperiodid numeric
)
 LANGUAGE plpgsql
AS $procedure$
DECLARE  
BEGIN
    RAISE NOTICE 'Deleting existing records...';
	DELETE
      FROM  camdecmpswks.EMISSION_VIEW_MATSHG
	 WHERE  MON_PLAN_ID = vMonPlanId
       AND  RPT_PERIOD_ID = vRptPeriodId;
    RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmpswks.EMISSION_VIEW_MATSHG(		MON_PLAN_ID,		MON_LOC_ID,		RPT_PERIOD_ID,		DATE_HOUR,		OP_TIME,		MATS_LOAD,		MATS_STARTUP_SHUTDOWN,		HG_CONC_VALUE,		HG_CONC_SYSTEM_ID,		HG_CONC_SYS_TYPE,		HG_CONC_MODC_CD,		HG_CONC_PMA,		SAMPLING_TRAIN_COMP_ID1,		GAS_FLOWMETER_READING1,		RATIO_STACK_GAS_FLOW_RATE1,		SAMPLING_TRAIN_COMP_ID2,		GAS_FLOWMETER_READING2,		RATIO_STACK_GAS_FLOW_RATE2,		FLOW_RATE,		FLOW_MODC,		FLOW_PMA,		RPT_PCT_DILUENT,		DILUENT_PARAMETER,		CALC_PCT_DILUENT,		DILUENT_MODC,		CALC_PCT_H2O,		H2O_SOURCE,		F_FACTOR,		HG_FORMULA_CD,		RPT_HG_RATE,		CALC_HG_RATE,		HG_UOM,		HG_MODC_CD,		ERROR_CODES	)with
    -- Get Component 1 and 2 for each sorbent trap
    cmp as
    (
        select  sel.mon_sys_id,
                ( sel.begin_date + sel.begin_hour * interval '1 hour' ) as begin_date_hour,
                ( sel.end_date + sel.end_hour * interval '1 hour' ) as end_date_hour,
                cp1.component_id as component_id_1,
                sel.component_identifier_1,
                cp2.component_id as component_id_2,
                sel.component_identifier_2
          from  (
                    select  trp.mon_loc_id,
                            trp.mon_sys_id,
                            trp.begin_date,
                            trp.begin_hour,
                            trp.end_date,
                            trp.end_hour,
                            min( cmp.component_identifier ) as component_identifier_1,
                            max( cmp.component_identifier ) as component_identifier_2
                      from  (
                                select  vmonplanid as mon_plan_id,
                                        vrptperiodid as rpt_period_id
                            ) par
                            join camdecmpswks.EMISSION_EVALUATION ems
                              on ems.rpt_period_id = par.rpt_period_id
                             and ems.mon_plan_id = par.mon_plan_id
                            join camdecmpsmd.REPORTING_PERIOD prd
                              on prd.rpt_period_id = ems.rpt_period_id
                            join camdecmpswks.MONITOR_PLAN_LOCATION mpl
                              on mpl.mon_plan_id= ems.mon_plan_id 
                            join camdecmpswks.SORBENT_TRAP trp
                              on trp.rpt_period_id = ems.rpt_period_id 
                             and trp.mon_loc_id = mpl.mon_loc_id
                             and trp.begin_date <= prd.end_date
                             and trp.end_date >= prd.begin_date
                            join camdecmpswks.SAMPLING_TRAIN trn
                              on trn.rpt_period_id = ems.rpt_period_id 
                             and trn.trap_id = trp.trap_id
                            join camdecmpswks.COMPONENT cmp
                              on cmp.component_id = trn.component_id
                     where  par.RPT_PERIOD_ID = vrptperiodid
                     group 
                        by  trp.mon_loc_id,
                            trp.mon_sys_id,
                            trp.begin_date,
                            trp.begin_hour,
                            trp.end_date,
                            trp.end_hour
                ) sel
                left join camdecmpswks.COMPONENT cp1
                  on cp1.mon_loc_id = sel.mon_loc_id
                 and cp1.component_identifier = sel.component_identifier_1
                left join camdecmpswks.COMPONENT cp2
                  on cp2.mon_loc_id = sel.mon_loc_id
                 and cp2.component_identifier = sel.component_identifier_2
    )
    select  -- Use distinct to eliminate duplicates created by overlapping sorbent traps for the same system
            distinct
            dat.mon_plan_id, 
            dat.mon_loc_id, 
            dat.rpt_period_id,
            camdecmpswks.format_date_hour( dat.begin_date, dat.begin_hour, NULL ) as date_hour,
            dat.op_time,
            dat.mats_load,
            dat.mats_startup_shutdown_flg as mats_startup_shutdown,
            dat.hgc_unadjusted_hrly_value as hg_conc_value, 
            sys.system_identifier as hg_conc_system_id, 
            stc.sys_type_description as hg_conc_sys_type,
            dat.hgc_modc_cd as hg_conc_modc_cd,
            dat.hgc_pct_available as hg_conc_pma,
            cmp.component_identifier_1 as sampling_train_comp_id1,
            gfm1.gfm_reading as gas_flowmeter_reading1,
            gfm1.flow_to_sampling_ratio as ratio_stack_gas_flow_rate1,
            cmp.component_identifier_2 as sampling_train_comp_id2,
            gfm2.gfm_reading as gas_flowmeter_reading2,
            gfm2.flow_to_sampling_ratio as ratio_stack_gas_flow_rate2,
            dat.flow_unadjusted_hrly_value as flow_rate,
            dat.flow_modc_cd as flow_modc,
            dat.flow_pct_available as flow_pma,
            case
                when (dat.hgr_parameter_cd in ('HCLRE', 'HFRE', 'HGRE' )) then NULL
                when (dat.hgr_parameter_cd in ('HCLRH', 'HFRH', 'HGRH' )) then 
                    case 
                        when frm.equation_cd IN ('19-6', '19-7', '19-8', '19-9') then dat.co2c_unadjusted_hrly_value
                        when frm.equation_cd IN ('19-1', '19-4') then dat.o2d_unadjusted_hrly_value
                        when frm.equation_cd IN ('19-2', '19-3', '19-3D', '19-5', '19-5D') then dat.o2w_unadjusted_hrly_value
                        else NULL
                    end
                else NULL
            end as rpt_pct_diluent,
            case
                when (dat.hgr_parameter_cd in ('HCLRE', 'HFRE', 'HGRE' )) then NULL
                when (dat.hgr_parameter_cd in ('HCLRH', 'HFRH', 'HGRH' )) then 
                    case
                        when frm.equation_cd in ('19-6', '19-7', '19-8', '19-9') then 'CO2'
                        when frm.equation_cd in ('19-1', '19-2', '19-3', '19-3D', '19-4', '19-5', '19-5D') then 'O2'
                        else NULL
                    end
                else NULL
            end as diluent_parameter,
            dat.hgr_calc_pct_diluent as calc_pct_diluent,
            case
                when (dat.hgr_parameter_cd in ('HCLRE', 'HFRE', 'HGRE' )) then NULL
                when (dat.hgr_parameter_cd in ('HCLRH', 'HFRH', 'HGRH' )) then 
                    case
                        when frm.equation_cd IN ('19-6', '19-7', '19-8', '19-9') then dat.co2c_modc_cd 
                        when frm.equation_cd IN ('19-1', '19-4') then dat.o2d_modc_cd
                        when frm.equation_cd IN ('19-2', '19-3', '19-3D', '19-5', '19-5D') then dat.o2w_modc_cd
                        else NULL
                    end
                else NULL
            end as diluent_modc,
            dat.hgr_calc_pct_moisture as calc_pct_h2o,
            case 
                when dat.hgr_calc_pct_moisture IS NULL then NULL 
                when dat.h2od_modc_cd is not NULL then dat.h2od_modc_cd
                when dat.h2om_modc_cd is not NULL then dat.h2om_modc_cd
                else 'df'
            end as h2o_source,
            case
                when (dat.hgr_parameter_cd in ('HCLRE', 'HFRE', 'HGRE' )) then NULL
                when (dat.hgr_parameter_cd in ('HCLRH', 'HFRH', 'HGRH' )) then 
                    case
                        when frm.equation_cd IN ('19-6', '19-7', '19-8', '19-9') then dat.FC_FACTOR
                        when frm.equation_cd IN ('19-1', '19-3', '19-3D', '19-4', '19-5', '19-5D') then dat.FD_FACTOR
                        when frm.equation_cd IN ('19-2') then dat.FW_FACTOR
                        else NULL
                    end
                else NULL
            end as f_factor,
            frm.equation_cd as hg_formula_cd,
            dat.hgr_unadjusted_hrly_value as rpt_hg_rate,
            dat.hgr_calc_unadjusted_hrly_value as calc_hg_rate,
            case
                when dat.hgr_parameter_cd = 'HGRE' then 'lb/GWh'
                when dat.hgr_parameter_cd = 'HGRH' then 'lb/TBtu'
                when dat.hgr_parameter_cd in ('HCLRE', 'HFRE', 'SO2RE') then 'lb/MWh'
                when dat.hgr_parameter_cd in ('HCLRH', 'HFRH', 'SO2RH') then 'lb/mmBtu'
            end as hg_uom,
            dat.hgr_modc_cd as hg_modc_cd,
            (
                select  case when max( coalesce( sev.SEVERITY_LEVEL, 0 ) ) > 0 then 'Y' else NULL end
                  from  camdecmpswks.CHECK_LOG chl
                        left join camdecmpsmd.SEVERITY_CODE sev
                          on sev.severity_cd = chl.severity_cd
                 where  chl.chk_session_id = dat.chk_session_id
                   and  chl.mon_loc_id = dat.mon_loc_id
                   and  ( chl.op_begin_date < dat.begin_date or ( chl.op_begin_date = dat.begin_date and chl.op_begin_hour <= dat.begin_hour ) )
                   and  ( chl.op_end_date > dat.begin_date or ( chl.op_end_date = dat.begin_date and chl.op_end_hour >= dat.begin_hour ) )
            ) as error_codes
      from  (
                select  mpl.mon_plan_id,
                        hod.mon_loc_id,
                        hod.rpt_period_id,
                        hod.hour_id,
                        hod.begin_date,
                        hod.begin_hour,
                        hod.op_time,
                        hod.mats_load,
                        hod.mats_startup_shutdown_flg,
                        hod.fc_factor,
                        hod.fd_factor,
                        hod.fw_factor,
                        -- HGRE or HGRH Dervied Columns
                        hgr.parameter_cd as hgr_parameter_cd,
                        hgr.unadjusted_hrly_value as hgr_unadjusted_hrly_value,
                        hgr.calc_unadjusted_hrly_value as hgr_calc_unadjusted_hrly_value,
                        hgr.modc_cd as hgr_modc_cd,
                        hgr.calc_pct_diluent as hgr_calc_pct_diluent, 
                        hgr.calc_pct_moisture as hgr_calc_pct_moisture,
                        hgr.mon_form_id as hgr_mon_form_id,
                        -- HGC Monitor Columns
                        hgc.unadjusted_hrly_value as hgc_unadjusted_hrly_value,
                        hgc.modc_cd as hgc_modc_cd,
                        hgc.pct_available as hgc_pct_available,
                        hgc.mon_sys_id as hgc_mon_sys_id,
                        -- H2O Derived and Monitor Columns
                        h2od.modc_cd as h2od_modc_cd,
                        max( case when mhv.parameter_cd = 'H2O' then mhv.modc_cd end ) as h2om_modc_cd,
                        -- CO2C Monitor Columns
                        max( case when mhv.parameter_cd = 'CO2C' then mhv.unadjusted_hrly_value end ) as co2c_unadjusted_hrly_value,
                        max( case when mhv.parameter_cd = 'CO2C' then mhv.modc_cd end ) as co2c_modc_cd,
                        -- FLOW Monitor Columns
                        max( case when mhv.parameter_cd = 'FLOW' then mhv.unadjusted_hrly_value end ) as flow_unadjusted_hrly_value,
                        max( case when mhv.parameter_cd = 'FLOW' then mhv.modc_cd end ) as flow_modc_cd,
                        max( case when mhv.parameter_cd = 'FLOW' then mhv.pct_available end ) as flow_pct_available,
                        -- O2 Dry Monitor Columns
                        max( case when mhv.parameter_cd = 'O2' and mhv.moisture_basis = 'D' then mhv.unadjusted_hrly_value end ) as o2d_unadjusted_hrly_value,
                        max( case when mhv.parameter_cd = 'O2' and mhv.moisture_basis = 'D' then mhv.modc_cd end ) as o2d_modc_cd,
                        -- O2 Wet Monitor Columns
                        max( case when mhv.parameter_cd = 'O2' and mhv.moisture_basis = 'W' then mhv.unadjusted_hrly_value end ) as o2w_unadjusted_hrly_value,
                        max( case when mhv.parameter_cd = 'O2' and mhv.moisture_basis = 'W' then mhv.modc_cd end ) as o2w_modc_cd,
                        -- Error Information
                        ems.chk_Session_Id
                  from  (
                            select  vmonplanid as mon_plan_id,
                                    vrptperiodid as rpt_period_id
                        ) par
                        join camdecmpswks.EMISSION_EVALUATION ems
                          on ems.rpt_period_id = par.rpt_period_id
                         and ems.mon_plan_id = par.mon_plan_id
                        join camdecmpswks.MONITOR_PLAN_LOCATION mpl
                          on mpl.mon_plan_id= ems.mon_plan_id 
                        join camdecmpswks.HRLY_OP_DATA hod
                          on hod.rpt_period_id = ems.rpt_period_id 
                         and hod.mon_loc_id = mpl.mon_loc_id 
                        join camdecmpswks.MATS_DERIVED_HRLY_VALUE hgr
                          on hgr.rpt_period_id = hod.rpt_period_id 
                         and hgr.hour_id = hod.hour_id 
                         and hgr.parameter_cd in ( 'HGRE', 'HGRH' )
                        join camdecmpswks.MATS_MONITOR_HRLY_VALUE hgc
                          on hgc.rpt_period_id = hod.rpt_period_id 
                         and hgc.hour_id = hod.hour_id 
                         and hgc.parameter_cd = 'HGC'
                        left join camdecmpswks.DERIVED_HRLY_VALUE h2od
                          on h2od.rpt_period_id = hod.rpt_period_id 
                         and h2od.hour_id = hod.hour_id 
                         and h2od.parameter_cd = 'H2O'
                        left join camdecmpswks.MONITOR_HRLY_VALUE mhv
                          on mhv.rpt_period_id = hod.rpt_period_id 
                         and mhv.hour_id = hod.hour_id
                         and mhv.parameter_cd in ( 'CO2C', 'FLOW', 'H2O', 'O2' )
                         and ( mhv.parameter_cd != 'O2' or mhv.moisture_basis in ( 'D', 'W' ) )
                 group
                    by  mpl.mon_plan_id,
                        hod.mon_loc_id,
                        hod.rpt_period_id,
                        hod.hour_id,
                        hod.begin_date,
                        hod.begin_hour,
                        hod.op_time,
                        hod.mats_load,
                        hod.mats_startup_shutdown_flg,
                        hod.fc_factor,
                        hod.fd_factor,
                        hod.fw_factor,
                        hgr.parameter_cd,
                        hgr.unadjusted_hrly_value,
                        hgr.calc_unadjusted_hrly_value,
                        hgr.modc_cd,
                        hgr.calc_pct_diluent, 
                        hgr.calc_pct_moisture,
                        hgr.mon_form_id,
                        hgc.unadjusted_hrly_value,
                        hgc.modc_cd,
                        hgc.pct_available,
                        hgc.mon_sys_id,
                        h2od.modc_cd,
                        ems.chk_Session_Id
            ) dat
            left join camdecmpswks.MONITOR_FORMULA frm
              on frm.mon_form_id = dat.hgr_mon_form_id
            left join camdecmpswks.MONITOR_SYSTEM sys
              on sys.mon_sys_id = dat.hgc_mon_sys_id
            left join camdecmpsmd.SYSTEM_TYPE_CODE stc
              on stc.sys_type_cd = sys.sys_type_cd
            left join cmp
              on cmp.mon_sys_id = dat.hgc_mon_sys_id
             and ( dat.begin_date + dat.begin_hour * interval '1 hour' ) between cmp.begin_date_hour and cmp.end_date_hour
            left join camdecmpswks.HRLY_GAS_FLOW_METER gfm1
              on gfm1.rpt_period_id = dat.rpt_period_id
             and gfm1.mon_loc_id = dat.mon_loc_id
             and gfm1.hour_id = dat.hour_id
             and gfm1.component_id = cmp.component_id_1
             and gfm1.rpt_period_id = vrptperiodid
            left join camdecmpswks.HRLY_GAS_FLOW_METER gfm2
              on gfm2.rpt_period_id = dat.rpt_period_id
             and gfm2.mon_loc_id = dat.mon_loc_id
             and gfm2.hour_id = dat.hour_id
             and gfm2.component_id = cmp.component_id_2
             and gfm2.rpt_period_id = vrptperiodid
     order
        by  mon_plan_id, 
            mon_loc_id, 
            rpt_period_id,
            date_hour;
    
    RAISE NOTICE 'Refreshing view counts...';
    CALL camdecmpswks.refresh_emission_view_count(vmonplanid, vrptperiodid, 'MATSHG');
END
$procedure$
