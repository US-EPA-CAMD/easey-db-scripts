--------------------
-- Unique Indexes --
--------------------

create unique index UNIT_PROGRAM_PHASE_SS_UQ on camdsnap.UNIT_PROGRAM_PHASE_SS ( up_id, begin_year );

CREATE INDEX unit_program_phase_ss_phase_idx ON camdsnap.unit_program_phase_ss USING btree (phase);
