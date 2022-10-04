USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[SqlLabel]    Script Date: 9/6/2022 1:23:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE or ALTER FUNCTION [SqlGenQa].[FormatSql]
(	
	@OrisCode       integer,
    @FacilityName   varchar(40),
    @LocationName   varchar(6),
    @TestTypeCd     varchar(7),
    @TestNumber     varchar(18),
    @SqlOrder       integer,
    @SqlStatement   varchar(max)
)
RETURNS [varchar](max)
AS
begin
	
	declare @result varchar(max)


    select @result = concat
                     ( 
                        '/* ', 
                        'ORIS: ', right( concat('      ', @OrisCode), 6 ), 
                        '    ',
                        'Location: ', left( concat(@LocationName, '      '), 6 ),
                        '    ',
                        'Test Type: ', left( concat(@TestTypeCd, '       '), 7 ),
                        '    ',
                        'Test Num: ', left( concat(@TestNumber, '       '), 18 ),
                        '    ',
                        'SQL Ord: ', right( concat('    ', @SqlOrder), 4 ),
                        ' */ ',
                        @SqlStatement
                     )
    
	return @result
end
GO


