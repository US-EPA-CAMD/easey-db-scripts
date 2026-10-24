---------------------
-- General Indexes --
---------------------

CREATE INDEX UNIT_PHASE_YEAR_DIM_PHS_UNT_OYR_IX ON CAMDDMW.UNIT_PHASE_YEAR_DIM ( PHASE, UNIT_ID, OP_YEAR );
CREATE INDEX UNIT_PHASE_YEAR_DIM_UNT_OYR_PHS_PAR_IX ON CAMDDMW.UNIT_PHASE_YEAR_DIM ( UNIT_ID, OP_YEAR, PHASE, PARAMETER );
CREATE INDEX unit_phase_year_dim_par_ix ON camddmw.unit_phase_year_dim USING btree ("parameter");


-----------------
-- Constraints --
-----------------

ALTER TABLE CAMDDMW.UNIT_PHASE_YEAR_DIM ADD CONSTRAINT UNIT_PHASE_YEAR_DIM_PK PRIMARY KEY ( UNIT_ID, OP_YEAR, PARAMETER );
