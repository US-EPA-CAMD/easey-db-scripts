--------------------
-- Unique Indexes --
--------------------

create unique index FACILITY_PEOPLE_SS_UQ on camdsnap.FACILITY_PEOPLE_SS ( fac_ppl_id );
CREATE INDEX facility_people_ss_end_date ON camdsnap.facility_people_ss USING btree (end_date);
