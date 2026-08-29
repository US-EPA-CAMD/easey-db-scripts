/*
#6922 - Cleanup Supplemental Data where delete_ind = 1
Schema   : camdecmps (+ related supplemental tables)
Notes    : Deletes children first, then parents. Atomic via transaction.
*/

BEGIN;

-- Child first: daily_test_system_supp_data rows that reference daily_test_supp_data to be deleted
DELETE FROM camdecmps.daily_test_system_supp_data
WHERE daily_test_supp_data_id IN (
  SELECT daily_test_supp_data_id
  FROM camdecmps.daily_test_supp_data
  WHERE delete_ind = 1
);

-- Parents / standalones
DELETE FROM camdecmps.component_op_supp_data   WHERE delete_ind = 1;
DELETE FROM camdecmps.daily_test_supp_data     WHERE delete_ind = 1;
DELETE FROM camdecmps.last_qa_value_supp_data  WHERE delete_ind = 1;
DELETE FROM camdecmps.qa_cert_event_supp_data  WHERE delete_ind = 1;
DELETE FROM camdecmps.system_op_supp_data      WHERE delete_ind = 1;

COMMIT;

