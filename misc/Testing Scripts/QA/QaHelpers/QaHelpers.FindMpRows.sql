use ECMPS
go

select  fac.ORIS_CODE,
        fac.FACILITY_NAME,
        isnull( unt.UNITID, stp.STACK_NAME ) as LOCATION_NAME
        , dat.*
  from  MONITOR_LOCATION loc
        left join UNIT unt on unt.UNIT_ID = loc.UNIT_ID
        left join STACK_PIPE stp on stp.STACK_PIPE_ID = loc.STACK_PIPE_ID
        join FACILITY fac on fac.FAC_ID in ( unt.FAC_ID, stp.FAC_ID )
        join MONITOR_METHOD dat on dat.MON_LOC_ID = loc.MON_LOC_ID
 where  fac.ORIS_CODE = 3
   and  isnull( unt.UNITID, stp.STACK_NAME ) in ( '4' )
   and  dat.PARAMETER_CD in ( 'CO2' )
   and  dat.METHOD_CD in ( 'CEM' )

use ECMPS
go

select  fac.ORIS_CODE,
        fac.FACILITY_NAME,
        isnull( unt.UNITID, stp.STACK_NAME ) as LOCATION_NAME
        , dat.*
  from  MONITOR_LOCATION loc
        left join UNIT unt on unt.UNIT_ID = loc.UNIT_ID
        left join STACK_PIPE stp on stp.STACK_PIPE_ID = loc.STACK_PIPE_ID
        join FACILITY fac on fac.FAC_ID in ( unt.FAC_ID, stp.FAC_ID )
        join MONITOR_SYSTEM dat on dat.MON_LOC_ID = loc.MON_LOC_ID
 where  fac.ORIS_CODE = 2442
   and  isnull( unt.UNITID, stp.STACK_NAME ) in ( '4' )
   and  dat.SYSTEM_IDENTIFIER in ( 'F43' )


use ECMPS
go

select  fac.ORIS_CODE,
        fac.FACILITY_NAME,
        isnull( unt.UNITID, stp.STACK_NAME ) as LOCATION_NAME
        , dat.*
  from  MONITOR_LOCATION loc
        left join UNIT unt on unt.UNIT_ID = loc.UNIT_ID
        left join STACK_PIPE stp on stp.STACK_PIPE_ID = loc.STACK_PIPE_ID
        join FACILITY fac on fac.FAC_ID in ( unt.FAC_ID, stp.FAC_ID )
        join COMPONENT dat on dat.MON_LOC_ID = loc.MON_LOC_ID
 where  fac.ORIS_CODE = 3
   and  isnull( unt.UNITID, stp.STACK_NAME ) in ( '4' )
   and  dat.COMPONENT_IDENTIFIER in ( 'NAX' )
 