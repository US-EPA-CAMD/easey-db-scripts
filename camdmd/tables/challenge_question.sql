CREATE TABLE IF NOT EXISTS camdmd.challenge_question
(
    challenge_question_id numeric NOT NULL,
    question varchar(255) NOT NULL,
    add_date timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (challenge_question_id)
);
COMMENT ON TABLE camdmd.challenge_question
    IS 'Stores the active challenge questions in the system.';
COMMENT ON COLUMN camdmd.challenge_question.challenge_question_id
    IS 'Challenge question identity key.';
COMMENT ON COLUMN camdmd.challenge_question.question
    IS 'The full text of the challenge question.';
COMMENT ON COLUMN camdmd.challenge_question.add_date
    IS 'Date the record was added.';