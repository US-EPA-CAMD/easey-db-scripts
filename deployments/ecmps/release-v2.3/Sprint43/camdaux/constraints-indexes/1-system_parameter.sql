-----------------
-- Constraints --
-----------------

alter table CAMDAUX.SYSTEM_PARAMETER add constraint SYSTEM_PARAMETER_pk primary key ( System_Parameter_Name );
alter table CAMDAUX.SYSTEM_PARAMETER add constraint SYSTEM_PARAMETER_NAME_UPPER_CK check (upper(System_Parameter_Name) = System_Parameter_Name);
alter table CAMDAUX.SYSTEM_PARAMETER add constraint SYSTEM_PARAMETER_NAME_SPACE_CK check (replace(System_Parameter_Name, ' ', '') = System_Parameter_Name);
