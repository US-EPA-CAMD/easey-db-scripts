--NOTE: RUN span_master_data_relationships_load.sql FIRST

----Component type Code for COMPONENT
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type to Category'), 'BGFF', 'COMPONENT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type to Category'), 'BOFF', 'COMPONENT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type to Category'), 'CALR', 'COMPONENT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type to Category'), 'CO2', 'COMPONENT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type to Category'), 'DAHS', 'COMPONENT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type to Category'), 'DL', 'COMPONENT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type to Category'), 'DP', 'COMPONENT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type to Category'), 'FLC', 'COMPONENT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type to Category'), 'FLOW', 'COMPONENT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type to Category'), 'GCH', 'COMPONENT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type to Category'), 'GFFM', 'COMPONENT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type to Category'), 'H2O', 'COMPONENT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type to Category'), 'HCL', 'COMPONENT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type to Category'), 'HF', 'COMPONENT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type to Category'), 'HG', 'COMPONENT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type to Category'), 'MS', 'COMPONENT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type to Category'), 'NOX', 'COMPONENT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type to Category'), 'O2', 'COMPONENT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type to Category'), 'OFFM', 'COMPONENT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type to Category'), 'OP', 'COMPONENT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type to Category'), 'PLC', 'COMPONENT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type to Category'), 'PRB', 'COMPONENT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type to Category'), 'PRES', 'COMPONENT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type to Category'), 'SO2', 'COMPONENT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type to Category'), 'STRAIN', 'COMPONENT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type to Category'), 'TANK', 'COMPONENT', null);
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3) VALUES ((select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type to Category'), 'TEMP', 'COMPONENT', null);

--COMPONENT AND Basis Code TO Sample AQUISITION METHOD CODE (for CONC)
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3)
	select	cross_chk_catalog_id
			, 'HG'
			, value2
			, value3 
	from camdecmpsmd.vw_cross_check_catalog_value 
	where cross_chk_catalog_name='Component Type and Basis to Sample Acquisition Method'
		  and value1='CONC';

INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3)
	select	cross_chk_catalog_id
			, 'SO2'
			, value2
			, value3 
	from camdecmpsmd.vw_cross_check_catalog_value 
	where cross_chk_catalog_name='Component Type and Basis to Sample Acquisition Method'
		  and value1='CONC';
		  
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3)
	select	cross_chk_catalog_id
			, 'NOX'
			, value2
			, value3 
	from camdecmpsmd.vw_cross_check_catalog_value 
	where cross_chk_catalog_name='Component Type and Basis to Sample Acquisition Method'
		  and value1='CONC';		  
		  
		  
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3)
	select	cross_chk_catalog_id
			, 'CO2'
			, value2
			, value3 
	from camdecmpsmd.vw_cross_check_catalog_value 
	where cross_chk_catalog_name='Component Type and Basis to Sample Acquisition Method'
		  and value1='CONC';		  
		  
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3)
	select	cross_chk_catalog_id
			, 'O2'
			, value2
			, value3 
	from camdecmpsmd.vw_cross_check_catalog_value 
	where cross_chk_catalog_name='Component Type and Basis to Sample Acquisition Method'
		  and value1='CONC';		  


INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3)
	select	cross_chk_catalog_id
			, 'PRB'
			, value2
			, value3 
	from camdecmpsmd.vw_cross_check_catalog_value 
	where cross_chk_catalog_name='Component Type and Basis to Sample Acquisition Method'
		  and value1='CONC';

INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3)
	select	cross_chk_catalog_id
			, 'HCL'
			, value2
			, value3 
	from camdecmpsmd.vw_cross_check_catalog_value 
	where cross_chk_catalog_name='Component Type and Basis to Sample Acquisition Method'
		  and value1='CONC';
		  
		
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3)
	select	cross_chk_catalog_id
			, 'HF'
			, value2
			, value3 
	from camdecmpsmd.vw_cross_check_catalog_value 
	where cross_chk_catalog_name='Component Type and Basis to Sample Acquisition Method'
		  and value1='CONC';
		  
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3)
	select	cross_chk_catalog_id
			, 'PM'
			, value2
			, value3 
	from camdecmpsmd.vw_cross_check_catalog_value 
	where cross_chk_catalog_name='Component Type and Basis to Sample Acquisition Method'
		  and value1='CONC';
		  
--COMPONENT AND Basis Code TO Sample AQUISITION METHOD CODE (for CONC)
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3)
	select	cross_chk_catalog_id
			, 'BGFF'
			, value2
			, value3 
	from camdecmpsmd.vw_cross_check_catalog_value 
	where cross_chk_catalog_name='Component Type and Basis to Sample Acquisition Method'
		  and value1='FUELFLOW';
		  
INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3)
	select	cross_chk_catalog_id
			, 'BOFF'
			, value2
			, value3 
	from camdecmpsmd.vw_cross_check_catalog_value 
	where cross_chk_catalog_name='Component Type and Basis to Sample Acquisition Method'
		  and value1='FUELFLOW';

INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3)
	select	cross_chk_catalog_id
			, 'GFFM'
			, value2
			, value3 
	from camdecmpsmd.vw_cross_check_catalog_value 
	where cross_chk_catalog_name='Component Type and Basis to Sample Acquisition Method'
		  and value1='FUELFLOW';

INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3)
	select	cross_chk_catalog_id
			, 'OFFM'
			, value2
			, value3 
	from camdecmpsmd.vw_cross_check_catalog_value 
	where cross_chk_catalog_name='Component Type and Basis to Sample Acquisition Method'
		  and value1='FUELFLOW';

INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3)
	select	cross_chk_catalog_id
			, 'DP'
			, value2
			, value3 
	from camdecmpsmd.vw_cross_check_catalog_value 
	where cross_chk_catalog_name='Component Type and Basis to Sample Acquisition Method'
		  and value1='FUELFLOW';

INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3)
	select	cross_chk_catalog_id
			, 'TEMP'
			, value2
			, value3 
	from camdecmpsmd.vw_cross_check_catalog_value 
	where cross_chk_catalog_name='Component Type and Basis to Sample Acquisition Method'
		  and value1='FUELFLOW';

INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3)
	select	cross_chk_catalog_id
			, 'PRES'
			, value2
			, value3 
	from camdecmpsmd.vw_cross_check_catalog_value 
	where cross_chk_catalog_name='Component Type and Basis to Sample Acquisition Method'
		  and value1='FUELFLOW';

INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3)
	select	cross_chk_catalog_id
			, 'FLC'
			, value2
			, value3 
	from camdecmpsmd.vw_cross_check_catalog_value 
	where cross_chk_catalog_name='Component Type and Basis to Sample Acquisition Method'
		  and value1='FUELFLOW';

INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3)
	select	cross_chk_catalog_id
			, 'GCH'
			, value2
			, value3 
	from camdecmpsmd.vw_cross_check_catalog_value 
	where cross_chk_catalog_name='Component Type and Basis to Sample Acquisition Method'
		  and value1='FUELFLOW';

INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3)
	select	cross_chk_catalog_id
			, 'MS'
			, value2
			, value3 
	from camdecmpsmd.vw_cross_check_catalog_value 
	where cross_chk_catalog_name='Component Type and Basis to Sample Acquisition Method'
		  and value1='FUELFLOW';

INSERT INTO camdecmpsmd.cross_check_catalog_value(cross_chk_catalog_id, value1, value2, value3)
	select	cross_chk_catalog_id
			, 'CALR'
			, value2
			, value3 
	from camdecmpsmd.vw_cross_check_catalog_value 
	where cross_chk_catalog_name='Component Type and Basis to Sample Acquisition Method'
		  and value1='FUELFLOW';


/* NO LONGER NEEDED - MATCHING EXISTING CHECK ENGINE CHECK LOGIC
--Make all SAM code for FLOW records W
select * from camdecmpsmd.cross_check_catalog_value where cross_chk_catalog_id = (select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type and Basis to Sample Acquisition Method')
			and value1='FLOW';

update camdecmpsmd.cross_check_catalog_value
set value2='W'
where cross_chk_catalog_id = (select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type and Basis to Sample Acquisition Method')
			and value1='FLOW';

--Make IS, ISP, ISC, DIN, DOU, DIL, and WXT SAM Codes records W
select * from camdecmpsmd.cross_check_catalog_value where cross_chk_catalog_id = (select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type and Basis to Sample Acquisition Method')
			and value3 in ('IS', 'ISP', 'ISC', 'DIN', 'DOU', 'DIL', 'WXT')
			and value2 is NULL;
			
update camdecmpsmd.cross_check_catalog_value
set value2='W'
where cross_chk_catalog_id = (select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type and Basis to Sample Acquisition Method')
			and value3 in ('IS', 'ISP', 'ISC', 'DIN', 'DOU', 'DIL', 'WXT')
			and value2 is NULL;
			
--Make EXT Sam code record D
select * from camdecmpsmd.cross_check_catalog_value where cross_chk_catalog_id = (select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type and Basis to Sample Acquisition Method')
			and value3 in ('EXT')
			--and value2 is NULL
			and value2 in ('W','B');

update camdecmpsmd.cross_check_catalog_value
set value2='D'
where cross_chk_catalog_id = (select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type and Basis to Sample Acquisition Method')
			and value3 in ('EXT')
			and value2 is NULL;

DELETE from camdecmpsmd.cross_check_catalog_value
where cross_chk_catalog_id = (select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type and Basis to Sample Acquisition Method')
			and value3 in ('EXT')
			and value2 in ('W','B');

-- SET O records to null basis codem except for FLOW SAM code
select * from camdecmpsmd.cross_check_catalog_value where cross_chk_catalog_id = (select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type and Basis to Sample Acquisition Method')
			and value3 in ('O')
			and value2 is NOT NULL
			and value1 <> ('FLOW');

update camdecmpsmd.cross_check_catalog_value
set value2=null
where cross_chk_catalog_id = (select cross_chk_catalog_id from camdecmpsmd.cross_check_catalog where cross_chk_catalog_name='Component Type and Basis to Sample Acquisition Method')
			and value3 in ('O')
			and value2 is NOT NULL
			and value1 <> ('FLOW');
*/

/*
--DATA VALIDATION SCRIPTS
select * from camdecmpsmd.vw_cross_check_catalog_value where cross_chk_catalog_name='Component Type to Category' and value2='COMPONENT'; --27 rows
select distinct * from camdecmpsmd.vw_cross_check_catalog_value where cross_chk_catalog_name='Component Type and Basis to Sample Acquisition Method' order by value1; --285 rows
select * from camdecmpsmd.vw_systemcomponent_master_data_relationships; --249 rows
*/