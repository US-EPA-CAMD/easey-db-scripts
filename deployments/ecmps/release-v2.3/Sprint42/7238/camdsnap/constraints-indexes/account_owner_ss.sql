--------------------
-- Unique Indexes --
--------------------

create unique index ACCOUNT_OWNER_SS_PK_UQ on camdsnap.ACCOUNT_OWNER_SS ( account_own_id );
create unique index ACCOUNT_OWNER_SS_IDS_DTS_UQ on camdsnap.ACCOUNT_OWNER_SS ( account_id, comp_id, ppl_id, begin_date, end_date, ont_type_cd );