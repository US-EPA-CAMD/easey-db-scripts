CREATE OR REPLACE 
FUNCTION camdecmpswks.noxr_primary_and_primary_bypass_mhv
(
	monPlanId       character varying,
	rptPeriodId     numeric
)
    RETURNS TABLE   (
                        monitor_hrly_val_id                     character varying, 
                        mon_plan_id                             character varying, 
                        mon_loc_id                              character varying, 
                        hour_id                                 character varying, 
                        rpt_period_id                           numeric, 
                        calendar_year                           numeric, 
                        quarter                                 numeric, 
                        mon_sys_id                              character varying, 
                        component_id                            character varying, 
                        parameter_cd                            character varying, 
                        modc_cd                                 character varying, 
                        adjusted_hrly_value                     numeric, 
                        unadjusted_hrly_value                   numeric, 
                        pct_available                           numeric, 
                        moisture_basis                          character varying, 
                        begin_date                              date, 
                        begin_hour                              numeric,
                        system_identifier                       character varying, 
                        sys_type_cd                             character varying,
                        sys_designation_cd                      character varying, 
                        component_type_cd                       character varying,
                        component_identifier                    character varying, 
                        serial_number                           character varying,
                        acq_cd                                  character varying,
                        /*
                          The following are in addition to columns also in VW_MP_MONITOR_HRLY_VALUE
                        */
                        not_reported_noxr_system_count          integer,
                        not_reported_noxr_sys_designation_cd    character varying,
                        not_reported_noxr_mon_sys_id            character varying,
                        not_reported_noxr_sys_type_cd           character varying,
                        not_reported_noxr_system_identifier     character varying,
                        max_default_count                       integer,
                        max_default_value                       numeric,
                        high_span_count                         integer,
                        high_span_default_high_range            numeric,
                        high_span_full_scale_range              numeric,
                        low_span_count                          integer,
                        low_span_full_scale_range               numeric,
                        primary_bypass_exist_ind                integer,
                        -- This secton gets the counts for the four types ofMODC 47/48 MHV Records covering the NOXC and diluent used and unused MHV combinations.
                        used_noxc_count                         integer,
                        used_diluent_count                      integer,
                        unused_noxc_count                       integer,
                        unused_diluent_count                    integer,
                        -- This secton gets the MODCs for the four expected MHV records, used and unused NOXC and used and unused diluent.
                        used_noxc_modc_cd                       character varying,
                        used_diluent_modc_cd                    character varying,
                        unused_noxc_modc_cd                     character varying,
                        unused_diluent_modc_cd                  character varying,
                        -- This secton gets the component ids for the four expected MHV records, used and unused NOXC and used and unused diluent.
                        used_noxc_component_id                  character varying,
                        used_diluent_component_id               character varying,
                        unused_noxc_component_id                character varying,
                        unused_diluent_component_id             character varying
                    ) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN  
    RETURN QUERY    
    SELECT  -- Match VW_MP_MONITOR_HRLY_VALUE column list
            cor.MONITOR_HRLY_VAL_ID, 
            cor.MON_PLAN_ID, 
            cor.MON_LOC_ID, 
            cor.HOUR_ID, 
            cor.RPT_PERIOD_ID, 
            cor.CALENDAR_YEAR, 
            cor.QUARTER, 
            cor.MON_SYS_ID, 
            cor.COMPONENT_ID, 
            cor.PARAMETER_CD, 
            cor.MODC_CD, 
            cor.ADJUSTED_HRLY_VALUE, 
            cor.UNADJUSTED_HRLY_VALUE, 
            cor.PCT_AVAILABLE, 
            cor.MOISTURE_BASIS, 
            cor.BEGIN_DATE, 
            cor.BEGIN_HOUR,
            cor.SYSTEM_IDENTIFIER, 
            cor.SYS_TYPE_CD,
            cor.SYS_DESIGNATION_CD, 
            cor.COMPONENT_TYPE_CD,
            cor.COMPONENT_IDENTIFIER, 
            cor.SERIAL_NUMBER,
            cor.ACQ_CD,

            -- In addition to VW_MP_MONITOR_HRLY_VALUE column list
            cor.NOT_REPORTED_NOXR_SYSTEM_COUNT::integer as NOT_REPORTED_NOXR_SYSTEM_COUNT,
            cor.NOT_REPORTED_NOXR_SYS_DESIGNATION_CD::varchar as NOT_REPORTED_NOXR_SYS_DESIGNATION_CD,
            cor.NOT_REPORTED_NOXR_MON_SYS_ID::varchar as NOT_REPORTED_NOXR_MON_SYS_ID,
            cor.NOT_REPORTED_NOXR_SYS_TYPE_CD::varchar as NOT_REPORTED_NOXR_SYS_TYPE_CD,
            cor.NOT_REPORTED_NOXR_SYSTEM_IDENTIFIER::varchar as NOT_REPORTED_NOXR_SYSTEM_IDENTIFIER,
            cor.MAX_DEFAULT_COUNT::integer as MAX_DEFAULT_COUNT,
            cor.MAX_DEFAULT_VALUE,
            cor.HIGH_SPAN_COUNT::integer as HIGH_SPAN_COUNT,
            cor.HIGH_SPAN_DEFAULT_HIGH_RANGE,
            cor.HIGH_SPAN_FULL_SCALE_RANGE,
            cor.LOW_SPAN_COUNT::integer as LOW_SPAN_COUNT,
            cor.LOW_SPAN_FULL_SCALE_RANGE,
            cor.PRIMARY_BYPASS_EXIST_IND,

            /*
                This secton gets the counts for the four types ofMODC 47/48 MHV Records covering the NOXC and diluent used and unused MHV combinations.
            */
            SUM( CASE WHEN mhv.PARAMETER_CD = 'NOXC' AND mhv.MODC_CD NOT IN ('47', '48') THEN 1 ELSE 0 END )::integer USED_NOXC_COUNT,
            SUM( CASE WHEN mhv.PARAMETER_CD IN ('CO2C', 'O2C') AND mhv.MODC_CD NOT IN ('47', '48') THEN 1 ELSE 0 END )::integer USED_DILUENT_COUNT,
            SUM( CASE WHEN mhv.PARAMETER_CD = 'NOXC' AND mhv.MODC_CD IN ('47', '48') THEN 1 ELSE 0 END )::integer UNUSED_NOXC_COUNT,
            SUM( CASE WHEN mhv.PARAMETER_CD IN ('CO2C', 'O2C') AND mhv.MODC_CD IN ('47', '48') THEN 1 ELSE 0 END )::integer UNUSED_DILUENT_COUNT,

            /*
                This secton gets the MODCs for the four expected MHV records, used and unused NOXC and used and unused diluent.
            */
            CASE WHEN SUM( CASE WHEN mhv.PARAMETER_CD = 'NOXC' AND mhv.MODC_CD NOT IN ('47', '48') THEN 1 ELSE 0 END ) = 1
                THEN MAX(CASE WHEN mhv.PARAMETER_CD = 'NOXC' AND mhv.MODC_CD NOT IN ('47', '48') THEN mhv.MODC_CD ELSE NULL END)
                ELSE NULL
            END::varchar USED_NOXC_MODC_CD,

            CASE WHEN SUM( CASE WHEN mhv.PARAMETER_CD IN ('CO2C', 'O2C') AND mhv.MODC_CD NOT IN ('47', '48') THEN 1 ELSE 0 END ) = 1
                THEN MAX(CASE WHEN mhv.PARAMETER_CD IN ('CO2C', 'O2C') AND mhv.MODC_CD NOT IN ('47', '48') THEN mhv.MODC_CD ELSE NULL END)
                ELSE NULL
            END::varchar USED_DILUENT_MODC_CD,

            CASE WHEN SUM( CASE WHEN mhv.PARAMETER_CD = 'NOXC' AND mhv.MODC_CD IN ('47', '48') THEN 1 ELSE 0 END ) = 1
                THEN MAX(CASE WHEN mhv.PARAMETER_CD = 'NOXC' AND mhv.MODC_CD IN ('47', '48') THEN mhv.MODC_CD ELSE NULL END)
                ELSE NULL
            END::varchar UNUSED_NOXC_MODC_CD,

            CASE WHEN SUM( CASE WHEN mhv.PARAMETER_CD IN ('CO2C', 'O2C') AND mhv.MODC_CD IN ('47', '48') THEN 1 ELSE 0 END ) = 1
                THEN MAX(CASE WHEN mhv.PARAMETER_CD IN ('CO2C', 'O2C') AND mhv.MODC_CD IN ('47', '48') THEN mhv.MODC_CD ELSE NULL END)
                ELSE NULL
            END::varchar UNUSED_DILUENT_MODC_CD,

            /*
                This secton gets the component ids for the four expected MHV records, used and unused NOXC and used and unused diluent.
            */
            CASE WHEN SUM( CASE WHEN mhv.PARAMETER_CD = 'NOXC' AND mhv.MODC_CD NOT IN ('47', '48') THEN 1 ELSE 0 END ) = 1
                THEN MAX(CASE WHEN mhv.PARAMETER_CD = 'NOXC' AND mhv.MODC_CD NOT IN ('47', '48') THEN mhv.COMPONENT_ID ELSE NULL END)
                ELSE NULL
            END::varchar USED_NOXC_COMPONENT_ID,

            CASE WHEN SUM( CASE WHEN mhv.PARAMETER_CD IN ('CO2C', 'O2C') AND mhv.MODC_CD NOT IN ('47', '48') THEN 1 ELSE 0 END ) = 1
                THEN MAX(CASE WHEN mhv.PARAMETER_CD IN ('CO2C', 'O2C') AND mhv.MODC_CD NOT IN ('47', '48') THEN mhv.COMPONENT_ID ELSE NULL END)
                ELSE NULL
            END::varchar USED_DILUENT_COMPONENT_ID,

            CASE WHEN SUM( CASE WHEN mhv.PARAMETER_CD = 'NOXC' AND mhv.MODC_CD IN ('47', '48') THEN 1 ELSE 0 END ) = 1
                THEN MAX(CASE WHEN mhv.PARAMETER_CD = 'NOXC' AND mhv.MODC_CD IN ('47', '48') THEN mhv.COMPONENT_ID ELSE NULL END)
                ELSE NULL
            END::varchar UNUSED_NOXC_COMPONENT_ID,

            CASE WHEN SUM( CASE WHEN mhv.PARAMETER_CD IN ('CO2C', 'O2C') AND mhv.MODC_CD IN ('47', '48') THEN 1 ELSE 0 END ) = 1
                THEN MAX(CASE WHEN mhv.PARAMETER_CD IN ('CO2C', 'O2C') AND mhv.MODC_CD IN ('47', '48') THEN mhv.COMPONENT_ID ELSE NULL END)
                ELSE NULL
            END::varchar UNUSED_DILUENT_COMPONENT_ID

      FROM  (
                /*
                This subquery gets the base set of information.  The outer queries add additional usually aggregated information.
                */
                SELECT  /*
                            The following sections matches and should always match the columns in ECMPS.dbo.VW_MP_MONITOR_HRLY_VALUE.
                        */
                        mhv.MONITOR_HRLY_VAL_ID, 
                        sel.MON_PLAN_ID, 
                        hod.MON_LOC_ID, 
                        hod.HOUR_ID, 
                        hod.RPT_PERIOD_ID, 
                        sel.CALENDAR_YEAR, 
                        sel.QUARTER, 
                        mhv.MON_SYS_ID, 
                        mhv.COMPONENT_ID, 
                        mhv.PARAMETER_CD, 
                        mhv.MODC_CD, 
                        mhv.ADJUSTED_HRLY_VALUE, 
                        mhv.UNADJUSTED_HRLY_VALUE, 
                        mhv.PCT_AVAILABLE, 
                        mhv.MOISTURE_BASIS, 
                        hod.BEGIN_DATE, 
                        hod.BEGIN_HOUR,
                        msy.SYSTEM_IDENTIFIER, 
                        msy.SYS_TYPE_CD,
                        msy.SYS_DESIGNATION_CD, 
                        cmp.COMPONENT_TYPE_CD,
                        cmp.COMPONENT_IDENTIFIER, 
                        cmp.SERIAL_NUMBER,
                        cmp.ACQ_CD,

                        /*
                            The following section gets information about the active NOX primary or primary bypass system 
                            with and active link to the component for the MHV record, but was not reported for NOXR in a
                            DHV record.  The data specifically excludes the system reported in the NOXR DHV record.
                        */
                        (
                            SELECT  COALESCE(COUNT(1), 0)  
                              FROM  camdecmpswks.MONITOR_SYSTEM_COMPONENT msc
                                    join camdecmpswks.MONITOR_SYSTEM msy on msy.MON_SYS_ID = msc.MON_SYS_ID
                             WHERE  msc.COMPONENT_ID = mhv.COMPONENT_ID 
                               AND  msc.MON_SYS_ID != noxr.MON_SYS_ID
                               AND  msy.SYS_TYPE_CD = 'NOX'
                               AND  msy.SYS_DESIGNATION_CD in ('P', 'PB')
                               AND  DATE_ADD('hour'::text, msc.BEGIN_HOUR, msc.BEGIN_DATE) <= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                               AND  COALESCE(DATE_ADD('hour'::text, msc.END_HOUR, msc.END_DATE),  DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)) >= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                               AND  DATE_ADD('hour'::text, msy.BEGIN_HOUR, msy.BEGIN_DATE) <= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                               AND  COALESCE(DATE_ADD('hour'::text, msy.END_HOUR, msy.END_DATE),  DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)) >= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                        ) NOT_REPORTED_NOXR_SYSTEM_COUNT,

                        (
                            SELECT  CASE WHEN COALESCE(COUNT(1), 0) = 1 THEN MAX(msy.SYS_DESIGNATION_CD) ELSE NULL END 
                              FROM  camdecmpswks.MONITOR_SYSTEM_COMPONENT msc
                                    join camdecmpswks.MONITOR_SYSTEM msy on msy.MON_SYS_ID = msc.MON_SYS_ID
                             WHERE  msc.COMPONENT_ID = mhv.COMPONENT_ID  
                               AND  msc.MON_SYS_ID != noxr.MON_SYS_ID
                               AND  msy.SYS_TYPE_CD = 'NOX'
                               AND  msy.SYS_DESIGNATION_CD in ('P', 'PB')
                               AND  DATE_ADD('hour'::text, msc.BEGIN_HOUR, msc.BEGIN_DATE) <= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                               AND  COALESCE(DATE_ADD('hour'::text, msc.END_HOUR, msc.END_DATE),  DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)) >= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                               AND  DATE_ADD('hour'::text, msy.BEGIN_HOUR, msy.BEGIN_DATE) <= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                               AND  COALESCE(DATE_ADD('hour'::text, msy.END_HOUR, msy.END_DATE),  DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)) >= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                        ) NOT_REPORTED_NOXR_SYS_DESIGNATION_CD,

                        (
                            SELECT  CASE WHEN COALESCE(COUNT(1), 0) = 1 THEN MAX(msy.MON_SYS_ID) ELSE NULL END 
                              FROM  camdecmpswks.MONITOR_SYSTEM_COMPONENT msc
                                    join camdecmpswks.MONITOR_SYSTEM msy on msy.MON_SYS_ID = msc.MON_SYS_ID
                             WHERE  msc.COMPONENT_ID = mhv.COMPONENT_ID  
                               AND  msc.MON_SYS_ID != noxr.MON_SYS_ID
                               AND  msy.SYS_TYPE_CD = 'NOX'
                               AND  msy.SYS_DESIGNATION_CD in ('P', 'PB')
                               AND  DATE_ADD('hour'::text, msc.BEGIN_HOUR, msc.BEGIN_DATE) <= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                               AND  COALESCE(DATE_ADD('hour'::text, msc.END_HOUR, msc.END_DATE),  DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)) >= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                               AND  DATE_ADD('hour'::text, msy.BEGIN_HOUR, msy.BEGIN_DATE) <= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                               AND  COALESCE(DATE_ADD('hour'::text, msy.END_HOUR, msy.END_DATE),  DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)) >= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                        ) NOT_REPORTED_NOXR_MON_SYS_ID,

                        (
                            SELECT  CASE WHEN COALESCE(COUNT(1), 0) = 1 THEN MAX(msy.SYS_TYPE_CD) ELSE NULL END 
                              FROM  camdecmpswks.MONITOR_SYSTEM_COMPONENT msc
                                    join camdecmpswks.MONITOR_SYSTEM msy on msy.MON_SYS_ID = msc.MON_SYS_ID
                             WHERE  msc.COMPONENT_ID = mhv.COMPONENT_ID  
                               AND  msc.MON_SYS_ID != noxr.MON_SYS_ID
                               AND  msy.SYS_TYPE_CD = 'NOX'
                               AND  msy.SYS_DESIGNATION_CD in ('P', 'PB')
                               AND  DATE_ADD('hour'::text, msc.BEGIN_HOUR, msc.BEGIN_DATE) <= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                               AND  COALESCE(DATE_ADD('hour'::text, msc.END_HOUR, msc.END_DATE),  DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)) >= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                               AND  DATE_ADD('hour'::text, msy.BEGIN_HOUR, msy.BEGIN_DATE) <= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                               AND  COALESCE(DATE_ADD('hour'::text, msy.END_HOUR, msy.END_DATE),  DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)) >= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                        ) NOT_REPORTED_NOXR_SYS_TYPE_CD,

                        (
                            SELECT  CASE WHEN COALESCE(COUNT(1), 0) = 1 THEN MAX(msy.SYSTEM_IDENTIFIER) ELSE NULL END 
                              FROM  camdecmpswks.MONITOR_SYSTEM_COMPONENT msc
                                    join camdecmpswks.MONITOR_SYSTEM msy on msy.MON_SYS_ID = msc.MON_SYS_ID
                             WHERE  msc.COMPONENT_ID = mhv.COMPONENT_ID  
                               AND  msc.MON_SYS_ID != noxr.MON_SYS_ID
                               AND  msy.SYS_TYPE_CD = 'NOX'
                               AND  msy.SYS_DESIGNATION_CD in ('P', 'PB')
                               AND  DATE_ADD('hour'::text, msc.BEGIN_HOUR, msc.BEGIN_DATE) <= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                               AND  COALESCE(DATE_ADD('hour'::text, msc.END_HOUR, msc.END_DATE),  DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)) >= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                               AND  DATE_ADD('hour'::text, msy.BEGIN_HOUR, msy.BEGIN_DATE) <= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                               AND  COALESCE(DATE_ADD('hour'::text, msy.END_HOUR, msy.END_DATE),  DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)) >= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                        ) NOT_REPORTED_NOXR_SYSTEM_IDENTIFIER,

                        /*
                            The following section gets the values needed to determine the maximum value based on parameter type
                            and either MONITOR_DEFAULT or MONITOR_SPAN records.
                        */
                        CASE (mhv.PARAMETER_CD)
                            WHEN 'O2C' THEN (
                                                SELECT  COUNT(1)
                                                  FROM  camdecmpswks.MONITOR_DEFAULT mdf 
                                                 WHERE  mdf.MON_LOC_ID = sel.MON_LOC_ID 
                                                   AND  mdf.PARAMETER_CD = 'O2X'
                                                   AND  mdf.FUEL_CD = 'NFS'
                                                   AND  mdf.DEFAULT_PURPOSE_CD = 'DC'
                                                   AND  DATE_ADD('hour'::text, mdf.BEGIN_HOUR, mdf.BEGIN_DATE) <= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                                                   AND  COALESCE(DATE_ADD('hour'::text, mdf.END_HOUR, mdf.END_DATE),  DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)) >= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                                            )
                            ELSE NULL
                        END MAX_DEFAULT_COUNT,

                        CASE (mhv.PARAMETER_CD)
                            WHEN 'O2C' THEN (
                                                SELECT  CASE WHEN MAX(mdf.DEFAULT_VALUE) = MIN(mdf.DEFAULT_VALUE) THEN MAX(mdf.DEFAULT_VALUE) ELSE NULL END
                                                  FROM  camdecmpswks.MONITOR_DEFAULT mdf 
                                                 WHERE  mdf.MON_LOC_ID = sel.MON_LOC_ID 
                                                   AND  mdf.PARAMETER_CD = 'O2X'
                                                   AND  mdf.FUEL_CD = 'NFS'
                                                   AND  mdf.DEFAULT_PURPOSE_CD = 'DC'
                                                   AND  DATE_ADD('hour'::text, mdf.BEGIN_HOUR, mdf.BEGIN_DATE) <= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                                                   AND  COALESCE(DATE_ADD('hour'::text, mdf.END_HOUR, mdf.END_DATE),  DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)) >= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                                            )
                            ELSE NULL
                        END MAX_DEFAULT_VALUE,

                        CASE (mhv.PARAMETER_CD)
                            WHEN 'CO2C' THEN (
                                                SELECT  COUNT(1)
                                                  FROM  camdecmpswks.MONITOR_SPAN msp 
                                                 WHERE  msp.MON_LOC_ID = sel.MON_LOC_ID 
                                                   AND  msp.COMPONENT_TYPE_CD = 'CO2'
                                                   AND  msp.SPAN_SCALE_CD = 'H'
                                                   AND  DATE_ADD('hour'::text, msp.BEGIN_HOUR, msp.BEGIN_DATE) <= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                                                   AND  COALESCE(DATE_ADD('hour'::text, msp.END_HOUR, msp.END_DATE),  DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)) >= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                                             )
                            WHEN 'NOXC' THEN (
                                                SELECT  COUNT(1)
                                                  FROM  camdecmpswks.MONITOR_SPAN msp 
                                                 WHERE  msp.MON_LOC_ID = sel.MON_LOC_ID 
                                                   AND  msp.COMPONENT_TYPE_CD = 'NOX'
                                                   AND  msp.SPAN_SCALE_CD = 'H'
                                                   AND  DATE_ADD('hour'::text, msp.BEGIN_HOUR, msp.BEGIN_DATE) <= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                                                   AND  COALESCE(DATE_ADD('hour'::text, msp.END_HOUR, msp.END_DATE),  DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)) >= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                                             )
                            ELSE NULL
                        END HIGH_SPAN_COUNT,

                        CASE (mhv.PARAMETER_CD)
                            WHEN 'CO2C' THEN (
                                                SELECT  CASE WHEN MAX(msp.DEFAULT_HIGH_RANGE) = MIN(msp.DEFAULT_HIGH_RANGE) THEN MAX(msp.DEFAULT_HIGH_RANGE) ELSE NULL END
                                                  FROM  camdecmpswks.MONITOR_SPAN msp 
                                                 WHERE  msp.MON_LOC_ID = sel.MON_LOC_ID 
                                                   AND  msp.COMPONENT_TYPE_CD = 'CO2'
                                                   AND  msp.SPAN_SCALE_CD = 'H'
                                                   AND  DATE_ADD('hour'::text, msp.BEGIN_HOUR, msp.BEGIN_DATE) <= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                                                   AND  COALESCE(DATE_ADD('hour'::text, msp.END_HOUR, msp.END_DATE),  DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)) >= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                                             )
                            WHEN 'NOXC' THEN (
                                                SELECT  CASE WHEN MAX(msp.DEFAULT_HIGH_RANGE) = MIN(msp.DEFAULT_HIGH_RANGE) THEN MAX(msp.DEFAULT_HIGH_RANGE) ELSE NULL END
                                                  FROM  camdecmpswks.MONITOR_SPAN msp 
                                                 WHERE  msp.MON_LOC_ID = sel.MON_LOC_ID 
                                                   AND  msp.COMPONENT_TYPE_CD = 'NOX'
                                                   AND  msp.SPAN_SCALE_CD = 'H'
                                                   AND  DATE_ADD('hour'::text, msp.BEGIN_HOUR, msp.BEGIN_DATE) <= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                                                   AND  COALESCE(DATE_ADD('hour'::text, msp.END_HOUR, msp.END_DATE),  DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)) >= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                                             )
                            ELSE NULL
                        END HIGH_SPAN_DEFAULT_HIGH_RANGE,

                        CASE (mhv.PARAMETER_CD)
                            WHEN 'CO2C' THEN (
                                                SELECT  CASE WHEN MAX(msp.FULL_SCALE_RANGE) = MIN(msp.FULL_SCALE_RANGE) THEN MAX(msp.FULL_SCALE_RANGE) ELSE NULL END
                                                  FROM  camdecmpswks.MONITOR_SPAN msp 
                                                 WHERE  msp.MON_LOC_ID = sel.MON_LOC_ID 
                                                   AND  msp.COMPONENT_TYPE_CD = 'CO2'
                                                   AND  msp.SPAN_SCALE_CD = 'H'
                                                   AND  DATE_ADD('hour'::text, msp.BEGIN_HOUR, msp.BEGIN_DATE) <= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                                                   AND  COALESCE(DATE_ADD('hour'::text, msp.END_HOUR, msp.END_DATE),  DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)) >= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                                             )
                            WHEN 'NOXC' THEN (
                                                SELECT  CASE WHEN MAX(msp.FULL_SCALE_RANGE) = MIN(msp.FULL_SCALE_RANGE) THEN MAX(msp.FULL_SCALE_RANGE) ELSE NULL END
                                                  FROM  camdecmpswks.MONITOR_SPAN msp 
                                                 WHERE  msp.MON_LOC_ID = sel.MON_LOC_ID 
                                                   AND  msp.COMPONENT_TYPE_CD = 'NOX'
                                                   AND  msp.SPAN_SCALE_CD = 'H'
                                                   AND  DATE_ADD('hour'::text, msp.BEGIN_HOUR, msp.BEGIN_DATE) <= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                                                   AND  COALESCE(DATE_ADD('hour'::text, msp.END_HOUR, msp.END_DATE),  DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)) >= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                                             )
                            ELSE NULL
                        END HIGH_SPAN_FULL_SCALE_RANGE,

                        CASE (mhv.PARAMETER_CD)
                            WHEN 'NOXC' THEN (
                                                SELECT  COUNT(1)
                                                  FROM  camdecmpswks.MONITOR_SPAN msp 
                                                 WHERE  msp.MON_LOC_ID = sel.MON_LOC_ID 
                                                   AND  msp.COMPONENT_TYPE_CD = 'NOX'
                                                   AND  msp.SPAN_SCALE_CD = 'L'
                                                   AND  DATE_ADD('hour'::text, msp.BEGIN_HOUR, msp.BEGIN_DATE) <= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                                                   AND  COALESCE(DATE_ADD('hour'::text, msp.END_HOUR, msp.END_DATE),  DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)) >= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                                             )
                            ELSE NULL
                        END LOW_SPAN_COUNT,

                        CASE (mhv.PARAMETER_CD)
                            WHEN 'NOXC' THEN (
                                                SELECT  CASE WHEN MAX(msp.FULL_SCALE_RANGE) = MIN(msp.FULL_SCALE_RANGE) THEN MAX(msp.FULL_SCALE_RANGE) ELSE NULL END
                                                  FROM  camdecmpswks.MONITOR_SPAN msp 
                                                 WHERE  msp.MON_LOC_ID = sel.MON_LOC_ID 
                                                   AND  msp.COMPONENT_TYPE_CD = 'NOX'
                                                   AND  msp.SPAN_SCALE_CD = 'L'
                                                   AND  DATE_ADD('hour'::text, msp.BEGIN_HOUR, msp.BEGIN_DATE) <= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                                                   AND  COALESCE(DATE_ADD('hour'::text, msp.END_HOUR, msp.END_DATE),  DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)) >= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                                             )
                            ELSE NULL
                        END LOW_SPAN_FULL_SCALE_RANGE,

                        /*
                            The following determines whether an active primary bypass exists for the location.
                        */
                        -- In addition to VW_MP_MONITOR_HRLY_VALUE column list
                        (
                            SELECT  COALESCE(MAX(CASE WHEN msy.SYS_DESIGNATION_CD = 'PB' THEN 1 ELSE 0 END), 0)  
                              FROM  camdecmpswks.MONITOR_SYSTEM msy
                             WHERE  msy.MON_LOC_ID = sel.MON_LOC_ID 
                               AND  msy.SYS_TYPE_CD = 'NOX'
                               AND  DATE_ADD('hour'::text, msy.BEGIN_HOUR, msy.BEGIN_DATE) <= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                               AND  COALESCE(DATE_ADD('hour'::text, msy.END_HOUR, msy.END_DATE),  DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)) >= DATE_ADD('hour'::text, hod.BEGIN_HOUR, hod.BEGIN_DATE)
                        ) PRIMARY_BYPASS_EXIST_IND

                    /*
                        Returns MHV records with 47 or 48 MODC
                    */
                  FROM  (
                            SELECT  mpl.MON_PLAN_ID,
                                    prd.RPT_PERIOD_ID,
                                    mpl.MON_LOC_ID,
                                    prd.CALENDAR_YEAR,
                                    prd.QUARTER
                              FROM  camdecmpswks.MONITOR_PLAN_LOCATION mpl,
                                    camdecmpsmd.REPORTING_PERIOD prd
                             WHERE  (monPlanId IS NULL OR mpl.MON_PLAN_ID = monPlanId)
                               AND  (rptPeriodId IS NULL OR prd.RPT_PERIOD_ID = rptPeriodId)
                        ) sel
                        join camdecmpswks.HRLY_OP_DATA hod on hod.MON_LOC_ID = sel.MON_LOC_ID and hod.RPT_PERIOD_ID = sel.RPT_PERIOD_ID
                        join camdecmpswks.MONITOR_HRLY_VALUE mhv on mhv.HOUR_ID = hod.HOUR_ID and mhv.MODC_CD in ('47', '48')
                        left join camdecmpswks.MONITOR_SYSTEM msy on msy.MON_SYS_ID = mhv.MON_SYS_ID
                        left join camdecmpswks.COMPONENT cmp on cmp.COMPONENT_ID = mhv.COMPONENT_ID
                        left join camdecmpswks.DERIVED_HRLY_VALUE noxr on noxr.HOUR_ID = mhv.HOUR_ID and noxr.PARAMETER_CD = 'NOXR'
            ) cor
            -- Gets all if the CO2C, NOXC and O2C MHV records for a location and hour to build check helper information.
            JOIN camdecmpswks.MONITOR_HRLY_VALUE mhv ON mhv.HOUR_ID = cor.HOUR_ID and mhv.PARAMETER_CD in ('CO2C', 'NOXC', 'O2C')
     GROUP
        BY  cor.MONITOR_HRLY_VAL_ID, 
            cor.MON_PLAN_ID, 
            cor.MON_LOC_ID, 
            cor.HOUR_ID, 
            cor.RPT_PERIOD_ID, 
            cor.CALENDAR_YEAR, 
            cor.QUARTER, 
            cor.MON_SYS_ID, 
            cor.COMPONENT_ID, 
            cor.PARAMETER_CD, 
            cor.MODC_CD, 
            cor.ADJUSTED_HRLY_VALUE, 
            cor.UNADJUSTED_HRLY_VALUE, 
            cor.PCT_AVAILABLE, 
            cor.MOISTURE_BASIS, 
            cor.BEGIN_DATE, 
            cor.BEGIN_HOUR,
            cor.SYSTEM_IDENTIFIER, 
            cor.SYS_TYPE_CD,
            cor.SYS_DESIGNATION_CD, 
            cor.COMPONENT_TYPE_CD,
            cor.COMPONENT_IDENTIFIER, 
            cor.SERIAL_NUMBER,
            cor.ACQ_CD,
            cor.NOT_REPORTED_NOXR_SYSTEM_COUNT,
            cor.NOT_REPORTED_NOXR_SYS_DESIGNATION_CD,
            cor.NOT_REPORTED_NOXR_MON_SYS_ID,
            cor.NOT_REPORTED_NOXR_SYS_TYPE_CD,
            cor.NOT_REPORTED_NOXR_SYSTEM_IDENTIFIER,
            cor.PRIMARY_BYPASS_EXIST_IND,
            cor.MAX_DEFAULT_COUNT,
            cor.MAX_DEFAULT_VALUE,
            cor.HIGH_SPAN_COUNT,
            cor.HIGH_SPAN_DEFAULT_HIGH_RANGE,
            cor.HIGH_SPAN_FULL_SCALE_RANGE,
            cor.LOW_SPAN_COUNT,
            cor.LOW_SPAN_FULL_SCALE_RANGE;

END;
$BODY$;