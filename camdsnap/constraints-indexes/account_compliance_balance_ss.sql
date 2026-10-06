--------------------
-- Unique Indexes --
--------------------

create unique index ACCOUNT_COMPLIANCE_BALANCE_SS_UQ on camdsnap.ACCOUNT_COMPLIANCE_BALANCE_SS ( ACCOUNT_COMP_BAL_ID );


---------------------
-- General Indexes --
---------------------

create index ACCOUNT_COMPLIANCE_BALANCE_SS_ACP_IX on camdsnap.ACCOUNT_COMPLIANCE_BALANCE_SS (ACCOUNT_COMP_ID);
