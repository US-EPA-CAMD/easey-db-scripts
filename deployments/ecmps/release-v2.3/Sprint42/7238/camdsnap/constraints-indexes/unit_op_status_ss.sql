--------------------
-- Unique Indexes --
--------------------

create unique index UNIT_OP_STATUS_SS_UQ on camdsnap.UNIT_OP_STATUS_SS ( uos_id );

---------------------
-- General Indexes --
---------------------

create index UNIT_OP_STATUS_SS_UNT_OP_STAT_IX on camdsnap.UNIT_OP_STATUS_SS ( unit_id, op_status );
create index UNIT_OP_STATUS_SS_UNT_DATES_IX on camdsnap.UNIT_OP_STATUS_SS ( unit_id, begin_date, end_date );
