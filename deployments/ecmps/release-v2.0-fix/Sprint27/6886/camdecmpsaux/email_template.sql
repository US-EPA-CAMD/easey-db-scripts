ALTER TABLE camdecmpsaux.email_template
ALTER COLUMN template_location TYPE varchar(500) COLLATE pg_catalog."default",
  ADD COLUMN template_description text COLLATE pg_catalog."default";

-- Update existing template locations to the new reorganized format
UPDATE camdecmpsaux.email_template
SET template_location = 'templates/email/submission-reminder/submission-reminder-not-received-151.html',
    template_description = 'Reminder email sent to users when no submission has been received by the deadline'
WHERE template_id = 151;

UPDATE camdecmpsaux.email_template
SET template_location = 'templates/email/submission-reminder/submission-reminder-resubmit-errors-152.html',
    template_description = 'Reminder email sent to users to resubmit data with errors that need correction'
WHERE template_id = 152;

UPDATE camdecmpsaux.email_template
SET template_location = 'templates/email/window-notification/submission-window-open-155.html',
    template_description = 'Notification email sent when the quarterly submission window opens for data submissions'
WHERE template_id = 155;

UPDATE camdecmpsaux.email_template
SET template_location = 'templates/email/submission-reminder/submission-reminder-past-due-156.html',
    template_description = 'Reminder email sent to users when their submission is past due and overdue'
WHERE template_id = 156;

UPDATE camdecmpsaux.email_template
SET template_location = 'templates/email/window-notification/resubmission-window-closed-157.html',
    template_description = 'Notification email sent when the resubmission window has closed for the quarter'
WHERE template_id = 157;

-- Delete unused template_id 150
DELETE FROM camdecmpsaux.email_template
WHERE template_id = 150;

-- Insert the new template configurations
INSERT INTO camdecmpsaux.email_template (template_id, template_location, template_subject, template_description)
VALUES
    (200, 'templates/email/submissions/confirmation/submission-confirmation.hbs', NULL, 'Main submission confirmation email sent to users'),
    (201, 'templates/email/submissions/feedback/submission-feedback.hbs', NULL, 'Detailed submission feedback with evaluation results'),
    (202, 'templates/email/submissions/errors/submission-failure-user.hbs', NULL, 'Submission processing failure email to Users'),
    (203, 'templates/email/submissions/errors/submission-failure-support.hbs', NULL, 'Submission processing failure email to Support team'),
    (204, 'templates/email/evaluations/evaluation-queueing-failure-user.hbs', NULL, 'Evaluation queueing failure email to Users'),
    (205, 'templates/email/evaluations/evaluation-queueing-failure-support.hbs', NULL, 'Evaluation queueing failure email to Support team'),
    (206, 'templates/email/evaluations/mass-evaluation.hbs', NULL, 'Mass evaluation results and reports'),
    (207, 'templates/email/submissions/mats/mats-submission.hbs', NULL, 'MATS file submission confirmation'),
    (208, 'templates/email/submissions/errors/submission-queueing-failure-user.hbs', NULL, 'Submission queueing failure email to Users'),
    (209, 'templates/email/submissions/errors/submission-queueing-failure-support.hbs', NULL, 'Submission queueing failure email to Support team');
