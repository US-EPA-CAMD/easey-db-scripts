--------------------
-- Unique Indexes --
--------------------

create unique index ACCOUNT_PEOPLE_SS_UQ on camdsnap.ACCOUNT_PEOPLE_SS ( account_ppl_id );
CREATE INDEX account_people_ss_end_date ON camdsnap.account_people_ss USING btree (end_date);
