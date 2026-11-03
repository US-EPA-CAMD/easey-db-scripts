CREATE TABLE IF NOT EXISTS CAMDDMW.STATE_ALTERNATE_OZONE_BEGAN
(
  STATE       VARCHAR(2)    NOT NULL,
  YEAR        NUMERIC(4)    NOT NULL,
  DATE_BEGAN  DATE          NOT NULL
);


COMMENT ON TABLE CAMDDMW.STATE_ALTERNATE_OZONE_BEGAN IS 'Contains alternate ozone season begin dates for state and year combinations for which ozone season does not begin on April 1st.';


COMMENT ON COLUMN CAMDDMW.STATE_ALTERNATE_OZONE_BEGAN.STATE IS 'State of the alternate begin date.';
COMMENT ON COLUMN CAMDDMW.STATE_ALTERNATE_OZONE_BEGAN.YEAR IS 'Year of the alternate begin date';
COMMENT ON COLUMN CAMDDMW.STATE_ALTERNATE_OZONE_BEGAN.DATE_BEGAN IS 'THe alternate ozone season begin date.';
