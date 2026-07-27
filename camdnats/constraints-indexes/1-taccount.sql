---------------------
-- General Indexes --
---------------------

CREATE INDEX TACCOUNT_TYP_IX ON CAMDNATS.TACCOUNT (ACCTTYPE_CD);


-----------------
-- Constraints --
-----------------

ALTER TABLE CAMDNATS.TACCOUNT ADD CONSTRAINT TACCOUNT_PK PRIMARY KEY (ACCTNUM_ID);
