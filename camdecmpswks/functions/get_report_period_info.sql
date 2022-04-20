-- FUNCTION: camdecmpswks.get_report_period_info(integer, integer, integer, character varying, character varying, date, date, character, text)

-- DROP FUNCTION camdecmpswks.get_report_period_info(integer, integer, integer, character varying, character varying, date, date, character, text);

CREATE OR REPLACE FUNCTION camdecmpswks.get_report_period_info(
	p_rptperiodid_in integer,
	INOUT p_calendaryear_in integer,
	INOUT p_quarter_in integer,
	INOUT p_perioddescription_in character varying,
	INOUT p_periodabbreviation_in character varying,
	INOUT p_begindate date,
	INOUT p_enddate date,
	INOUT p_result character,
	INOUT p_errormessage text)
    RETURNS SETOF record 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
DECLARE 
	v_rptPeriodId	int;
	errMsg text;
	errState text;
	errContext text;
	r_records record;
	

BEGIN
	
	/*
		Function Description:The purpose of thus function is to ...
		Auther:Roger Williams
		Date:2021-08-31
		Example:
				select 
					*
				from  public.GetReportPeriodInfo (
					1::int,
					1::int,
					1::int,'test'::varchar(100),
					'test_abbr12'::varchar(32),
					'2021-08-30'::date,
					'2021-08-31'::date,
					'R'::character(1),	
					're'::text	
				);	
		
		Modification: Date   Author  Comments
	*/

	
	for r_records in 
		
		SELECT prd.RPT_PERIOD_ID,
			 prd.CALENDAR_YEAR,
			 prd.QUARTER,
			 prd.PERIOD_DESCRIPTION,
			 prd.PERIOD_ABBREVIATION,
			 prd.BEGIN_DATE,
			 prd.END_DATE 
			FROM camdecmpsmd.REPORTING_PERIOD prd
			WHERE prd.RPT_PERIOD_ID = p_rptPeriodId_in 
	loop
			
			v_rptPeriodId 			:= r_records.RPT_PERIOD_ID; 
			p_calendarYear_in 		:= r_records.CALENDAR_YEAR; 
			p_quarter_in 			:= r_records.QUARTER;  
			p_periodDescription_in 	:= r_records.PERIOD_DESCRIPTION;  
			p_periodAbbreviation_in := r_records.PERIOD_ABBREVIATION;  
			p_beginDate 			:= r_records.BEGIN_DATE;  
			p_endDate 				:= r_records.END_DATE; 
			
			IF (v_rptPeriodId = p_rptPeriodId_in)
				THEN
					p_errorMessage := NULL;
					p_result := 'Y';
			ELSE
					p_errorMessage := 'Unrecognized Report Period Id (' || CAST(p_rptPeriodId_in as varchar(1)) || ')';
					p_result := 'N';
			
			END IF;
			
			RETURN NEXT;
	
	END LOOP;

		

	EXCEPTION
		WHEN OTHERS THEN
		 GET STACKED DIAGNOSTICS
			errState = RETURNED_SQLSTATE,
			errMsg   = MESSAGE_TEXT,
			errContext = PG_EXCEPTION_CONTEXT;
			p_errorMessage := 'SQL State: '|| errState || ';Message ' || errMsg || '; Context '|| errContext;
			p_result := 'N';

END;
$BODY$;
