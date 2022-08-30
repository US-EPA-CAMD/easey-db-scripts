-- FUNCTION: camdecmpswks.rpt_mp_unit_capacity(character varying)

-- DROP FUNCTION camdecmpswks.rpt_mp_unit_capacity(character varying);

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_mp_unit_capacity(
	monplanid character varying)
    RETURNS TABLE("unitIdentifier" text, "nonLoadBasedIndicator" numeric, "commercialOpDate" text, "commenceOpDate" text, "unitTypeCode" text, "unitTypeCodeDescription" text, "beginDate" text, "endDate" text, "maxHICapacity" numeric, "capacityBeginDate" text, "capacityEndDate" text) 
    LANGUAGE 'sql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
SELECT
		u.unitid AS "unitIdentifier",
		u.non_load_based_ind AS "nonLoadBasedIndicator",
		CAST(u.comr_op_date as text) AS "commercialOpDate",
		CAST(u.comm_op_date as text) AS "commenceOpDate",
		ubt.unit_type_cd AS "unitTypeCode",
		utc.unit_type_description AS "unitTypeCodeDescription",
		CAST(ubt.begin_date as text) AS "beginDate",
		CAST(ubt.end_date as text) AS "endDate",
		uc.max_hi_capacity AS "maxHICapacity",
		CAST(uc.begin_date as text) AS "capacityBeginDate",
		CAST(uc.end_date as text) AS "capacityEndDate"
	FROM camdecmpswks.unit_capacity uc
	 JOIN camd.unit u USING(unit_id)
	 JOIN camd.unit_boiler_type ubt USING(unit_id)
	 JOIN camdecmpswks.monitor_location ml USING(unit_id)
	 JOIN camdecmpswks.monitor_plan_location mpl USING(mon_loc_id)
	 JOIN camdecmpswks.monitor_plan mp USING(mon_plan_id)
	 JOIN camdmd.unit_type_code utc USING(unit_type_cd)
	WHERE mp.mon_plan_id = monPlanId;
$BODY$;
