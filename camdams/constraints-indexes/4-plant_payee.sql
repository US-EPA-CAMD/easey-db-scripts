CREATE INDEX IF NOT EXISTS idx_plant_payee_auct_pay_id 
  ON camdams.plant_payee (auction_payee_id);
CREATE INDEX IF NOT EXISTS idx_plant_payee_fac_id 
  ON camdams.plant_payee (fac_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_plant_payee 
  ON camdams.plant_payee (plant_payee_id);

ALTER TABLE camdams.plant_payee
        ADD CONSTRAINT fk_plant_payee_auction_payee FOREIGN KEY (auction_payee_id) 
            REFERENCES camdams.auction_payee (auction_payee_id);
ALTER TABLE camdams.plant_payee
        ADD CONSTRAINT fk_plant_payee_plant FOREIGN KEY (fac_id) 
            REFERENCES camd.plant (fac_id);