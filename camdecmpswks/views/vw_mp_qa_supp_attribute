-- View: camdecmpswks.vw_mp_qa_supp_attribute

DROP VIEW IF EXISTS camdecmpswks.vw_mp_qa_supp_attribute;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_qa_supp_attribute
 AS
 SELECT qsa.qa_supp_attribute_id,
    ml.mon_plan_id,
    qsd.mon_loc_id,
    qsa.qa_supp_data_id,
    qsa.attribute_name,
    qsa.attribute_value
   FROM camdecmpswks.qa_supp_attribute qsa
     LEFT JOIN camdecmpswks.qa_supp_data qsd ON qsa.qa_supp_data_id::text = qsd.qa_supp_data_id::text
     LEFT JOIN camdecmpswks.vw_mp_location ml ON qsd.mon_loc_id::text = ml.mon_loc_id::text;
