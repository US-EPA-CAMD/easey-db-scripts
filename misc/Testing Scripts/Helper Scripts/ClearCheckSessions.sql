select	*
  from	camdecmpswks.check_session cs 
  		left join camdecmpswks.check_log cl on cl.chk_session_id = cs.chk_session_id 
 where	cs.process_cd = 'MP'
   and	cs.mon_plan_id in ( select mp.mon_plan_id from camd.plant p join camdecmps.monitor_plan mp on mp.fac_id = p.fac_id where p.oris_code in ( 3, 10, 983, 994, 2406, 3804, 50628 ) );

--/*
delete
  from	camdecmpswks.check_log cl 
 where	cl.chk_session_id in	(
	  								select 	cs.chk_session_id 
	  								  from 	camd.plant p
	  								  		join camdecmps.monitor_plan mp on mp.fac_id = p.fac_id
	  								  		join camdecmpswks.check_session cs on cs.mon_plan_id = mp.mon_plan_id and cs.process_cd = 'MP'
	  								 where 	p.oris_code in ( 3, 10, 983, 994, 2406, 3804, 50628 ) 
  								);
delete
  from	camdecmpswks.check_session cs 
 where	cs.process_cd = 'MP'
   and	cs.mon_plan_id in	(
  								select 	mp.mon_plan_id
  								  from 	camd.plant p
  								  		join camdecmps.monitor_plan mp on mp.fac_id = p.fac_id
  								 where 	p.oris_code in ( 3, 10, 983, 994, 2406, 3804, 50628 ) 
  							);
commit;
--*/

select	*
  from	camdecmpswks.check_session cs 
  		left join camdecmpswks.check_log cl on cl.chk_session_id = cs.chk_session_id 
 where	cs.process_cd = 'MP'
   and	cs.mon_plan_id in ( select mp.mon_plan_id from camd.plant p join camdecmps.monitor_plan mp on mp.fac_id = p.fac_id where p.oris_code in ( 3, 10, 983, 994, 2406, 3804, 50628 ) );

