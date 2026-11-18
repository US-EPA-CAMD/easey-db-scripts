--------------------
-- Unique Indexes --
--------------------

create unique index MONITOR_PLAN_LOCATION_SS_UQ on camdsnap.MONITOR_PLAN_LOCATION_SS ( monitor_plan_location_id );


---------------------
-- General Indexes --
---------------------

create index MONITOR_PLAN_LOCATION_SS_LOC_IX on camdsnap.MONITOR_PLAN_LOCATION_SS ( mon_loc_id );
create index MONITOR_PLAN_LOCATION_SS_PLN_IX on camdsnap.MONITOR_PLAN_LOCATION_SS ( mon_plan_id );
