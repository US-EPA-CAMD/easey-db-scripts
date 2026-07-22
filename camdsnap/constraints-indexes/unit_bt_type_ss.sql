--------------------
-- Unique Indexes --
--------------------

create unique index UNIT_BT_TYPE_SS_UQ on camdsnap.UNIT_BT_TYPE_SS ( unit_bt_id );


---------------------
-- General Indexes --
---------------------

create index UNIT_BT_TYPE_SS_UNT_IX on camdsnap.UNIT_BT_TYPE_SS ( unit_id );
