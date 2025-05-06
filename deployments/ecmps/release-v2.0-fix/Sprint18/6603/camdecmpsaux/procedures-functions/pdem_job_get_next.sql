create or replace function camdecmpsaux.PDEM_Job_Get_Next
(
    vJobLimit   integer
)
    returns table
            (
                -- Need prefix to avoid ambiguous error with unaliased update columns below.
                Pdem_Report_Id bigint,
                Mon_Plan_Id varchar,
                Rpt_Period_Id numeric,
                Submission_Id bigint
            )

language plpgsql

as $function$

declare
begin
    
    return query
        select  Next_Pdem_Report_Id,
                Next_Mon_Plan_Id,
                Next_Rpt_Period_Id,
                Next_Submission_Id
          from  camdecmpsaux.PDEM_Job_Get_Next_Core( vJobLimit );

end;

$function$;
