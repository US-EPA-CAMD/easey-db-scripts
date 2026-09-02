--------------------
-- Unique Indexes --
--------------------

create unique index ACCOUNT_SS_AN_UQ on camdsnap.ACCOUNT_SS ( account_number );
create unique index ACCOUNT_SS_PK_UQ on camdsnap.ACCOUNT_SS ( account_id ) ;