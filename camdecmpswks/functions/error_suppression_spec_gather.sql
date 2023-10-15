-- FUNCTION: camdecmpswks.error_suppression_spec_gather()

DROP FUNCTION IF EXISTS camdecmpswks.error_suppression_spec_gather() CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.error_suppression_spec_gather(
	)
    RETURNS TABLE(es_spec_id bigint, check_catalog_result_id numeric, check_catalog_id numeric, check_type_cd character varying, check_number numeric, check_result character varying, severity_cd character varying, fac_id numeric, location_name_list character varying, es_match_data_type_cd character varying, match_data_value character varying, es_match_time_type_cd character varying, match_historical_ind numeric, match_time_begin_value timestamp without time zone, match_time_end_value timestamp without time zone, active_ind numeric, di character varying) 
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
SELECT	sup.ES_SPEC_ID,
          sup.CHECK_CATALOG_RESULT_ID,
          res.CHECK_CATALOG_ID,
          chk.CHECK_TYPE_CD,
          chk.CHECK_NUMBER,
          res.CHECK_RESULT,
          sup.SEVERITY_CD,
          sup.FAC_ID,
          sup.LOCATION_NAME_LIST,
          sup.ES_MATCH_DATA_TYPE_CD,
          sup.MATCH_DATA_VALUE,
          sup.ES_MATCH_TIME_TYPE_CD,
          CASE
    		WHEN sup.MATCH_HISTORICAL_IND = 'NaN' THEN null
    		ELSE sup.MATCH_HISTORICAL_IND
  			END 
  			AS MATCH_HISTORICAL_IND,
          sup.MATCH_TIME_BEGIN_VALUE,
          sup.MATCH_TIME_END_VALUE,
          sup.ACTIVE_IND,
          sup.DI
    FROM	camdecmpsaux.ES_SPEC sup
          INNER JOIN camdecmpsmd.CHECK_CATALOG_RESULT res 
            ON res.CHECK_CATALOG_RESULT_ID = sup.CHECK_CATALOG_RESULT_ID
          INNER JOIN camdecmpsmd.CHECK_CATALOG chk
            ON chk.CHECK_CATALOG_ID = res.CHECK_CATALOG_ID
    WHERE sup.ACTIVE_IND = 1;
$BODY$;
