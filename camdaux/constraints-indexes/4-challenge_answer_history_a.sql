ALTER TABLE camdaux.challenge_answer_history_a
        ADD CONSTRAINT fk_challenge_ans_hist_person FOREIGN KEY (ppl_id) 
            REFERENCES camd.person (ppl_id);
ALTER TABLE camdaux.challenge_answer_history_a
        ADD CONSTRAINT fk_challenge_ans_hist_ques FOREIGN KEY (challenge_question_id) 
            REFERENCES camdmd.challenge_question (challenge_question_id);

CREATE INDEX IF NOT EXISTS idx_challenge_ans_hist_answer 
  ON camdaux.challenge_answer_history_a (challenge_answer_id);
CREATE INDEX IF NOT EXISTS idx_challenge_ans_hist_person 
  ON camdaux.challenge_answer_history_a (ppl_id);
CREATE INDEX IF NOT EXISTS idx_challenge_ans_hist_ques 
  ON camdaux.challenge_answer_history_a (challenge_question_id);
CREATE UNIQUE INDEX IF NOT EXISTS pk_challenge_answer_history_a 
  ON camdaux.challenge_answer_history_a (challenge_answer_history_id);