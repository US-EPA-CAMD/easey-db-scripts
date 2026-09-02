--------------------
-- Unique Indexes --
--------------------

create unique index UNIT_OWNER_SS_UQ on camdsnap.UNIT_OWNER_SS ( uon_id );
create unique index UNIT_OWNER_SS_CMB_IX on camdsnap.UNIT_OWNER_SS ( unit_id, own_id, begin_date, end_date, ont_type_cd );
