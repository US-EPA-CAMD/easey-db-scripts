-- FUNCTION: camdaux.get_current_submission_quarter()

DROP FUNCTION IF EXISTS camdaux.get_current_submission_quarter();

CREATE OR REPLACE FUNCTION camdaux.get_current_submission_quarter(
	)
    RETURNS integer
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
Declare 
	curMonth INTEGER;
	curDay INTEGER;
	curYear INTEGER;
BEGIN
	curYear := date_part('year'::text, timezone('est'::text, CURRENT_TIMESTAMP));
	curMonth := date_part('month'::text, timezone('est'::text, CURRENT_TIMESTAMP));
	curDay := date_part('day'::text, timezone('est'::text, CURRENT_TIMESTAMP));
	
		IF curDay = 1 OR (curDay = 2 AND extract(dow from make_date(curYear, curMonth, 1)) = 0) THEN
			IF curMonth = 5 THEN
				IF extract(dow from make_date(curYear, 4, 30)) IN (0, 6) THEN
					return 1;
				END IF;
			ELSEIF curMonth = 8 THEN
				IF extract(dow from make_date(curYear, 7, 31)) IN (0, 6) THEN
					return 2;
				END IF;
			ELSEIF curMonth = 11 THEN
				IF extract(dow from make_date(curYear, 10, 31)) IN (0, 6) THEN
					return 3;
				END IF;
			ELSEIF curMonth = 2 THEN
				IF extract(dow from make_date(curYear, 1, 31)) IN (0, 6) THEN
					return 4;
				END IF;
			END IF;
		END IF;
	
	If curMonth >= 2 AND curMonth <= 4  Then
		return 1;
	ElseIf curMonth >= 5 AND curMonth <= 7 Then
		return 2;
	ElseIF curMonth >=8 AND curMonth <=10 Then
		return 3;
	Else
		return 4;
	End If;

return curMonth;
END;
$BODY$;
