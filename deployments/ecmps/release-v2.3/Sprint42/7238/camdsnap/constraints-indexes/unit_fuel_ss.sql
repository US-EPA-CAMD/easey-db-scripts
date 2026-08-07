--------------------
-- Unique Indexes --
--------------------

create unique index UNIT_FUEL_SS_UQ ON camdsnap.UNIT_FUEL_SS (UF_ID);


---------------------
-- General Indexes --
---------------------

create index UNIT_FUEL_SS_UNT_IX on camdsnap.UNIT_FUEL_SS ( unit_id );
