--------------------
-- Unique Indexes --
--------------------

create unique index UNIT_PROGRAM_SS_UQ on camdsnap.UNIT_PROGRAM_SS ( up_id );


---------------------
-- General Indexes --
---------------------

create index UNIT_PROGRAM_SS_UNT_IX on camdsnap.UNIT_PROGRAM_SS ( unit_id );
