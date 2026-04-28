ALTER TABLE camdecmps.emission_evaluation
ADD COLUMN submission_comment text COLLATE pg_catalog."default";

COMMENT ON COLUMN camdecmps.emission_evaluation.submission_comment
    IS 'Comment provided by the user at the time of submission.';
