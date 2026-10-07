---------------------
-- General Indexes --
---------------------

CREATE INDEX ALLOW_TRANEVNT_CNT_IX ON CAMDNATS.TALLOW (TRANEVNT_CNT);


-----------------
-- Constraints --
-----------------

ALTER TABLE CAMDNATS.TALLOW ADD CONSTRAINT TALLOW_PK PRIMARY KEY (TRANEVNT_CNT, ALLWYEAR_DT, SERSTART_CNT);
