-- Table: camdecmpsaux.email_template

-- DROP TABLE camdecmpsaux.email_template;

CREATE TABLE IF NOT EXISTS camdecmpsaux.email_template
(
    template_id integer NOT NULL,
    template_location character varying(200) COLLATE pg_catalog."default" NOT NULL,
    template_subject text COLLATE pg_catalog."default",
    CONSTRAINT pk_email_template_id PRIMARY KEY (template_id)
);

INSERT INTO camdecmpsaux.email_template(
  template_id, template_location, template_subject
) VALUES
  (150,	'templates/submission-confirmation.html', 'Submission Completion Notification')
  (151,	'templates/submission-151.html', 'Emissions Submission Reminder'),
  (152,	'templates/submission-152.html', 'Emissions Submission Reminder'),
  (155,	'templates/submission-155.html', 'Submission Window Open for Quarterly Emission File'),
  (156,	'templates/submission-156.html', 'Outstanding Emissions Submission Reminder'),
  (157,	'templates/submission-157.html', 'Emissions Resubmission Window Closed');
