--------------------
-- Unique Indexes --
--------------------

create unique index UNIT_CAPACITY_SS_UQ on camdsnap.UNIT_CAPACITY_SS ( unit_cap_id );


---------------------
-- General Indexes --
---------------------

create index UNIT_CAPACITY_SS_UNT_IX on camdsnap.UNIT_CAPACITY_SS ( unit_id );
