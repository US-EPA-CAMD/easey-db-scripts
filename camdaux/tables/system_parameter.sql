-- Create table
create table if not exists CAMDAUX.SYSTEM_PARAMETER
(
  System_Parameter_Name         varchar(100)    not null,
  System_Parameter_Value        varchar(1000),
  System_Parameter_Description  varchar(1000)
);

-- Add comments to the table
comment on table CAMDAUX.SYSTEM_PARAMETER is 'Contains parameters specific to and instance of the CAMD database.';

-- Add comments to the columns
comment on column CAMDAUX.SYSTEM_PARAMETER.System_Parameter_Name is 'The name of the system parameter, capitalized and without spaces.';
comment on column CAMDAUX.SYSTEM_PARAMETER.System_Parameter_Value is 'The value of the system parameter.';
comment on column CAMDAUX.SYSTEM_PARAMETER.System_Parameter_Description is 'The purpose of the system parameter.';
