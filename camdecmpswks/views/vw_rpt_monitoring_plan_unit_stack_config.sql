CREATE OR REPLACE VIEW camdecmpswks.vw_rpt_monitoring_plan_unit_stack_config (unitid, mon_plan_id, begin_date, end_date) AS
AS
SELECT DISTINCT
unitid,
mon_plan_id,
begin_date,
end_date
--CONVERT(VARCHAR(10), CONVERT(DATETIME, begin_date, 101), 101) AS begin_date,
--CONVERT(VARCHAR(10), CONVERT(DATETIME, end_date, 101), 101) AS end_date
FROM camdecmpswks.vw_mp_unit_stack_configuration AS mpusc