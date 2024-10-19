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

	INSERT INTO camdecmps.EMISSION_VIEW_NOXRATECEMS(		MON_PLAN_ID,		MON_LOC_ID,		RPT_PERIOD_ID,		DATE_HOUR,		OP_TIME,		UNIT_LOAD,		LOAD_UOM,		NOX_RATE_MODC,		NOX_RATE_PMA,		UNADJ_NOX,		NOX_MODC,		DILUENT_PARAM,		PCT_DILUENT_USED,		DILUENT_MODC,		RPT_DILUENT,		PCT_H2O_USED,		SOURCE_H2O_VALUE,		F_FACTOR,		NOX_RATE_FORMULA_CD,		RPT_UNADJ_NOX_RATE,		CALC_UNADJ_NOX_RATE,		CALC_NOX_BAF,		RPT_ADJ_NOX_RATE,		CALC_ADJ_NOX_RATE,		CALC_HI_RATE,		NOX_MASS_FORMULA_CD,		RPT_NOX_MASS,		CALC_NOX_MASS,		ERROR_CODES	)    select  dat.MON_PLAN_ID,
            dat.MON_LOC_ID,
            dat.RPT_PERIOD_ID,
            camdecmps.format_date_hour( dat.BEGIN_DATE, dat.BEGIN_HOUR, null ) as DATE_HOUR,
            dat.OP_TIME,
            dat.HR_LOAD as UNIT_LOAD,
            dat.LOAD_UOM_CD as LOAD_UOM,
            dat.NOXR_MODC_CD as NOX_RATE_MODC, 
            dat.NOXR_PCT_AVAILABLE as NOX_RATE_PMA,
            dat.NOXC_UNADJUSTED_HRLY_VALUE as UNADJ_NOX, 
            dat.NOXC_MODC_CD as NOX_MODC, 
            case
                when ( dat.NOXR_FORMULA_CD in ( '19-6', '19-7', '19-8', '19-9', 'F-6' ) ) then 'CO2'
                when ( dat.NOXR_FORMULA_CD in ( '19-1', '19-2', '19-3', '19-3D', '19-4', '19-5', '19-5D', 'F-5' ) ) then 'O2'
                else null
            end as DILUENT_PARAM,
            dat.NOXR_CALC_PCT_DILUENT as PCT_DILUENT_USED, 
            case
                when ( dat.NOXR_FORMULA_CD in ( '19-6', '19-7', '19-8', '19-9', 'F-6' ) ) then dat.CO2C_MODC_CD
                when ( dat.NOXR_FORMULA_CD in ( '19-1', '19-4', 'F-5' ) ) then dat.O2D_MODC_CD
                when ( dat.NOXR_FORMULA_CD in ( '19-2', '19-3', '19-5', '19-3D', '19-5D' ) ) then dat.O2W_MODC_CD
            end as DILUENT_MODC,
            case
                when ( dat.NOXR_FORMULA_CD in ( '19-6', '19-7', '19-8', '19-9', 'F-6' ) ) then dat.CO2C_UNADJUSTED_HRLY_VALUE
                when ( dat.NOXR_FORMULA_CD in ( '19-1', '19-4', 'F-5' ) ) then dat.O2D_UNADJUSTED_HRLY_VALUE
                when ( dat.NOXR_FORMULA_CD in ( '19-2', '19-3', '19-5', '19-3D', '19-5D' ) ) then dat.O2W_UNADJUSTED_HRLY_VALUE
            end as RPT_DILUENT,
            dat.NOXR_CALC_PCT_MOISTURE as PCT_H2O_USED, 
            case 
                when ( dat.NOXR_CALC_PCT_MOISTURE is not null ) then 
                    case
                        when ( dat.H2O_DHV_MODC_CD is not null ) then dat.H2O_DHV_MODC_CD 
                        when ( dat.H2O_MHV_MODC_CD is not null ) then dat.H2O_MHV_MODC_CD 
                        else 'DF'
                    end 
                else
                    null
            end as SOURCE_H2O_VALUE, 
            case
                when ( dat.NOXR_FORMULA_CD in ( '19-6', '19-7', '19-8', '19-9', 'F-6' ) ) then dat.FC_FACTOR 
                when ( dat.NOXR_FORMULA_CD in ( '19-1', '19-3', '19-3D', '19-4', '19-5', '19-5D', 'F-5' ) ) then dat.FD_FACTOR 
                when ( dat.NOXR_FORMULA_CD = '19-2' ) then dat.FW_FACTOR 
            end as F_FACTOR, 
            dat.NOXR_FORMULA_CD as NOX_RATE_FORMULA_CD, 
            dat.NOXR_UNADJUSTED_HRLY_VALUE as RPT_UNADJ_NOX_RATE, 
            dat.NOXR_CALC_UNADJUSTED_HRLY_VALUE as CALC_UNADJ_NOX_RATE, 
            dat.NOXR_APPLICABLE_BIAS_ADJ_FACTOR as CALC_NOX_BAF, 
            dat.NOXR_ADJUSTED_HRLY_VALUE as RPT_ADJ_NOX_RATE, 
            dat.NOXR_CALC_ADJUSTED_HRLY_VALUE as CALC_ADJ_NOX_RATE, 
            case
                when dat.NOX_FORMULA_CD = 'F-24A'
                then dat.HI_CALC_ADJUSTED_HRLY_VALUE 
                else null
            end as CALC_HI_RATE, 
            case
                when dat.NOX_FORMULA_CD = 'F-24A'
                then dat.NOX_FORMULA_CD
                else null
            end as NOX_MASS_FORMULA_CD,
            case
                when dat.NOX_FORMULA_CD = 'F-24A'
                then dat.NOX_ADJUSTED_HRLY_VALUE
                else null
            end as RPT_NOX_MASS, 
            case
                when dat.NOX_FORMULA_CD = 'F-24A'
                then dat.NOX_CALC_ADJUSTED_HRLY_VALUE
                else null
            end as CALC_NOX_MASS, 
            (
                select  case when max( coalesce( sev.SEVERITY_LEVEL, 0 ) ) > 0 then 'Y' else NULL end
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
                        hod.HR_LOAD,
                        hod.LOAD_UOM_CD,
                        hod.FC_FACTOR,
                        hod.FD_FACTOR,
                        hod.FW_FACTOR,
                        ems.CHK_SESSION_ID,
                        -- H2O DHV
                        max( case when dhv.PARAMETER_CD = 'H2O'  then dhv.MODC_CD end ) as H2O_DHV_MODC_CD,
                        -- HI
                        max( case when dhv.PARAMETER_CD = 'HI'   then dhv.CALC_ADJUSTED_HRLY_VALUE end ) as HI_CALC_ADJUSTED_HRLY_VALUE,
                        -- NOX
                        max( case when dhv.PARAMETER_CD = 'NOX'  then dhv.ADJUSTED_HRLY_VALUE end ) as NOX_ADJUSTED_HRLY_VALUE,
                        max( case when dhv.PARAMETER_CD = 'NOX'  then dhv.CALC_ADJUSTED_HRLY_VALUE end ) as NOX_CALC_ADJUSTED_HRLY_VALUE,
                        max( case when dhv.PARAMETER_CD = 'NOX'  then frm.EQUATION_CD end ) as NOX_FORMULA_CD,
                        -- NOXR
                        max( case when dhv.PARAMETER_CD = 'NOXR' then dhv.HOUR_ID end ) as NOXR_HOUR_ID,
                        max( case when dhv.PARAMETER_CD = 'NOXR' then dhv.UNADJUSTED_HRLY_VALUE end ) as NOXR_UNADJUSTED_HRLY_VALUE,
                        max( case when mhv.PARAMETER_CD = 'NOXR' then dhv.APPLICABLE_BIAS_ADJ_FACTOR end ) as NOXR_APPLICABLE_BIAS_ADJ_FACTOR,
                        max( case when dhv.PARAMETER_CD = 'NOXR' then dhv.ADJUSTED_HRLY_VALUE end ) as NOXR_ADJUSTED_HRLY_VALUE,
                        max( case when dhv.PARAMETER_CD = 'NOXR' then dhv.MODC_CD end ) as NOXR_MODC_CD,
                        max( case when mhv.PARAMETER_CD = 'NOXR' then dhv.PCT_AVAILABLE end ) as NOXR_PCT_AVAILABLE,
                        max( case when dhv.PARAMETER_CD = 'NOXR' then dhv.CALC_UNADJUSTED_HRLY_VALUE end ) as NOXR_CALC_UNADJUSTED_HRLY_VALUE,
                        max( case when dhv.PARAMETER_CD = 'NOXR' then dhv.CALC_ADJUSTED_HRLY_VALUE end ) as NOXR_CALC_ADJUSTED_HRLY_VALUE,
                        max( case when dhv.PARAMETER_CD = 'NOXR' then dhv.CALC_PCT_DILUENT end ) as NOXR_CALC_PCT_DILUENT,
                        max( case when dhv.PARAMETER_CD = 'NOXR' then dhv.CALC_PCT_MOISTURE end ) as NOXR_CALC_PCT_MOISTURE,
                        max( case when dhv.PARAMETER_CD = 'NOXR' then frm.EQUATION_CD end ) as NOXR_FORMULA_CD,
                        -- CO2C
                        max( case when mhv.PARAMETER_CD = 'CO2C' then mhv.UNADJUSTED_HRLY_VALUE end ) as CO2C_UNADJUSTED_HRLY_VALUE,
                        max( case when mhv.PARAMETER_CD = 'CO2C' then mhv.MODC_CD end ) as CO2C_MODC_CD,
                        -- H2O MHV
                        max( case when mhv.PARAMETER_CD = 'H2O'  then mhv.MODC_CD end ) as H2O_MHV_MODC_CD,
                        -- NOXC
                        max( case when mhv.PARAMETER_CD = 'NOXC' then mhv.UNADJUSTED_HRLY_VALUE end ) as NOXC_UNADJUSTED_HRLY_VALUE,
                        max( case when mhv.PARAMETER_CD = 'NOXC' then mhv.MODC_CD end ) as NOXC_MODC_CD,
                        -- O2D
                        max( case when mhv.PARAMETER_CD = 'O2C'  and mhv.MOISTURE_BASIS = 'D' then mhv.UNADJUSTED_HRLY_VALUE end ) as O2D_UNADJUSTED_HRLY_VALUE,
                        max( case when mhv.PARAMETER_CD = 'O2C'  and mhv.MOISTURE_BASIS = 'D' then mhv.MODC_CD end ) as O2D_MODC_CD,
                        -- O2W
                        max( case when mhv.PARAMETER_CD = 'O2C'  and mhv.MOISTURE_BASIS = 'W' then mhv.UNADJUSTED_HRLY_VALUE end ) as O2W_UNADJUSTED_HRLY_VALUE,
                        max( case when mhv.PARAMETER_CD = 'O2C'  and mhv.MOISTURE_BASIS = 'W' then mhv.MODC_CD end ) as O2W_MODC_CD
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
                        join camdecmps.DERIVED_HRLY_VALUE dhv
                          on dhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
                         and dhv.MON_LOC_ID = hod.MON_LOC_ID
                         and dhv.HOUR_ID = hod.HOUR_ID
                         and dhv.PARAMETER_CD in ( 'H2O', 'HI', 'NOX', 'NOXR' )
                        left join camdecmps.MONITOR_HRLY_VALUE mhv
                          on mhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
                         and mhv.MON_LOC_ID = hod.MON_LOC_ID
                         and mhv.HOUR_ID = hod.HOUR_ID
                         and mhv.PARAMETER_CD in ( 'CO2C', 'H2O', 'NOXC', 'O2C' )
                         and mhv.MODC_CD not in ( '47', '48' )
                        left join camdecmps.MONITOR_FORMULA frm
                          on frm.MON_FORM_ID = dhv.MON_FORM_ID
                 group
                    by  mpl.MON_PLAN_ID,
                        hod.MON_LOC_ID,
                        hod.RPT_PERIOD_ID,
                        hod.BEGIN_DATE,
                        hod.BEGIN_HOUR,
                        hod.OP_TIME,
                        hod.HR_LOAD,
                        hod.LOAD_UOM_CD,
                        hod.FC_FACTOR,
                        hod.FD_FACTOR,
                        hod.FW_FACTOR,
                        ems.CHK_SESSION_ID
        ) dat
 where  dat.NOXR_HOUR_ID is not null;
	    
    
    RAISE NOTICE 'Refreshing view counts...';

    CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'NOXRATECEMS');
END
$procedure$
