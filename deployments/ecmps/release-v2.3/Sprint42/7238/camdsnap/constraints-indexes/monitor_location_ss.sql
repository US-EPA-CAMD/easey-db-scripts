--------------------
-- Unique Indexes --
--------------------

create unique index MONITOR_LOCATION_SS_LOC_UQ on camdsnap.MONITOR_LOCATION_SS ( mon_loc_id );
create unique index MONITOR_LOCATION_SS_STP_UQ on camdsnap.MONITOR_LOCATION_SS ( stack_pipe_id ) where stack_pipe_id is not null;
create unique index MONITOR_LOCATION_SS_UNT_UQ on camdsnap.MONITOR_LOCATION_SS ( unit_id ) where unit_id is not null;
