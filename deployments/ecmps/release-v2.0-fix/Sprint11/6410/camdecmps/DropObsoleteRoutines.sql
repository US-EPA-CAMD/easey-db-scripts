
drop function camdecmps.get_derived_hourly_values_pivoted(varchar, numeric, _text);
drop function camdecmps.get_hourly_param_fuel_flow_pivoted(varchar, numeric, _text);
drop function camdecmps.get_monitor_hourly_values_pivoted(varchar, numeric, _text, _text, _text);
drop function camdecmps.get_monitor_hourly_values_pivoted(text, numeric, _text);

drop procedure camdecmps.load_temp_hour_rules(varchar, numeric);
    
drop procedure camdecmps.load_temp_daily_test_errors(varchar, numeric);
drop procedure camdecmps.load_temp_hourly_test_errors(varchar, numeric);
drop procedure camdecmps.load_temp_weekly_test_errors(varchar, numeric);
