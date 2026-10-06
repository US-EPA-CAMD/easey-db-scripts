--------------------
-- Unique Indexes --
--------------------

create unique index UNIT_SS_UNT_UQ on camdsnap.UNIT_SS ( unit_id );
create unique index UNIT_SS_ACC_UQ on camdsnap.UNIT_SS ( account );


---------------------
-- General Indexes --
---------------------

create index UNIT_SS_ACC_FAC_IX on camdsnap.UNIT_SS ( account, fac_id );
create index UNIT_SS_FAC_UNT_IX on camdsnap.UNIT_SS ( fac_id, unit_id );
create index UNIT_SS_UNT_IX on camdsnap.UNIT_SS ( unitid );
