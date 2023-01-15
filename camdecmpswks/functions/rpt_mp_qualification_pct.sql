-- FUNCTION: camdecmpswks.rpt_mp_qualification_pct(character varying)

DROP FUNCTION IF EXISTS camdecmpswks.rpt_mp_qualification_pct(character varying);

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_mp_qualification_pct(
	monplanid character varying)
    RETURNS TABLE("unitStack" text,
				  "qualificationTypeCode" text,
				  "qualificationTypeCodeGroup" text,
				  "qualificationTypeCodeDescription" text,
				  "beginDate" text,
				  "endDate" text,
				  "qualificationYear" numeric,
				  "averagePercentValue" numeric,
				  "year1" numeric,
				  "year1DataTypeCode" text,
				  "year1DataTypeCodeGroup" text,
				  "year1DataTypeCodeDescription" text,
				  "year1PercentValue" numeric,
				  "year2" numeric,
				  "year2DataTypeCode" text,
				  "year2DataTypeCodeGroup" text,
				  "year2DataTypeCodeDescription" text,
				  "year2PercentValue" numeric,
				  "year3" numeric,
				  "year3DataTypeCode" text,
				  "year3DataTypeCodeGroup" text,
				  "year3DataTypeCodeDescription" text,
				  "year3PercentValue" numeric
				 )
    LANGUAGE 'sql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
	SELECT
		CASE
			WHEN ml.stack_pipe_id IS NOT NULL THEN sp.stack_name
			WHEN ml.unit_id IS NOT NULL THEN u.unitid
			ELSE '*'
		END AS "unitStack",
		mq.qual_type_cd AS "qualificationTypeCode",
		'Qualification Type Codes' AS "qualificationTypeCodeGroup",
		qtc.qual_type_cd_description AS "qualificationTypeCodeDescription",
		camdecmpswks.format_date_hour(mq.begin_date, null, null) AS "beginDate",
		camdecmpswks.format_date_hour(mq.end_date, null, null) AS "endDate",
		pct.qual_year AS "qualificationYear",
		pct.avg_pct_value AS "averagePercentValue",
		pct.yr1_qual_data_year AS "year1",
		pct.yr1_qual_data_type_cd AS "year1DataTypeCode",
		'Data Type Codes' AS "year1DataTypeCodeGroup",
		qdtc1.qual_data_type_cd_description AS "year1DataTypeCodeDescription",
		pct.yr1_pct_value AS "year1PercentValue",
		pct.yr2_qual_data_year AS "year2",
		pct.yr2_qual_data_type_cd AS "year2DataTypeCode",
		'Data Type Codes' AS "year2DataTypeCodeGroup",
		qdtc2.qual_data_type_cd_description AS "year2DataTypeCodeDescription",
		pct.yr2_pct_value AS "year2PercentValue",
		pct.yr3_qual_data_year AS "year3",
		pct.yr3_qual_data_type_cd AS "year3DataTypeCode",
		'Data Type Codes' AS "year3DataTypeCodeGroup",
		qdtc3.qual_data_type_cd_description AS "year3DataTypeCodeDescription",
		pct.yr3_pct_value AS "year3PercentValue"
	FROM camdecmpswks.monitor_qualification_pct pct
	JOIN camdecmpswks.monitor_qualification mq USING(mon_qual_id)
	JOIN camdecmpswks.monitor_plan_location mpl USING(mon_loc_id)
	JOIN camdecmpswks.monitor_location ml USING(mon_loc_id)
	JOIN camdecmpsmd.qual_type_code qtc USING(qual_type_cd)
	LEFT JOIN camdecmpsmd.qual_data_type_code qdtc1 ON pct.yr1_qual_data_type_cd = qdtc1.qual_data_type_cd
	LEFT JOIN camdecmpsmd.qual_data_type_code qdtc2 ON pct.yr2_qual_data_type_cd = qdtc2.qual_data_type_cd
	LEFT JOIN camdecmpsmd.qual_data_type_code qdtc3 ON pct.yr3_qual_data_type_cd = qdtc3.qual_data_type_cd	
	LEFT JOIN camdecmpswks.stack_pipe sp USING(stack_pipe_id)
    LEFT JOIN camd.unit u USING(unit_id)
	WHERE mpl.mon_plan_id = monPlanId
	ORDER BY u.unitid, sp.stack_name, pct.qual_year;
$BODY$;
