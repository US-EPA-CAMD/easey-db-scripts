--------------------
-- Unique Indexes --
--------------------

create unique index TRANSACTION_SS_UQ on camdsnap.TRANSACTION_SS ( trans_id );


---------------------
-- General Indexes --
---------------------

create index TRANSACTION_SS_TRN_IX on camdsnap.TRANSACTION_SS ( trans_status_cd, trans_type_cd, trans_id );
create index TRANSACTION_SS_CHG_TRN_IX on camdsnap.TRANSACTION_SS ( trans_status_cd, trans_type_cd, changed_trans_id );
create index TRANSACTION_SS_BUY_TYPE_IX on camdsnap.TRANSACTION_SS ( buy_account_id, trans_type_cd );
create index TRANSACTION_SS_PRG_IX on camdsnap.TRANSACTION_SS ( prg_cd );
create index TRANSACTION_SS_TRN_IX on camdsnap.TRANSACTION_SS ( trans_number );
create index TRANSACTION_SS_BUY_DATE_IX on camdsnap.TRANSACTION_SS ( buy_account_id, trans_date );
create index TRANSACTION_SS_ACP_IX on camdsnap.TRANSACTION_SS ( account_comp_id );
create index TRANSACTION_SS_SEL_IX on camdsnap.TRANSACTION_SS ( sell_account_id );
