CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_matshf
(
    IN vmonplanid character varying,
    IN vrptperiodid NUMERIC
)
 LANGUAGE plpgsql
AS $procedure$
DECLARE
BEGIN
    RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmps.EMISSION_VIEW_MATSHF	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;

    RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmps.EMISSION_VIEW_MATSHF(		MON_PLAN_ID,		MON_LOC_ID,		RPT_PERIOD_ID,		DATE_HOUR,		OP_TIME,		MATS_LOAD,		MATS_STARTUP_SHUTDOWN,		HF_CONC_VALUE,		HF_CONC_MODC_CD,		HF_CONC_PMA,		FLOW_RATE,		FLOW_MODC,		FLOW_PMA,		RPT_PCT_DILUENT,		DILUENT_PARAMETER,		CALC_PCT_DILUENT,		DILUENT_MODC,		CALC_PCT_H2O,		H2O_SOURCE,		F_FACTOR,		HF_FORMULA_CD,		RPT_HF_RATE,		CALC_HF_RATE,		HF_UOM,		HF_MODC_CD,		ERROR_CODES	)    select  dat.MON_PLAN_ID,
            dat.MON_LOC_ID,
            dat.RPT_PERIOD_ID,
            camdecmps.format_date_hour( dat.BEGIN_DATE, dat.BEGIN_HOUR, null ) as DATE_HOUR,
            dat.OP_TIME,
            dat.MATS_LOAD,
            dat.MATS_STARTUP_SHUTDOWN,
            dat.HFC_UNADJUSTED_HRLY_VALUE as HF_CONC_VALUE, 
            dat.HFC_MODC_CD as HF_CONC_MODC_CD,
            dat.HFC_PCT_AVAILABLE as HF_CONC_PMA,
            dat.FLOW_UNADJUSTED_HRLY_VALUE as FLOW_RATE,
            dat.FLOW_MODC_CD as FLOW_MODC,
            dat.FLOW_PCT_AVAILABLE as FLOW_PMA,
            case 
                when ( dat.HFRE_IND = 1 ) then null
                when ( dat.HFRH_IND = 1 ) then
                    case
                        when dat.HFRH_FORMULA_CD in ( '19-6', '19-7', '19-8', '19-9' ) then dat.CO2C_UNADJUSTED_HRLY_VALUE
                        when dat.HFRH_FORMULA_CD in ( '19-1', '19-4' ) then dat.O2D_UNADJUSTED_HRLY_VALUE
                        when dat.HFRH_FORMULA_CD in ( '19-2', '19-3', '19-3D', '19-5', '19-5D' ) then dat.O2W_UNADJUSTED_HRLY_VALUE
                        else null
                    end
                else null
            end as RPT_PCT_DILUENT,
            case
                when ( dat.HFRE_IND = 1 ) then null
                when ( dat.HFRH_IND = 1 ) then
                    case
                        when dat.HFRH_FORMULA_CD in ( '19-6', '19-7', '19-8', '19-9' ) then 'CO2'
                        when dat.HFRH_FORMULA_CD in ( '19-1', '19-2', '19-3', '19-3D', '19-4', '19-5', '19-5D' ) then 'O2'
                        else null
                    end
                else null
            end as DILUENT_PARAMETER,
            case
                when ( dat.HFRE_IND = 1 ) then dat.HFRE_CALC_PCT_DILUENT
                when ( dat.HFRH_IND = 1 ) then dat.HFRH_CALC_PCT_DILUENT
            end as CALC_PCT_DILUENT,
            case
                when ( dat.HFRE_IND = 1 ) then null
                when ( dat.HFRH_IND = 1 ) then
                    case
                        when dat.HFRH_FORMULA_CD in ( '19-6', '19-7', '19-8', '19-9' ) then dat.CO2C_MODC_CD 
                        when dat.HFRH_FORMULA_CD in ( '19-1', '19-4' ) then dat.O2D_MODC_CD
                        when dat.HFRH_FORMULA_CD in ( '19-2', '19-3', '19-3D', '19-5', '19-5D' ) then dat.O2W_MODC_CD
                        else null
                    end
                else null
            end as DILUENT_MODC,
            case
                when ( dat.HFRE_IND = 1 ) then dat.HFRE_CALC_PCT_MOISTURE
                when ( dat.HFRH_IND = 1 ) then dat.HFRH_CALC_PCT_MOISTURE
            end as CALC_PCT_H2O,
            case
                when ( dat.HFRE_IND = 1 ) and ( dat.HFRE_CALC_PCT_MOISTURE is null ) then null
                when ( dat.HFRH_IND = 1 ) and ( dat.HFRH_CALC_PCT_MOISTURE is null ) then null
                when ( dat.H2O_DHV_MODC_CD is not null ) then dat.H2O_DHV_MODC_CD
                when ( dat.H2O_MHV_MODC_CD is not null ) then dat.H2O_MHV_MODC_CD
                else 'DF'
            end as H2O_SOURCE,
            case
                when ( dat.HFRE_IND = 1 ) then null
                when ( dat.HFRH_IND = 1 ) then
                    case
                        when dat.HFRH_FORMULA_CD in ( '19-6', '19-7', '19-8', '19-9' ) then dat.FC_FACTOR
                        when dat.HFRH_FORMULA_CD in ( '19-1', '19-3', '19-3D', '19-4', '19-5', '19-5D' ) then dat.FD_FACTOR
                        when dat.HFRH_FORMULA_CD in ( '19-2' ) then dat.FW_FACTOR
                        else null
                    end
                else null
            end as F_FACTOR,
            case
                when ( dat.HFRE_IND = 1 ) then dat.HFRE_FORMULA_CD
                when ( dat.HFRH_IND = 1 ) then dat.HFRH_FORMULA_CD
            end as HF_FORMULA_CD,
            case
                when ( dat.HFRE_IND = 1 ) then dat.HFRE_UNADJUSTED_HRLY_VALUE
                when ( dat.HFRH_IND = 1 ) then dat.HFRH_UNADJUSTED_HRLY_VALUE
            end as RPT_HF_RATE,
            case
                when ( dat.HFRE_IND = 1 ) then dat.HFRE_CALC_UNADJUSTED_HRLY_VALUE
                when ( dat.HFRH_IND = 1 ) then dat.HFRH_CALC_UNADJUSTED_HRLY_VALUE
            end as CALC_HF_RATE,
            case
                when ( dat.HFRE_IND = 1 ) then 'lb/MWh'
                when ( dat.HFRH_IND = 1 ) then 'lb/mmBtu'
            end as HF_UOM,
            case
                when ( dat.HFRE_IND = 1 ) then dat.HFRE_MODC_CD
                when ( dat.HFRH_IND = 1 ) then dat.HFRH_MODC_CD
            end as HF_MODC_CD,
            (
                select  case when max( coalesce( sev.SEVERITY_LEVEL, 0 ) ) > 0 then 'Y' else null end
                  from  camdecmpsaux.CHECK_LOG chl
                        left join camdecmpsmd.SEVERITY_CODE sev
                          on sev.SEVERITY_CD = chl.SEVERITY_CD
                 where  chl.CHK_SESSION_ID = dat.CHK_SESSION_ID
                   and  chl.MON_LOC_ID = dat.MON_LOC_ID
                   and  ( chl.OP_BEGIN_DATE < dat.BEGIN_DATE or ( chl.OP_BEGIN_DATE = dat.BEGIN_DATE and chl.OP_BEGIN_HOUR <= dat.BEGIN_HOUR ) )
                   and  ( chl.OP_END_DATE > dat.BEGIN_DATE or ( chl.OP_END_DATE = dat.BEGIN_DATE and chl.OP_END_HOUR >= dat.BEGIN_HOUR ) )
            ) as ERROR_CODES
      from  (
                select  mpl.MON_PLAN_ID,
                        hod.MON_LOC_ID,
                        hod.RPT_PERIOD_ID,
                        hod.BEGIN_DATE,
                        hod.BEGIN_HOUR,
                        hod.OP_TIME,
                        hod.MATS_LOAD,
                        case
                            when hod.MATS_STARTUP_SHUTDOWN_FLG = 'U' then 'Startup'
                            when hod.MATS_STARTUP_SHUTDOWN_FLG = 'D' then 'Shutdown'
                            else hod.MATS_STARTUP_SHUTDOWN_FLG
                        end as MATS_STARTUP_SHUTDOWN, 
                        hod.FC_FACTOR,
                        hod.FD_FACTOR,
                        hod.FW_FACTOR,
                        -- HFRE
                        max( case when mdv.PARAMETER_CD = 'HFRE' then 1 else 0 end ) as HFRE_IND,
                        max( case when mdv.PARAMETER_CD = 'HFRE' then mdv.UNADJUSTED_HRLY_VALUE end ) as HFRE_UNADJUSTED_HRLY_VALUE,
                        max( case when mdv.PARAMETER_CD = 'HFRE' then mdv.MODC_CD end ) as HFRE_MODC_CD,
                        max( case when mdv.PARAMETER_CD = 'HFRE' then mdv.CALC_UNADJUSTED_HRLY_VALUE end ) as HFRE_CALC_UNADJUSTED_HRLY_VALUE,
                        max( case when mdv.PARAMETER_CD = 'HFRE' then mdv.CALC_PCT_DILUENT end ) as HFRE_CALC_PCT_DILUENT,
                        max( case when mdv.PARAMETER_CD = 'HFRE' then mdv.CALC_PCT_MOISTURE end ) as HFRE_CALC_PCT_MOISTURE,
                        max( case when mdv.PARAMETER_CD = 'HFRE' then frm.EQUATION_CD end ) as HFRE_FORMULA_CD,
                        -- HFRH
                        max( case when mdv.PARAMETER_CD = 'HFRH' then 1 else 0 end ) as HFRH_IND,
                        max( case when mdv.PARAMETER_CD = 'HFRH' then mdv.UNADJUSTED_HRLY_VALUE end ) as HFRH_UNADJUSTED_HRLY_VALUE,
                        max( case when mdv.PARAMETER_CD = 'HFRH' then mdv.MODC_CD end ) as HFRH_MODC_CD,
                        max( case when mdv.PARAMETER_CD = 'HFRH' then mdv.CALC_UNADJUSTED_HRLY_VALUE end ) as HFRH_CALC_UNADJUSTED_HRLY_VALUE,
                        max( case when mdv.PARAMETER_CD = 'HFRH' then mdv.CALC_PCT_DILUENT end ) as HFRH_CALC_PCT_DILUENT,
                        max( case when mdv.PARAMETER_CD = 'HFRH' then mdv.CALC_PCT_MOISTURE end ) as HFRH_CALC_PCT_MOISTURE,
                        max( case when mdv.PARAMETER_CD = 'HFRH' then frm.EQUATION_CD end ) as HFRH_FORMULA_CD,
                        -- HFC
                        max( case when mmv.PARAMETER_CD = 'HFC'  then mmv.UNADJUSTED_HRLY_VALUE end ) as HFC_UNADJUSTED_HRLY_VALUE,
                        max( case when mmv.PARAMETER_CD = 'HFC'  then mmv.MODC_CD end ) as HFC_MODC_CD,
                        max( case when mmv.PARAMETER_CD = 'HFC'  then mmv.PCT_AVAILABLE end ) as HFC_PCT_AVAILABLE,
                        -- H2O DHV
                        max( case when dhv.PARAMETER_CD = 'H2O'  then dhv.MODC_CD end ) as H2O_DHV_MODC_CD,
                        -- CO2C
                        max( case when mhv.PARAMETER_CD = 'CO2C' then mhv.UNADJUSTED_HRLY_VALUE end ) as CO2C_UNADJUSTED_HRLY_VALUE,
                        max( case when mhv.PARAMETER_CD = 'CO2C' then mhv.MODC_CD end ) as CO2C_MODC_CD,
                        -- FLOW
                        max( case when mhv.PARAMETER_CD = 'FLOW' then mhv.UNADJUSTED_HRLY_VALUE end ) as FLOW_UNADJUSTED_HRLY_VALUE,
                        max( case when mhv.PARAMETER_CD = 'FLOW' then mhv.MODC_CD end ) as FLOW_MODC_CD,
                        max( case when mhv.PARAMETER_CD = 'FLOW' then mhv.PCT_AVAILABLE end ) as FLOW_PCT_AVAILABLE,
                        -- H2O MHV
                        max( case when mhv.PARAMETER_CD = 'H2O'  then mhv.MODC_CD end ) as H2O_MHV_MODC_CD,
                        -- O2D
                        max( case when mhv.PARAMETER_CD = 'O2C'  and mhv.MOISTURE_BASIS = 'D' then mhv.UNADJUSTED_HRLY_VALUE end ) as O2D_UNADJUSTED_HRLY_VALUE,
                        max( case when mhv.PARAMETER_CD = 'O2C'  and mhv.MOISTURE_BASIS = 'D' then mhv.MODC_CD end ) as O2D_MODC_CD,
                        -- O2W
                        max( case when mhv.PARAMETER_CD = 'O2C'  and mhv.MOISTURE_BASIS = 'W' then mhv.UNADJUSTED_HRLY_VALUE end ) as O2W_UNADJUSTED_HRLY_VALUE,
                        max( case when mhv.PARAMETER_CD = 'O2C'  and mhv.MOISTURE_BASIS = 'W' then mhv.MODC_CD end ) as O2W_MODC_CD,
                        -- Error Information
                        ems.CHK_SESSION_ID
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
                        join camdecmps.MATS_DERIVED_HRLY_VALUE mdv
                          on mdv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
                         and mdv.MON_LOC_ID = hod.MON_LOC_ID
                         and mdv.HOUR_ID = hod.HOUR_ID
                         and mdv.PARAMETER_CD in ( 'HFRE', 'HFRH' )
                        join camdecmps.MATS_MONITOR_HRLY_VALUE mmv
                          on mmv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
                         and mmv.MON_LOC_ID = hod.MON_LOC_ID
                         and mmv.HOUR_ID = hod.HOUR_ID
                         and mmv.PARAMETER_CD = 'HFC'
                        left join camdecmps.DERIVED_HRLY_VALUE dhv
                          on dhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
                         and dhv.MON_LOC_ID = hod.MON_LOC_ID
                         and dhv.HOUR_ID = hod.HOUR_ID
                         and dhv.PARAMETER_CD = 'H2O'
                        left join camdecmps.MONITOR_HRLY_VALUE mhv
                          on mhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
                         and mhv.MON_LOC_ID = hod.MON_LOC_ID
                         and mhv.HOUR_ID = hod.HOUR_ID
                         and mhv.PARAMETER_CD in ( 'CO2C', 'FLOW', 'H2O', 'O2C' )
                         and mhv.MODC_CD not in ( '47', '48' )
                        left join camdecmps.MONITOR_FORMULA frm
                          on frm.MON_FORM_ID = mdv.MON_FORM_ID
                 group
                    by  mpl.MON_PLAN_ID,
                        hod.MON_LOC_ID,
                        hod.RPT_PERIOD_ID,
                        hod.BEGIN_DATE,
                        hod.BEGIN_HOUR,
                        hod.OP_TIME,
                        hod.MATS_LOAD,
                        case
                            when hod.MATS_STARTUP_SHUTDOWN_FLG = 'U' then 'Startup'
                            when hod.MATS_STARTUP_SHUTDOWN_FLG = 'D' then 'Shutdown'
                            else hod.MATS_STARTUP_SHUTDOWN_FLG
                        end,
                        hod.FC_FACTOR,
                        hod.FD_FACTOR,
                        hod.FW_FACTOR,
                        ems.CHK_SESSION_ID
        ) dat;


    RAISE NOTICE 'Refreshing view counts...';
    CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'MATSHF');
END
$procedure$
