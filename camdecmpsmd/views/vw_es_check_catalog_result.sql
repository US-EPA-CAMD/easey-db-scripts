-- View: camdecmpsmd.vw_es_check_catalog_result

-- DROP VIEW camdecmpsmd.vw_es_check_catalog_result;

CREATE OR REPLACE VIEW camdecmpsmd.vw_es_check_catalog_result
 AS
 SELECT ccr.check_catalog_result_id,
    lst.check_type_cd,
    ctc.check_type_cd_description,
    lst.check_number,
    ccr.check_result,
    lst.es_match_loc_type_cd,
    lst.es_match_time_type_cd,
    lst.es_match_data_type_cd,
    dtc.es_match_data_type_label,
    esmdtc.es_match_data_type_url
   FROM ( SELECT ccr_1.check_catalog_id,
            chk.check_type_cd,
            chk.check_number,
                CASE
                    WHEN min(COALESCE(cat.es_match_loc_type_cd, 'NONE'::character varying)::text) = max(COALESCE(cat.es_match_loc_type_cd, 'NONE'::character varying)::text) THEN min(cat.es_match_loc_type_cd::text)
                    ELSE NULL::text
                END AS es_match_loc_type_cd,
                CASE
                    WHEN min(COALESCE(cat.es_match_data_type_cd, 'NONE'::character varying)::text) = max(COALESCE(cat.es_match_data_type_cd, 'NONE'::character varying)::text) THEN min(cat.es_match_data_type_cd::text)
                    ELSE NULL::text
                END AS es_match_data_type_cd,
                CASE
                    WHEN min(COALESCE(cat.es_match_time_type_cd, 'NONE'::character varying)::text) = max(COALESCE(cat.es_match_time_type_cd, 'NONE'::character varying)::text) THEN min(cat.es_match_time_type_cd::text)
                    ELSE NULL::text
                END AS es_match_time_type_cd
           FROM camdecmpsmd.category_code cat
             JOIN camdecmpsmd.rule_check rul ON rul.category_cd::text = cat.category_cd::text
             JOIN camdecmpsmd.check_catalog chk ON chk.check_catalog_id = rul.check_catalog_id
             JOIN camdecmpsmd.check_catalog_result ccr_1 ON ccr_1.check_catalog_id = chk.check_catalog_id
          WHERE cat.process_cd::text = ANY (ARRAY['HOURLY'::character varying, 'MP'::character varying, 'OTHERQA'::character varying, 'TEST'::character varying]::text[])
          GROUP BY ccr_1.check_catalog_id, chk.check_type_cd, chk.check_number) lst
     JOIN camdecmpsmd.check_type_code ctc ON ctc.check_type_cd::text = lst.check_type_cd::text
     JOIN camdecmpsmd.check_catalog_result ccr ON ccr.check_catalog_id = lst.check_catalog_id
     JOIN camdecmpsmd.es_match_data_type_code esmdtc USING (es_match_data_type_cd)
     LEFT JOIN camdecmpsmd.es_match_data_type_code dtc ON dtc.es_match_data_type_cd::text = lst.es_match_data_type_cd
  WHERE ccr.es_allowed_ind = 1::numeric
  ORDER BY lst.check_type_cd, lst.check_number, ccr.check_result;
