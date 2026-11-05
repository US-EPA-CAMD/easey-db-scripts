create or replace function camdaux.cast_date_or_null
(
    dateString varchar
)
    returns date
as
$function$
begin

    return dateString::date;
  
exception when others then
    return null;
end;
$function$
language plpgsql;