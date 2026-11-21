--run using psql command against target database from this directory.
-- psql -h <HOST> -p <PORT> -U <DB_USER> <DB_NAME> (will prompt for password)
--	\i ./2-create-dm-constraints-indexes.sql

\set ON_ERROR_STOP on

\i ../../../../../camddmw/constraints-indexes/1-account_fact.sql
\i ../../../../../camddmw/constraints-indexes/1-allowance_valid_year.sql
\i ../../../../../camddmw/constraints-indexes/1-monitor_fact.sql
\i ../../../../../camddmw/constraints-indexes/1-op_year.sql
\i ../../../../../camddmw/constraints-indexes/1-program_year_dim.sql
\i ../../../../../camddmw/constraints-indexes/1-state_allocation_fact.sql
\i ../../../../../camddmw/constraints-indexes/1-state_alternate_ozone_began.sql
\i ../../../../../camddmw/constraints-indexes/1-transaction_fact.sql
\i ../../../../../camddmw/constraints-indexes/1-unit_fact.sql
\i ../../../../../camddmw/constraints-indexes/2-account_compliance_dim.sql
\i ../../../../../camddmw/constraints-indexes/2-account_owner_dim.sql
\i ../../../../../camddmw/constraints-indexes/2-account_rep_dim.sql
\i ../../../../../camddmw/constraints-indexes/2-allowance_holding_dim.sql
\i ../../../../../camddmw/constraints-indexes/2-bank_dim.sql
\i ../../../../../camddmw/constraints-indexes/2-control_year_dim.sql
\i ../../../../../camddmw/constraints-indexes/2-fuel_year_dim.sql
\i ../../../../../camddmw/constraints-indexes/2-op_status_year_dim.sql
\i ../../../../../camddmw/constraints-indexes/2-owner_display_fact.sql
\i ../../../../../camddmw/constraints-indexes/2-owner_year_dim.sql
\i ../../../../../camddmw/constraints-indexes/2-rep_display_fact.sql
\i ../../../../../camddmw/constraints-indexes/2-rep_year_dim.sql
\i ../../../../../camddmw/constraints-indexes/2-transaction_block_dim.sql
\i ../../../../../camddmw/constraints-indexes/2-transaction_owner_dim.sql
\i ../../../../../camddmw/constraints-indexes/2-unit_compliance_dim.sql
\i ../../../../../camddmw/constraints-indexes/2-unit_phase_year_dim.sql
\i ../../../../../camddmw/constraints-indexes/2-unit_type_year_dim.sql
