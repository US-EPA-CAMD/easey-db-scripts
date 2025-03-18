create or replace function camdecmpsaux.PDEM_Job_Get_Next
(
    vJobLimit   smallint
)
    returns table
            (
                -- Need prefix to avoid ambiguous error with unaliased update columns below.
                Next_Pdem_Report_Id bigint,
                Next_Mon_Plan_Id varchar,
                Next_Rpt_Period_Id numeric
            )

language plpgsql

as $function$

declare
begin
    
    return query
        with    UPDATED as
                (
                    update  camdecmpsaux.PDEM_Report
                       set  triggered_time = current_timestamp
                     where  Pdem_Report_Id in
                            (
                                select  rpt.Pdem_Report_Id
                                  from  camdecmpsaux.PDEM_Report rpt
                                 where  rpt.triggered_time is null
                                   and  not exists
                                        (
                                            select  1
                                              from  camdecmpsaux.PDEM_Report exs
                                             where  exs.triggered_time is not null
                                               and  exs.completed_time is null
                                               and  exs.note_time is null
                                            having  ( count( 1 ) >= vJobLimit )
                                        )
                                 order
                                    by  rpt.queued_Time
                                 limit  1
                                 for    update skip locked
                            )
                    returning   Pdem_Report_Id,
                                Mon_Plan_Id,
                                Rpt_Period_Id
                )
        select  upd.Pdem_Report_Id,
                upd.Mon_Plan_Id,
                upd.Rpt_Period_Id
          from  UPDATED upd;

end;

$function$;
