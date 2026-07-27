---------------------
-- General Indexes --
---------------------

CREATE INDEX TSERIAL_ACC_IX ON CAMDNATS.TSERIAL (ACCTNUM_ID);


-----------------
-- Constraints --
-----------------

ALTER TABLE CAMDNATS.TSERIAL ADD CONSTRAINT TSERIAL_PK PRIMARY KEY (ALLWYEAR_DT, SERSTART_CNT);
