create or replace procedure camdecmpsaux.PDEM_Delete_Unit_Data
(
    in  vMonPlanId text,
    in  vRptPeriodId numeric,
    out vResult text,
    out vErrorMessage text
)

language plpgsql

as $function$

declare
begin

exception when others then
    get stacked diagnostics
    vErrorMessage := coalesce( Error_Procedure(),'DmEm.DeleteUnitData' ) + ': ' + ERROR_MESSAGE() + ' (' + cast( Error_Line() as varchar ) + ')';
	vResult := 'F';
end;

$function$;
