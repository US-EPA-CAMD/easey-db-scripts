INSERT INTO camdecmpsmd.train_qa_status_code (train_qa_status_cd, train_qa_status_description) VALUES ('EXPIRED', 'Required QA (calibration) was not performed on the sample flow meter component.');
INSERT INTO camdecmpsmd.train_qa_status_code (train_qa_status_cd, train_qa_status_description) VALUES ('FAILED', 'The sample flow meter is in-control, but a criterion other than relative deviation was not met.');
INSERT INTO camdecmpsmd.train_qa_status_code (train_qa_status_cd, train_qa_status_description) VALUES ('INC', 'Incomplete (missing or invalid for hour(s) in the sample collection period.');
INSERT INTO camdecmpsmd.train_qa_status_code (train_qa_status_cd, train_qa_status_description) VALUES ('LOST', 'Trap was accidentally lost, damaged, or broken and could not be analyzed.');
INSERT INTO camdecmpsmd.train_qa_status_code (train_qa_status_cd, train_qa_status_description) VALUES ('PASSED', 'All criteria passed.');
INSERT INTO camdecmpsmd.train_qa_status_code (train_qa_status_cd, train_qa_status_description) VALUES ('UNCERTAIN', 'The relative deviation criterion for the paired traps was not met, while other criteria were met.');
