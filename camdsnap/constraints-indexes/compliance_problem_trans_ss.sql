--------------------
-- Unique Indexes --
--------------------

create unique index COMPLIANCE_PROBLEM_TRANS_SS_PK_UQ on camdsnap.COMPLIANCE_PROBLEM_TRANS_SS ( account_comp_id );
create unique index COMPLIANCE_PROBLEM_TRANS_SS_IDS_UQ on camdsnap.COMPLIANCE_PROBLEM_TRANS_SS ( trans_id, account_comp_id );