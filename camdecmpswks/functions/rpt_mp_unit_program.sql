-- FUNCTION: camdecmpswks.rpt_mp_unit_program(character varying)

DROP FUNCTION IF EXISTS camdecmpswks.rpt_mp_unit_program(character varying);

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_mp_unit_program(
	monplanid character varying)
    RETURNS TABLE("unitIdentifier" text, "programCode" text, "programCodeGroup" text, "programCodeDescription" text, "unitClassification" text, "unitMonitorCertBeginDate" text, "unitMonitorCertDeadline" text) 
    LANGUAGE 'sql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
SELECT
		u.unitid AS "unitIdentifier",
		up.prg_cd AS "programCode",
		'Program Codes' AS "programCodeGroup",
		pc.prg_description AS "programCodeDescription",
		up.class_cd || ' - ' || cc.class_description AS "unitClassification",
		camdecmpswks.format_date_hour(up.unit_monitor_cert_begin_date, null, null) AS "unitMonitorCertBeginDate",
		camdecmpswks.format_date_hour(up.unit_monitor_cert_deadline, null, null) AS "unitMonitorCertDeadline"
	FROM camd.unit_program up
	JOIN camd.unit u USING(unit_id)
	JOIN camdecmpswks.monitor_location ml USING(unit_id)
	JOIN camdecmpswks.monitor_plan_location mpl USING(mon_loc_id)
	LEFT JOIN camdmd.program_code pc USING(prg_cd)
	LEFT JOIN camdmd.class_code cc USING(class_cd)
	WHERE mpl.mon_plan_id = monPlanId
	ORDER By u.unitid, up.prg_cd;
$BODY$;
