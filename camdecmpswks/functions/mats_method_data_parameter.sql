-- FUNCTION: camdecmpswks.mats_method_data_parameter(character varying)

DROP FUNCTION IF EXISTS camdecmpswks.mats_method_data_parameter(character varying);

CREATE OR REPLACE FUNCTION camdecmpswks.mats_method_data_parameter(
	monplanid character varying)
    RETURNS TABLE(mats_method_data_id text, mon_loc_id text, mats_method_cd text, mats_method_parameter_cd text, begin_date date, begin_hour numeric, end_date date, end_hour numeric, mon_plan_id text) 
    LANGUAGE 'sql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
select mth.MATS_METHOD_data_ID
      ,mth.MON_LOC_ID
      ,mth.MATS_METHOD_CD
      ,mth.MATS_METHOD_PARAMETER_CD
      ,mth.BEGIN_DATE
      ,mth.BEGIN_HOUR
      ,mth.END_DATE
      ,mth.END_HOUR
	  ,mpl.MON_PLAN_ID
	from	camdecmpswks.MATS_METHOD_DATA mth
			join camdecmpswks.MONITOR_PLAN_LOCATION mpl 
				on	mth.MON_LOC_ID = mpl.MON_LOC_ID
	where (mpl.MON_PLAN_ID = monplanid or monplanid is null);
$BODY$;
