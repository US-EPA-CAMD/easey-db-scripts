-- FUNCTION: camdecmpswks.mats_combined_method(character varying)

DROP FUNCTION IF EXISTS camdecmpswks.mats_combined_method(character varying) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.mats_combined_method(
	monplanid character varying)
    RETURNS TABLE(mon_plan_id character varying, mon_loc_id character varying, parameter_group character varying, begin_datehour timestamp without time zone, end_datehour timestamp without time zone, method_source text, parameter_cd character varying, method_cd character varying, mon_method_id character varying) 
    LANGUAGE 'sql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
select mpl.MON_PLAN_ID, mth.MON_LOC_ID,	substr(mth.PARAMETER_CD, 1, length(mth.PARAMETER_CD) - 2) PARAMETER_GROUP,
	mth.BEGIN_DATE::TIMESTAMP + ((mth.BEGIN_HOUR)::TEXT || ' hours')::INTERVAL BEGIN_DATEHOUR,
	mth.END_DATE::TIMESTAMP + ((mth.END_HOUR)::TEXT || ' hours')::INTERVAL END_DATEHOUR,
	'GENERAL' METHOD_SOURCE, mth.PARAMETER_CD, mth.METHOD_CD, mth.MON_METHOD_ID
	from	camdecmpswks.MONITOR_PLAN_LOCATION mpl
	 join   camdecmpswks.MONITOR_METHOD mth   on mth.MON_LOC_ID = mpl.MON_LOC_ID
			-- Update the PARAMETER_GROUP columns logic if the following list changes.
	  and mth.PARAMETER_CD in ('HCLRE', 'HCLRH', 'HFRE', 'HFRH', 'HGRE', 'HGRH', 'SO2RE', 'SO2RH')
			WHERE (monplanid is null or mpl.MON_PLAN_ID = monplanid)
UNION		
	select	mpl.MON_PLAN_ID,mth.MON_LOC_ID,	grp.PARAMETER_GROUP,
			mth.BEGIN_DATE::TIMESTAMP + ((mth.BEGIN_HOUR)::TEXT || ' hours')::INTERVAL  BEGIN_DATEHOUR,
			mth.END_DATE::TIMESTAMP + ((mth.END_HOUR)::TEXT || ' hours')::INTERVAL END_DATEHOUR,
			'MATS_COMPLIANCE' METHOD_SOURCE, mth.MATS_METHOD_PARAMETER_CD PARAMETER_CD,
			mth.MATS_METHOD_CD METHOD_CD,	mth.MATS_METHOD_DATA_ID
		from	camdecmpswks.MONITOR_PLAN_LOCATION mpl
		join	camdecmpswks.MATS_METHOD_DATA mth on	mth.MON_LOC_ID = mpl.MON_LOC_ID
				-- We will likely replace the sub-query below with an alter version of the table it contains.
				join (
						select	MATS_METHOD_PARAMETER_CD,
									case (MATS_METHOD_PARAMETER_CD)
										when 'IM' then 'HG,HAP'
										when 'INHGM' then 'HAP'
										when 'TM' then 'HG,HAP'
										when 'TNHGM' then 'HAP'
										when 'LU' then 'HG'
										else MATS_METHOD_PARAMETER_CD
									end PARAMETER_GROUP_LIST
									from camdecmpsmd.MATS_METHOD_PARAMETER_CODE
						) pgl 	on	pgl.MATS_METHOD_PARAMETER_CD = mth.MATS_METHOD_PARAMETER_CD
				 join	(
							select	'HAP' PARAMETER_GROUP union
							select	'HCL' PARAMETER_GROUP union
							select	'HF' PARAMETER_GROUP union
							select	'HG' PARAMETER_GROUP
						) grp 
					on	 POSITION(',' || grp.PARAMETER_GROUP || ',' IN  ',' ||pgl.PARAMETER_GROUP_LIST || ',') > 0
		WHERE (monplanid is null or mpl.MON_PLAN_ID =monplanid)
$BODY$;
