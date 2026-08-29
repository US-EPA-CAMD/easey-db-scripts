-- FUNCTION: camdecmpswks.rpt_mp_unit_control(character varying)

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_mp_unit_control
(
	monplanid character varying
)
RETURNS TABLE
(
    "unitIdentifier" text,
    "parameterCode" text,
    "parameterCodeGroup" text,
    "parameterCodeDescription" text,
    "controlEquipmentCode" text,
    "controlEquipmentCodeGroup" text,
    "controlEquipmentCodeDescription" text,
    "originalEquipment" text,
    "ozoneSeasonControl" text,
    "installDate" text,
    "optimizationDate" text,
    "retireDate" text,
    "status" text
) 
LANGUAGE 'sql'

    COST 100
    VOLATILE 
    ROWS 1000

AS $BODY$

    select  unt.unitid as "unitIdentifier",
            unc.ce_param as "parameterCode",
            'Parameter Codes' AS "parameterCodeGroup",		
            cep.control_equip_param_desc AS "parameterCodeDescription",
            unc.control_cd as "controlEquipmentCode",
            'Equipment Codes' as "controlEquipmentCodeGroup",
            ccd.control_description as "controlEquipmentCodeDescription",
            case 
                when unc.orig_cd = '1' then 'Yes'
                when unc.orig_cd = '0' then  'No'
            end as "originalEquipment",
            case 
                when unc.seas_cd = '1' then 'Yes'
                when unc.seas_cd = '0' then 'No'
                else unc.seas_cd
            end as "ozoneSeasonControl",
            to_char( unc.install_date, 'MM/DD/YYYY' ) as "installDate",
            to_char( unc.opt_date, 'MM/DD/YYYY' ) as  "optimizationDate",
            to_char( unc.retire_date, 'MM/DD/YYYY' ) as "retireDate",
            case when unc.retire_date is null then 'Active' else 'Inactive' end as "status"
      from  camdecmpswks.MONITOR_PLAN_LOCATION mpl
            join camdecmpswks.MONITOR_LOCATION loc using ( mon_loc_id )
            join camdecmpswks.UNIT_CONTROL unc using ( unit_id )
            join camdecmpswks.UNIT unt using ( unit_id )
            join camdecmpsmd.CONTROL_CODE ccd using ( control_cd )
            join camdecmpsmd.CONTROL_EQUIP_PARAM_CODE cep on cep.control_equip_param_cd = unc.ce_param
     where  mpl.mon_plan_id = monplanid
     order
        by  unt.unitid, 
            unc.ce_param, 
            unc.install_date;

$BODY$;
