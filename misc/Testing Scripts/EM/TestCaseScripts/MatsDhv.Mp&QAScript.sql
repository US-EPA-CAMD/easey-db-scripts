-- ORIS 628, Locations 4 for 2021 Q3
CALL camdecmpswks.revert_to_official_record('MDC-EF58D953BC3C47499A065DD0696650E1');

insert
  into  camdecmpswks.monitor_formula
        ( mon_form_id, mon_loc_id, parameter_cd, equation_cd, formula_identifier, begin_date, begin_hour, end_date, end_hour, formula_equation, userid, add_date, update_date )
select  'CHV-SABER-6CF1C32640D74666AA5779941FDF8275' as mon_form_id, mon_loc_id, parameter_cd, '19-7' as equation_cd, 'AAA' as formula_identifier, begin_date, begin_hour, end_date, end_hour, formula_equation, userid, add_date, update_date
  from  camdecmpswks.monitor_formula frm
 where  frm.mon_form_id = 'PEL-L3G357-A5A6C8DA53AF4B6B9FB813B21B331F0D';

insert
  into  camdecmpswks.monitor_formula
        ( mon_form_id, mon_loc_id, parameter_cd, equation_cd, formula_identifier, begin_date, begin_hour, end_date, end_hour, formula_equation, userid, add_date, update_date )
select  'CHV-SABER-A6F25A876FF347F4872AD4000BBA4B9F' as mon_form_id, mon_loc_id, parameter_cd, 'A-2' as equation_cd, 'BBB' as formula_identifier, begin_date, begin_hour, end_date, end_hour, formula_equation, userid, add_date, update_date
  from  camdecmpswks.monitor_formula frm
 where  frm.mon_form_id = 'PEL-L3G357-06FEB54D8C724657996E2ACBEE85C0F5';

commit;
