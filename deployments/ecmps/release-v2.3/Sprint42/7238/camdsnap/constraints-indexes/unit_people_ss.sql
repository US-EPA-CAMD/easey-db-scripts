---------------------
-- General Indexes --
---------------------

create index UNIT_PEOPLE_SS_IX on UNIT_PEOPLE_SS ( unit_id, ppl_id, prg_id, begin_date, end_date, responsibility_id );
