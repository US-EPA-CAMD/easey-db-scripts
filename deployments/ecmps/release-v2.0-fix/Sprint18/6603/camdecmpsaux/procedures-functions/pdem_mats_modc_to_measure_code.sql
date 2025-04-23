create or replace function camdecmpsaux.PDEM_Mats_Modc_To_Measure_Code
(
    in vModcCd varchar
)
    returns varchar

language plpgsql

as $function$

declare
    vResult varchar;
begin

    if ( vModcCd = '36' ) then
        vResult := 'MEASURE';
    elsif ( vModcCd = '38' ) then
        vResult := 'UNAVAIL';
    elsif ( vModcCd in ( '37', '39' ) ) then
        vResult := 'UPDOWN';
    else
        vResult := null;
    end if;
    
    return vResult;
    
end;

$function$;
