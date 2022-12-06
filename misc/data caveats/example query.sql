select p.state, p.facility_name, p.oris_code as facility_id, null as prev_facility_id, null as unit_id, null as prev_unit_id, 'Facility name change from ' || pa.old_value || ' on ' || pa.alias_date
from camd.plant_alias pa
join camd.plant p on pa.fac_id = p.fac_id
where pa.alias_type = 'NAME'
union
select p.state, p.facility_name, p.oris_code as facility_id, pa.old_value as prev_facility_id, null as unit_id, null as prev_unit_id, 'Facility ID (ORIS Code) change from ' || pa.old_value || ' to ' || p.oris_code || ' on ' || pa.alias_date
from camd.plant_alias pa
join camd.plant p on pa.fac_id = p.fac_id
where pa.alias_type = 'ORIS'
union
select p.state, p.facility_name, p.oris_code as facility_id, null as prev_facility_id, u.unitid as unit_id, ua.old_unitid as prev_unit_id, 'Unit ID change from ' || ua.old_unitid || ' to ' || u.unitid || ' on ' || ua.alias_date
from camd.unit_alias ua
join camd.unit u on ua.unit_id = u.unit_id
join camd.plant p on u.fac_id = p.fac_id
order by state, facility_name;