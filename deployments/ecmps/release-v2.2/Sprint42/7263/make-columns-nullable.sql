
---------------
-- CAMDECMPS --
---------------

alter table camdecmps.EMISSION_VIEW_CO2APPD alter column FUEL_SYS_ID drop not null;
alter table camdecmps.EMISSION_VIEW_CO2DAILYFUEL alter column FUEL_CD drop not null;
alter table camdecmps.EMISSION_VIEW_DAILYCAL alter column TEST_SUM_ID drop not null;
alter table camdecmps.EMISSION_VIEW_HIAPPD alter column FUEL_SYS_ID drop not null;
alter table camdecmps.EMISSION_VIEW_MASSOILCALC alter column FUEL_SYS_ID drop not null;
alter table camdecmps.EMISSION_VIEW_MATSSORBENT alter column DATE_HOUR drop not null;
alter table camdecmps.EMISSION_VIEW_MATSSORBENT alter column END_DATE_TIME drop not null;
alter table camdecmps.EMISSION_VIEW_MATSWEEKLY alter column DATE_HOUR drop not null;
alter table camdecmps.EMISSION_VIEW_NOXAPPESINGLEFUEL alter column FUEL_SYS_ID drop not null;
alter table camdecmps.EMISSION_VIEW_OTHERDAILY alter column TEST_SUM_ID drop not null;
alter table camdecmps.EMISSION_VIEW_SO2APPD alter column FUEL_SYS_ID drop not null;


------------------
-- CAMDECMPSWKS --
------------------

alter table camdecmpswks.EMISSION_VIEW_CO2APPD alter column FUEL_SYS_ID drop not null;
alter table camdecmpswks.EMISSION_VIEW_CO2DAILYFUEL alter column FUEL_CD drop not null;
alter table camdecmpswks.EMISSION_VIEW_DAILYCAL alter column TEST_SUM_ID drop not null;
alter table camdecmpswks.EMISSION_VIEW_HIAPPD alter column FUEL_SYS_ID drop not null;
alter table camdecmpswks.EMISSION_VIEW_MASSOILCALC alter column FUEL_SYS_ID drop not null;
alter table camdecmpswks.EMISSION_VIEW_MATSSORBENT alter column DATE_HOUR drop not null;
alter table camdecmpswks.EMISSION_VIEW_MATSSORBENT alter column END_DATE_TIME drop not null;
alter table camdecmpswks.EMISSION_VIEW_MATSWEEKLY alter column DATE_HOUR drop not null;
alter table camdecmpswks.EMISSION_VIEW_NOXAPPEMIXEDFUEL alter column SYSTEM_ID drop not null;
alter table camdecmpswks.EMISSION_VIEW_NOXAPPESINGLEFUEL alter column FUEL_SYS_ID drop not null;
alter table camdecmpswks.EMISSION_VIEW_OTHERDAILY alter column TEST_SUM_ID drop not null;
alter table camdecmpswks.EMISSION_VIEW_SO2APPD alter column FUEL_SYS_ID drop not null;
