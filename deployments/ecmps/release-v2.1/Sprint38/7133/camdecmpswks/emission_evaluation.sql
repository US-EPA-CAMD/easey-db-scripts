ALTER TABLE camdecmpswks.emission_evaluation
ADD COLUMN submission_comment text COLLATE pg_catalog."default";

COMMENT ON COLUMN camdecmpswks.emission_evaluation.submission_comment
    IS 'Comment provided by the user at the time of submission.';
