-- View: camdecmpswks.VW_LOCATION_OPERATING_STATUS

-- DROP VIEW camdecmpswks.VW_LOCATION_OPERATING_STATUS;

create or replace view camdecmpswks.VW_LOCATION_OPERATING_STATUS as

    select  up.UNIT_OP_STATUS_ID as UOS_ID, 
            ml.ORIS_CODE, 
            ml.LOCATION_IDENTIFIER,
            ml.MON_LOC_ID, 
            ml.FAC_ID, 
            up.UNIT_ID, 
            u.UNITID,
            up.OP_STATUS_CD,
            case 
                WHEN usc.BEGIN_DATE is null THEN up.BEGIN_DATE
                WHEN up.BEGIN_DATE is null THEN usc.BEGIN_DATE
                WHEN up.BEGIN_DATE >= usc.BEGIN_DATE THEN up.BEGIN_DATE
                ELSE usc.BEGIN_DATE 
            end as BEGIN_DATE,
            case 
                WHEN usc.END_DATE is null THEN up.END_DATE
                WHEN up.END_DATE is null THEN usc.END_DATE
                WHEN up.END_DATE <= usc.END_DATE THEN up.END_DATE
                ELSE usc.END_DATE 
            end as END_DATE
      from 	camdecmpswks.VW_MONITOR_LOCATION ml 
            join camdecmpswks.UNIT_STACK_CONFIGURATION usc 
              on ml.STACK_PIPE_ID = usc.STACK_PIPE_ID
            join camd.UNIT_OP_STATUS up 
              on usc.UNIT_ID = up.UNIT_ID
            join camd.UNIT u 
              on u.UNIT_ID = usc.UNIT_ID
     where	( usc.END_DATE is null or up.BEGIN_DATE <= usc.END_DATE )
       and	( up.END_DATE is null or up.END_DATE >= usc.BEGIN_DATE )
    union
    select 	up.UNIT_OP_STATUS_ID as UOS_ID, 
            ml.ORIS_CODE, 
            ml.LOCATION_IDENTIFIER,
            ml.MON_LOC_ID, 
            ml.FAC_ID, 
            up.UNIT_ID, 
            u.UNITID,
            up.OP_STATUS_CD, 
            up.BEGIN_DATE, 
            up.END_DATE
      from 	camdecmpswks.VW_MONITOR_LOCATION ml 
            join camd.UNIT_OP_STATUS up 
              on ml.UNIT_ID = up.UNIT_ID
            join camd.UNIT u 
              on u.UNIT_ID = ml.UNIT_ID
