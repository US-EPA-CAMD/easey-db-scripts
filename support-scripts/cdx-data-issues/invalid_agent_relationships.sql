select inv.rep_id, inv.agent_id, listagg(distinct inv.relation_type_cd, ', ') within group (order by inv.relation_type_cd) as agent_types, 
inv.fac_id, inv.oris_code, inv.facility_name, 
inv.account_id, inv.account_number, inv.account_name,
inv.agent_cdx_user_id,
pa_r.first_name as rep_first_name, pa_r.last_name as rep_last_name, pa_a.first_name as agent_first_name, pa_a.last_name as agent_last_name 
from ((select ra.rep_id, ra.agent_id, ra.relation_type_cd, 
        rap.fac_id, pl.oris_code, pl.facility_name, 
        null as account_id, null as account_number, null as account_name, 
        cu_r.cdx_user_id as rep_cdx_user_id, cu_a.cdx_user_id as agent_cdx_user_id, --var.cdx_Org_id, 
        ra.cnt_rel_id, rap.rep_agent_plant_id, null as rep_agent_account_id
from rep_agent ra
inner join rep_agent_plant rap on ra.cnt_rel_Id = rap.cnt_rel_id
inner join plant pl on rap.fac_id = pl.fac_id
left outer join cdx_user cu_r on ra.rep_id = cu_r.ppl_Id
left outer join cdx_user cu_a on ra.agent_id = cu_a.ppl_Id
union all
select ra.rep_id, ra.agent_id, ra.relation_type_cd, 
        null as fac_id, null as oris_code, null as facility_name, 
        rac.account_id, acc.account_number, acc.account_name, 
        cu_r.cdx_user_id as rep_cdx_user_id, cu_a.cdx_user_id as agent_cdx_user_id, --var.cdx_Org_id, 
        ra.cnt_rel_id, null as rep_agent_plant_id, rac.rep_Agent_account_id
from rep_agent ra
inner join rep_agent_account rac on ra.cnt_rel_Id = rac.cnt_rel_id
inner join  account acc on rac.account_id = acc.account_id
left outer join cdx_user cu_r on ra.rep_id = cu_r.ppl_Id
left outer join cdx_user cu_a on ra.agent_id = cu_a.ppl_Id)
minus
select var.rep_id, var.agent_id, var.relation_type_cd, 
        var.fac_id, pl.oris_code, pl.facility_name, 
        var.account_id, acc.account_number, acc.account_name, 
        var.rep_cdx_user_id, var.agent_cdx_user_id, --var.cdx_Org_id, 
        var.cnt_rel_id, var.rep_agent_plant_id, var.rep_Agent_account_id
from vw_valid_agent_relationships var
left outer join plant pl on var.fac_id = pl.fac_id
left outer join account acc on var.account_id = acc.account_id
order by agent_cdx_user_id) inv
inner join rep_agent ra2 on inv.cnt_rel_id = ra2.cnt_rel_id
inner join person_a pa_r on ra2.rep_id = pa_r.ppl_id
inner join person_a pa_a on ra2.agent_id = pa_a.ppl_id
where 
rep_cdx_user_Id is null and agent_cdx_user_id is not null
group by inv.rep_id, inv.agent_id, 
inv.fac_id, inv.oris_code, inv.facility_name, 
inv.account_id, inv.account_number, inv.account_name,
inv.agent_cdx_user_id, 
pa_r.first_name, pa_r.last_name, pa_a.first_name, pa_a.last_name
order by facility_name;