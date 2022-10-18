/* 
    Update ORIS 130, unit "1" RATA-34-B suppression 
*/
insert
  into  camdecmpsaux.ES_SPEC
        (
            ES_SPEC_ID, 
            CHECK_CATALOG_RESULT_ID, 
            SEVERITY_CD, 
            ES_REASON_CD,
            NOTE,
            FAC_ID, 
            LOCATION_NAME_LIST, 
            ES_MATCH_DATA_TYPE_CD, 
            MATCH_DATA_VALUE, 
            ES_MATCH_TIME_TYPE_CD, 
            MATCH_HISTORICAL_IND, 
            MATCH_TIME_BEGIN_VALUE, 
            MATCH_TIME_END_VALUE, 
            DI, 
            ACTIVE_IND,
            USERID,
            ADD_DATE
        )
values  (
            -13,
            757,
            'ADMNOVR',
            'APPROVE',
            'F2LREF-9-A Test Case Setup',
            24,
            '1',
            'TESTNUM',
            'AAA',
            'DATE',
            NULL,
            NULL,
            NULL,
            'F6E93D94C58B323EF3B6E2EE5722027E6ADABADC',
            1,
            'djw',
            now()
        );

commit;