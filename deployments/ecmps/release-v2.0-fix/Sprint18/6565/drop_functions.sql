drop function if exists camdecmpsaux.get_em_submission_status(varchar, numeric, numeric);
drop function if exists camdecmpsaux.get_last_submission(varchar, numeric, varchar, varchar, varchar, varchar);
drop function if exists camdecmpsaux.get_last_submission(varchar, numeric, varchar);
drop function if exists camdecmpsaux.get_last_submission_access(varchar, numeric);
drop function if exists camdecmpsaux.get_last_submission_in_window(varchar, numeric, date, date);
drop procedure if exists camdecmpsaux.init_and_close_em_submission_access(in date, in numeric, inout text, inout text);

drop function if exists camdecmps.get_em_submission_status(varchar, numeric, numeric);
drop function if exists camdecmps.get_last_em_submission(varchar, numeric, date, date);
drop function if exists camdecmps.get_mp_location_list(varchar);
drop procedure if exists camdecmps.init_and_close_em_submission_access(inout text, inout text);
drop procedure if exists camdecmps.init_and_close_em_submission_access(in date, in numeric, inout text, inout text);
drop procedure if exists camdecmps.initialize_em_submission_access(IN numeric, IN numeric, INOUT text, INOUT text);