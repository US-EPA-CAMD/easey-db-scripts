/* ORIS:   1702    Locations: 1          Quarter: 2018 Q3           Location:           SQL Ord:    0 */ call camdecmpswks.load_emissions_workspace( 'MDC-63589D6FF98D440FBBF80C8A58AA4B42', 2018, 3 );
/* ORIS:   3944    Locations: 2          Quarter: 2020 Q4           Location:           SQL Ord:    0 */ call camdecmpswks.load_emissions_workspace( 'MDC-C4E26BB643E349EB9D194F761544A857', 2020, 4 );
/* ORIS:   3944    Locations: 2          Quarter: 2020 Q4           Location: 2         SQL Ord:   23 */ update camdecmpswks.MONITOR_HRLY_VALUE dhv set MON_LOC_ID                     = '54',  RPT_PERIOD_ID                  = 112,  MON_SYS_ID                     = 'L051428-2EBC7023440743BCB18DD200F31B9C52',  COMPONENT_ID                   = NULL,  PARAMETER_CD                   = 'FLOW',  APPLICABLE_BIAS_ADJ_FACTOR     = 1.000,  UNADJUSTED_HRLY_VALUE          = 51958000.000,  ADJUSTED_HRLY_VALUE            = 51958000.000,  MODC_CD                        = '01',  PCT_AVAILABLE                  = 99.7,  MOISTURE_BASIS                 = NULL,  USERID                         = 'UNITTEST',  UPDATE_DATE                    = '2023-02-28' where  exists( select 1 from camdecmpswks.HRLY_OP_DATA hod where hod.HOUR_ID = dhv.HOUR_ID and hod.MON_LOC_ID = '54' and hod.BEGIN_DATE = '2020-10-10' and hod.BEGIN_HOUR = 12 ) and  PARAMETER_CD = 'FLOW';
/* ORIS:  50900    Locations: CS001,     Quarter: 2021 Q4           Location:           SQL Ord:    0 */ call camdecmpswks.load_emissions_workspace( 'BMITCLT-CCA004B58C834D749D859EEA33131D23', 2021, 4 );
/* ORIS:  50900    Locations: CS001,     Quarter: 2021 Q4           Location: CS001     SQL Ord:   23 */ update camdecmpswks.MONITOR_HRLY_VALUE dhv set MON_LOC_ID                     = '4658',  RPT_PERIOD_ID                  = 116,  MON_SYS_ID                     = 'CAMD-F8F9F1E357B34B62BF6790A88C065B63',  COMPONENT_ID                   = 'CAMD-B3FB1DB712C447829CBAFC225965F85C',  PARAMETER_CD                   = 'FLOW',  APPLICABLE_BIAS_ADJ_FACTOR     = NULL,  UNADJUSTED_HRLY_VALUE          = NULL,  ADJUSTED_HRLY_VALUE            = 22374000.000,  MODC_CD                        = '01',  PCT_AVAILABLE                  = 89.1,  MOISTURE_BASIS                 = NULL,  USERID                         = 'UNITTEST',  UPDATE_DATE                    = '2023-02-28' where  exists( select 1 from camdecmpswks.HRLY_OP_DATA hod where hod.HOUR_ID = dhv.HOUR_ID and hod.MON_LOC_ID = '4658' and hod.BEGIN_DATE = '2021-10-01' and hod.BEGIN_HOUR = 0 ) and  PARAMETER_CD = 'FLOW';
/* ORIS:  50900    Locations: CS001,     Quarter: 2021 Q4           Location: CS001     SQL Ord:   23 */ update camdecmpswks.MONITOR_HRLY_VALUE dhv set MON_LOC_ID                     = '4658',  RPT_PERIOD_ID                  = 116,  MON_SYS_ID                     = 'CAMD-F8F9F1E357B34B62BF6790A88C065B63',  COMPONENT_ID                   = 'CAMD-B3FB1DB712C447829CBAFC225965F85C',  PARAMETER_CD                   = 'FLOW',  APPLICABLE_BIAS_ADJ_FACTOR     = NULL,  UNADJUSTED_HRLY_VALUE          = NULL,  ADJUSTED_HRLY_VALUE            = 26454000.000,  MODC_CD                        = '01',  PCT_AVAILABLE                  = 87.0,  MOISTURE_BASIS                 = NULL,  USERID                         = 'UNITTEST',  UPDATE_DATE                    = '2023-02-28' where  exists( select 1 from camdecmpswks.HRLY_OP_DATA hod where hod.HOUR_ID = dhv.HOUR_ID and hod.MON_LOC_ID = '4658' and hod.BEGIN_DATE = '2021-10-09' and hod.BEGIN_HOUR = 0 ) and  PARAMETER_CD = 'FLOW';