-- FUNCTION: camdecmpswks.rpt_mp_waf_duct_rect(character varying)

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_mp_waf_duct_rect
(
	monplanid character varying
)
RETURNS TABLE
(
    "unitStack" text,
    "wafMethod" text,
    "wafValue" text,
    "numTestRuns" text,
    "numTraversePointsWaf" text,
    "numTestPorts" text,
    "numTraversePointsRef" text,
    "ductWidth" text,
    "ductDepth" text,
    "determinationDate" text,
    "effectiveDateHour" text,
    "endDateHour" text
) 
LANGUAGE 'sql'

    COST 100
    VOLATILE 
    ROWS 1000

AS $BODY$

    select  coalesce( unt.unitid, stp.stack_name ) as "unitStack",
            wmc.waf_method_cd_description as "wafMethod",
            waf.waf_value as "wafValue",
            waf.num_test_runs as "numTestRuns",
            waf.num_traverse_points_waf as "numTraversePointsWaf",
            waf.num_test_ports as "numTestPorts",
            waf.num_traverse_points_ref as "numTraversePointsRef",
            waf.duct_width as "ductWidth",
            waf.duct_depth as "ductDepth",
            to_char( waf.waf_determined_date, 'mm/dd/yyyy' ) as "determinationDate",
            camdecmpswks.format_date_hour( waf.waf_effective_date , waf.waf_effective_hour , null ) as "effectiveDateHour",
            camdecmpswks.format_date_hour( waf.end_date, waf.end_hour, null )  as "endDateHour"
      from  camdecmpswks.MONITOR_PLAN_LOCATION mpl
            join camdecmpswks.RECT_DUCT_WAF waf using ( mon_loc_id )
            join camdecmpswks.MONITOR_LOCATION loc using ( mon_loc_id )
            left join camdecmpswks.STACK_PIPE stp using ( stack_pipe_id )
            left join camdecmpswks.UNIT unt using ( unit_id )
            left join camdecmpsmd.WAF_METHOD_CODE wmc using ( waf_method_cd )
     where  mpl.mon_plan_id = monplanid
     order  
        by  "unitStack",
            "wafMethod";

$BODY$;
