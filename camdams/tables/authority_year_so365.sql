CREATE TABLE IF NOT EXISTS camdams.authority_year_so365
(
    year numeric(4,0) NOT NULL,
    state varchar(2) NOT NULL,
    nox numeric NOT NULL,
    setaside_pct numeric NOT NULL,
    setaside_amt numeric NOT NULL,
    indian_amt numeric
);