USE [ECMPS_AUX]
GO

select  *
  from  [SYSTEM_PARAMETER]
 where  [SYS_PARAM_ID] = 5
 order
    by  [SYS_PARAM_ID]

update  [SYSTEM_PARAMETER]
   set  [PARAM_VALUE1] = 'localhost/ECMPS/DEV/',
        [PARAM_VALUE2] = 'ecmps.epa.gov/',
        [PARAM_VALUE3] = 'ecmps.epa.gov/ECMPST'
 where  [SYS_PARAM_ID] = 5

select  *
  from  [SYSTEM_PARAMETER]
 where  [SYS_PARAM_ID] = 5
 order
    by  [SYS_PARAM_ID]

GO
