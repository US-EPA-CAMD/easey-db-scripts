--------------------
-- Unique Indexes --
--------------------

create unique index TCOMPPROB_TRANSACT_SS_UQ on camdsnap.TCOMPPROB_TRANSACT_SS ( tranevnt_cnt, acctnum_id, compyear_dt, trantype_cd, allwyear_dt );
