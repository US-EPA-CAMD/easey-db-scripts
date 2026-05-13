DROP FUNCTION IF EXISTS camdecmpsaux.get_units_expected_to_submit_report_data(numeric, character varying, character varying, character varying, numeric, numeric, character varying) CASCADE;

create or replace
function camdecmpsaux.get_units_expected_to_submit_report_data(
    V_FAC_ID numeric,
    V_FACILITY_NAME character varying,
    V_STATE character varying,
    V_PRG_CODE character varying,
    V_YEAR numeric,
    V_QUARTER numeric,
    V_WINDOW_STATUS character varying
)
returns table (
    ORIS_CODE numeric,
	FAC_ID numeric,
    FACILITY_NAME character varying,
    STATE character varying,
    UNITID character varying,
    LOCATIONS text,
    EM_SUB_TYPE_CD_DESCRIPTION character varying,
    ACCESS_BEGIN_DATE date,
    ACCESS_END_DATE date,
    WINDOW_STATUS text,
    SUBMISSION_STATUS text,
    SUBMISSION_ID bigint,
    SUBMISSION_DATE timestamp,
    SEVERITY_CD_DESCRIPTION character varying
)
as $BODY$
declare
    v_rpt_period_id numeric;

begin

    if V_PRG_CODE is null
or TRIM(both from V_PRG_CODE) = '' then
        raise exception 'Required input parameter [V_PRG_CODE] (program) was not provided or is empty.';
end if;

if V_YEAR is null then
        raise exception 'Required input parameter [V_YEAR] (year) was not provided.';
end if;

if V_QUARTER is null then
        raise exception 'Required input parameter [V_QUARTER] (quarter) was not provided.';
end if;

select
	RPT_PERIOD_ID
      into
	v_rpt_period_id
from
	camdecmpsmd.reporting_period
where
	calendar_year = V_YEAR
	and quarter = V_QUARTER;

return QUERY
    select
	F.ORIS_CODE,
	F.FAC_ID,
	F.FACILITY_NAME,
	F.STATE,
	U.UNITID,
	vmp.locations,
	ESA_SUB.EM_SUB_TYPE_CD_DESCRIPTION,
	ESA_SUB.ACCESS_BEGIN_DATE::date as ACCESS_BEGIN_DATE,
	ESA_SUB.ACCESS_END_DATE::date as ACCESS_END_DATE,
	coalesce(ESA_SUB.WINDOW_STATUS, 'No Window') as WINDOW_STATUS,
	ESA_SUB.SUBMISSION_STATUS,
	ESA_SUB.SUBMISSION_ID,
	ESA_SUB.SUBMISSION_DATE,
	ESA_SUB.SEVERITY_CD_DESCRIPTION
from
	camd.UNIT U
join camd.plant F
        on
	U.FAC_ID = F.FAC_ID
	and 
	F.FAC_ID = coalesce(V_FAC_ID, U.FAC_ID)
	and F.FACILITY_NAME = coalesce(V_FACILITY_NAME, F.FACILITY_NAME)
	and F.STATE = coalesce(V_STATE, F.STATE)
join (
	select
		U.UNIT_ID,
		max(ers.mon_plan_id) as mon_plan_id
	from
		camd.UNIT U
	join camdecmps.vw_em_reporting_status ers 
         on
		u.unit_id = ers.unit_id
		and ers.rpt_period_id = v_rpt_period_id
		and ers.prg_cd = coalesce(V_PRG_CODE, ers.prg_cd)
	group by
		U.UNIT_ID
        ) mp
        on
	u.unit_id = mp.unit_id
join camdecmps.vw_monitor_plan vmp on
	mp.mon_plan_id = vmp.mon_plan_id
left join 
        (
	select
		ESA.MON_PLAN_ID,
		ESA.EM_SUB_TYPE_CD_DESCRIPTION,
		ESA.ACCESS_BEGIN_DATE,
		ESA.ACCESS_END_DATE,
		ESA.WINDOW_STATUS,
		ESA.SUBMISSION_STATUS,
		ESA.SUBMISSION_ID,
		ESA.SUBMISSION_DATE,
		ESA.SEVERITY_CD_DESCRIPTION
	from
		camdecmpsaux.VW_EM_SUBMISSION_ACCESS ESA
	where
		ESA.RPT_PERIOD_ID = v_rpt_period_id
		and (ESA.LAST_WINDOW = 'Yes'
			or (ESA.EM_SUB_TYPE_CD = 'INITIAL'
				and ESA.SUB_AVAILABILITY_CD = 'DELETE'))
        ) ESA_SUB
        on
	mp.MON_PLAN_ID = ESA_SUB.MON_PLAN_ID
	and coalesce(ESA_SUB.WINDOW_STATUS, 'No Window') = coalesce(V_WINDOW_STATUS, coalesce(ESA_SUB.WINDOW_STATUS, 'No Window'))
order by
	F.ORIS_CODE,
	U.UNITID,
	vmp.locations;
end;

$BODY$ language plpgsql;
