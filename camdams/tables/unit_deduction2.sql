CREATE TABLE IF NOT EXISTS camdams.unit_deduction2
(
    form_rec_date timestamp without time zone
);
COMMENT ON TABLE camdams.unit_deduction2
    IS 'Temporary table used to support the user-specified deduction process.';
COMMENT ON COLUMN camdams.unit_deduction2.form_rec_date
    IS 'Stores the common form received date for user-specified deductions.';