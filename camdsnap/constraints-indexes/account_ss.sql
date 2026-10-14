--------------------
-- Unique Indexes --
--------------------

create unique index ACCOUNT_SS_AN_UQ on camdsnap.ACCOUNT_SS ( account_number );
create unique index ACCOUNT_SS_PK_UQ on camdsnap.ACCOUNT_SS ( account_id ) ;
CREATE INDEX account_ss_account_type ON camdsnap.account_ss USING btree (account_type_cd);
