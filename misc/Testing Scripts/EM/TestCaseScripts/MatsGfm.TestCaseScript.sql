/* ORIS:    628    Locations: 4          Quarter: 2021 Q3           Location:           SQL Ord:    0 */ call camdecmpswks.load_emissions_workspace( 'MDC-EF58D953BC3C47499A065DD0696650E1', 2021, 3 );
/* ORIS:    628    Locations: 4          Quarter: 2021 Q3           Location: 4         SQL Ord:    8 */ delete from camdecmpswks.HRLY_GAS_FLOW_METER tar where  exists( select 1 from camdecmpswks.HRLY_OP_DATA hod where hod.HOUR_ID = tar.HOUR_ID and hod.MON_LOC_ID = '341' and hod.BEGIN_DATE = '2021-09-02' and hod.BEGIN_HOUR = 13 ) and  COMPONENT_ID = 'PEL-L3G357-571D3469F3AB48E9975EB65D906B5B12';
/* ORIS:    628    Locations: 4          Quarter: 2021 Q3           Location: 4         SQL Ord:   33 */ update camdecmpswks.HRLY_GAS_FLOW_METER dhv set MON_LOC_ID                     = '341',  RPT_PERIOD_ID                  = 115,  COMPONENT_ID                   = 'PEL-L3G357-571D3469F3AB48E9975EB65D906B5B12',  BEGIN_END_HOUR_FLG             = 'N',  GFM_READING                    = 31.86,  AVG_SAMPLING_RATE              = 0.40,  SAMPLING_RATE_UOM              = 'LMIN',  FLOW_TO_SAMPLING_RATIO         = 25.0,  USERID                         = 'UNITTEST',  UPDATE_DATE                    = '2023-02-27' where  exists( select 1 from camdecmpswks.HRLY_OP_DATA hod where hod.HOUR_ID = dhv.HOUR_ID and hod.MON_LOC_ID = '341' and hod.BEGIN_DATE = '2021-09-02' and hod.BEGIN_HOUR = 14 ) and  COMPONENT_ID = 'PEL-L3G357-571D3469F3AB48E9975EB65D906B5B12';
/* ORIS:    628    Locations: 4          Quarter: 2021 Q3           Location: 4         SQL Ord:   33 */ update camdecmpswks.HRLY_GAS_FLOW_METER dhv set MON_LOC_ID                     = '341',  RPT_PERIOD_ID                  = 115,  COMPONENT_ID                   = 'PEL-L3G357-5D707E8BA2E94BA1B3DCDA809D590BAA',  BEGIN_END_HOUR_FLG             = 'T',  GFM_READING                    = NULL,  AVG_SAMPLING_RATE              = 0.38,  SAMPLING_RATE_UOM              = 'LMIN',  FLOW_TO_SAMPLING_RATIO         = 25.6,  USERID                         = 'UNITTEST',  UPDATE_DATE                    = '2023-02-27' where  exists( select 1 from camdecmpswks.HRLY_OP_DATA hod where hod.HOUR_ID = dhv.HOUR_ID and hod.MON_LOC_ID = '341' and hod.BEGIN_DATE = '2021-09-02' and hod.BEGIN_HOUR = 13 ) and  COMPONENT_ID = 'PEL-L3G357-5D707E8BA2E94BA1B3DCDA809D590BAA';
/* ORIS:    628    Locations: 4          Quarter: 2021 Q3           Location: 4         SQL Ord:   34 */ insert into camdecmpswks.HRLY_GAS_FLOW_METER ( HRLY_GAS_FLOW_METER_ID, HOUR_ID, MON_LOC_ID, RPT_PERIOD_ID, COMPONENT_ID, BEGIN_END_HOUR_FLG, GFM_READING, AVG_SAMPLING_RATE, SAMPLING_RATE_UOM, FLOW_TO_SAMPLING_RATIO, USERID, ADD_DATE, UPDATE_DATE ) values ('UNITTEST-' || uuid_generate_v4(), ( select hod.HOUR_ID from camdecmpswks.HRLY_OP_DATA hod where hod.MON_LOC_ID = '341' and hod.BEGIN_DATE = '2021-09-02' and hod.BEGIN_HOUR = 13 ), '341', 115, 'CAMD-23A93ACFF4C841EE8D531F0B994EE42F', 'I', 8.64, 0.38, 'LMIN', 25.6, 'UNITTEST', '2023-02-27', NULL );