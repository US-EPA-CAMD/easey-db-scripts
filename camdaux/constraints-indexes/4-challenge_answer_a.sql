ALTER TABLE camdaux.challenge_answer_a
        ADD CONSTRAINT fk_challenge_answer_person FOREIGN KEY (ppl_id) 
            REFERENCES camd.person (ppl_id);
ALTER TABLE camdaux.challenge_answer_a
        ADD CONSTRAINT fk_challenge_answer_question FOREIGN KEY (challenge_question_id) 
            REFERENCES camdmd.challenge_question (challenge_question_id);

CREATE INDEX IF NOT EXISTS idx_challenge_answer_person 
  ON camdaux.challenge_answer_a (ppl_id);
CREATE INDEX IF NOT EXISTS idx_challenge_answer_question 
  ON camdaux.challenge_answer_a (challenge_question_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_challenge_answer_a 
  ON camdaux.challenge_answer_a (challenge_answer_id);