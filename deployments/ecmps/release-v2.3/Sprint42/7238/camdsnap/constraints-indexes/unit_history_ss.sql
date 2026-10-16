--------------------
-- Unique Indexes --
--------------------

CREATE UNIQUE INDEX UNIT_HISTORY_SS_UQ ON UNIT_HISTORY_SS ( unit_id, effective_date );


---------------------
-- General Indexes --
---------------------

create index UNIT_HISTORY_SS_NEW_ACC_IX on UNIT_HISTORY_SS ( new_account_number );
create index UNIT_HISTORY_SS_NEW_FAC_IX on UNIT_HISTORY_SS ( new_fac_id );
create index UNIT_HISTORY_SS_OLD_ACC_IX on UNIT_HISTORY_SS ( old_account_number );
create index UNIT_HISTORY_SS_OLD_FAC_IX on UNIT_HISTORY_SS ( old_fac_id );
