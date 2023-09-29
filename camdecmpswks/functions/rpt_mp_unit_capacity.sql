-- FUNCTION: camdecmpswks.rpt_mp_unit_capacity(character varying)

DROP FUNCTION IF EXISTS camdecmpswks.rpt_mp_unit_capacity(character varying) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_mp_unit_capacity(
	monplanid character varying)
    RETURNS TABLE("unitIdentifier" text, "nonLoadBasedIndicator" text, "commercialOpDate" text, "commenceOpDate" text, "unitTypeCode" text, "unitTypeCodeGroup" text, "unitTypeCodeDescription" text, "unitBeginDate" text, "unitEndDate" text, "maxHeatInput" numeric, "maxHeatInputBeginDate" text, "maxHeatInputEndDate" text) 
    LANGUAGE 'sql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
SELECT
		u.unitid AS "unitIdentifier",
		camdecmpswks.format_indicator(u.non_load_based_ind, true) AS "nonLoadBasedIndicator",
		camdecmpswks.format_date_hour(u.comr_op_date, null, null) AS "commercialOpDate",
		camdecmpswks.format_date_hour(u.comm_op_date, null, null) AS "commenceOpDate",
		ubt.unit_type_cd AS "unitTypeCode",
		'Unit Type Codes' AS "unitTypeCodeGroup",
		utc.unit_type_description AS "unitTypeCodeDescription",
		camdecmpswks.format_date_hour(ubt.begin_date, null, null) AS "unitBeginDate",
		camdecmpswks.format_date_hour(ubt.end_date, null, null) AS "unitEndDate",
		uc.max_hi_capacity AS "maxHeatInput",
		camdecmpswks.format_date_hour(uc.begin_date, null, null) AS "maxHeatInputBeginDate",
		camdecmpswks.format_date_hour(uc.end_date, null, null) AS "maxHeatInputEndDate"
	FROM camdecmpswks.unit_capacity uc
	JOIN camd.unit u USING(unit_id)
	JOIN camd.unit_boiler_type ubt USING(unit_id)
	JOIN camdecmpswks.monitor_location ml USING(unit_id)
	JOIN camdecmpswks.monitor_plan_location mpl USING(mon_loc_id)
	JOIN camdmd.unit_type_code utc USING(unit_type_cd)
	WHERE mpl.mon_plan_id = monPlanId
	ORDER BY u.unitid;
$BODY$;
