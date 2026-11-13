--------------------
-- Unique Indexes --
--------------------

create unique index PROGRAM_SS_UQ on camdsnap.PROGRAM_SS ( prg_id );


---------------------
-- General Indexes --
---------------------

create index PROGRAM_SS_PRC_IX on camdsnap.PROGRAM_SS ( prg_code );
