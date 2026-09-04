---------------------
-- General Indexes --
---------------------

CREATE INDEX VALID_YEAR_VYR_IX ON CAMDDMW.VALID_YEAR ( VALID_YEAR );


-- 
-- Non Foreign Key Constraints for Table VALID_YEAR 
-- 
ALTER TABLE CAMDDMW.VALID_YEAR ADD CONSTRAINT VALID_YEAR_PK PRIMARY KEY ( OP_QUARTER, VALID_YEAR );
