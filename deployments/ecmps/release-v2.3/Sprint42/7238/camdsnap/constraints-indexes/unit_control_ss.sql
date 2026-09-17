--------------------
-- Unique Indexes --
--------------------

create unique index UNIT_CONTROL_SS_UQ on camdsnap.UNIT_CONTROL_SS ( ctl_id );
 

---------------------
-- General Indexes --
---------------------

create index UNIT_CONTROL_SS_UNT_IX on camdsnap.UNIT_CONTROL_SS ( unit_id );
CREATE INDEX unit_control_ss_param_ix ON camdsnap.unit_control_ss USING btree (ce_param);
