ALTER TABLE IF EXISTS camdaux.qrtz_job_details
    PRIMARY KEY (sched_name,job_name,job_group);

ALTER TABLE IF EXISTS camdaux.qrtz_triggers
    PRIMARY KEY (sched_name,trigger_name,trigger_group),
    FOREIGN KEY (sched_name,job_name,job_group) 
		REFERENCES camdaux.qrtz_job_details(sched_name,job_name,job_group);

ALTER TABLE IF EXISTS camdaux.qrtz_simple_triggers
    PRIMARY KEY (sched_name,trigger_name,trigger_group),
    FOREIGN KEY (sched_name,trigger_name,trigger_group) 
		REFERENCES camdaux.qrtz_triggers(sched_name,trigger_name,trigger_group) ON DELETE CASCADE;

ALTER TABLE IF EXISTS camdaux.qrtz_simprop_triggers 
	  PRIMARY KEY (sched_name,trigger_name,trigger_group),
    FOREIGN KEY (sched_name,trigger_name,trigger_group) 
		REFERENCES camdaux.qrtz_triggers(sched_name,trigger_name,trigger_group) ON DELETE CASCADE;

ALTER TABLE IF EXISTS camdaux.qrtz_cron_triggers
    PRIMARY KEY (sched_name,trigger_name,trigger_group),
    FOREIGN KEY (sched_name,trigger_name,trigger_group) 
		REFERENCES camdaux.qrtz_triggers(sched_name,trigger_name,trigger_group) ON DELETE CASCADE;

ALTER TABLE IF EXISTS camdaux.qrtz_blob_triggers
    PRIMARY KEY (sched_name,trigger_name,trigger_group),
    FOREIGN KEY (sched_name,trigger_name,trigger_group) 
		REFERENCES camdaux.qrtz_triggers(sched_name,trigger_name,trigger_group) ON DELETE CASCADE;

ALTER TABLE IF EXISTS camdaux.qrtz_calendars
    PRIMARY KEY (sched_name,calendar_name);

ALTER TABLE IF EXISTS camdaux.qrtz_paused_trigger_grps
    PRIMARY KEY (sched_name,trigger_group);

ALTER TABLE IF EXISTS camdaux.qrtz_fired_triggers 
    PRIMARY KEY (sched_name,entry_id);

ALTER TABLE IF EXISTS camdaux.qrtz_scheduler_state 
    PRIMARY KEY (sched_name,instance_name);

ALTER TABLE IF EXISTS camdaux.qrtz_locks
    PRIMARY KEY (sched_name,lock_name);

create index if not exists idx_qrtz_j_req_recovery on camdaux.qrtz_job_details(requests_recovery);
create index if not exists idx_qrtz_t_next_fire_time on camdaux.qrtz_triggers(next_fire_time);
create index if not exists idx_qrtz_t_state on camdaux.qrtz_triggers(trigger_state);
create index if not exists idx_qrtz_t_nft_st on camdaux.qrtz_triggers(next_fire_time,trigger_state);
create index if not exists idx_qrtz_ft_trig_name on camdaux.qrtz_fired_triggers(trigger_name);
create index if not exists idx_qrtz_ft_trig_group on camdaux.qrtz_fired_triggers(trigger_group);
create index if not exists idx_qrtz_ft_trig_nm_gp on camdaux.qrtz_fired_triggers(sched_name,trigger_name,trigger_group);
create index if not exists idx_qrtz_ft_trig_inst_name on camdaux.qrtz_fired_triggers(instance_name);
create index if not exists idx_qrtz_ft_job_name on camdaux.qrtz_fired_triggers(job_name);
create index if not exists idx_qrtz_ft_job_group on camdaux.qrtz_fired_triggers(job_group);
create index if not exists idx_qrtz_ft_job_req_recovery on camdaux.qrtz_fired_triggers(requests_recovery);
