--------------------
-- Unique Indexes --
--------------------

create unique index TRANSACTION_BLOCK_SS_UQ on camdsnap.TRANSACTION_BLOCK_SS ( trans_block_id );


---------------------
-- General Indexes --
---------------------

create index TRANSACTION_BLOCK_SS_PRV_IX on camdsnap.TRANSACTION_BLOCK_SS ( prg_vintage_id );
create index TRANSACTION_BLOCK_SS_TRN_IX on camdsnap.TRANSACTION_BLOCK_SS ( trans_id );
