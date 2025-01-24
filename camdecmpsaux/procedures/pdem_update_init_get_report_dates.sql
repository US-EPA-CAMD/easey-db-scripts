create or replace procedure camdecmpsaux.PDEM_Update_Init_Get_Report_Dates
(
    in vMonPlanId varchar,
    in vRptPeriodId numeric,
    out vRptBegin date,
    out vRptEnd date
)

language plpgsql

as $procedure$

declare
    
begin

	select  case
				when ( mth.Method_Begin_Date_Min is not null ) and ( mth.Method_Begin_Date_Min > prd.Period_Begin_Date )
				then mth.Method_Begin_Date_Min
				else prd.Period_Begin_Date
			end Report_Begin_Date,
			case
				when ( mth.Method_End_Date_Max is not null ) and ( mth.Method_End_Date_Max <> prd.Period_End_Date )
				then mth.Method_End_Date_Max
				else prd.Period_End_Date
			end Report_End_Date
	  into  vRptBegin,
            vRptEnd
	  from	(
				select  prd.Begin_Date as Period_Begin_Date,
						prd.End_Date as Period_End_Date
				  from  camdecmpsmd.REPORTING_PERIOD prd
				 where  prd.Rpt_Period_Id = vRptPeriodId
	 		) prd,
	 		(
	 			select  min( mth.Begin_Date ) as Method_Begin_Date_Min,
	 					case when max( case when mth.End_Date is null then 1 else 0 end ) = 1 then null else max( mth.End_Date ) end Method_End_Date_Max
	 			  from  camdecmps.MONITOR_PLAN_LOCATION mpl
	 			  		join camdecmps.MONITOR_METHOD mth
	 			  		  on mth.Mon_Loc_Id = mpl.Mon_Loc_Id
	 			 where	mpl.Mon_Plan_Id = vMonPlanId
	 		) mth;
    
end;

$procedure$;
