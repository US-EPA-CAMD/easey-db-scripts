USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenEm].[FormatSql]    Script Date: 2/7/2023 3:24:44 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER FUNCTION SqlGenEm.FormatSql
(	
	@OrisCode       integer,
    @FacilityName   varchar(40),
	@Locations      varchar(max),
	@Quarter        varchar(7),
    @LocationName   varchar(6),
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
                        'Locations: ', left( concat(@Locations, '       '), 7 ),
                        '    ',
                        'Quarter: ', left( concat(@Quarter, '       '), 18 ),
                        '    ',
                        'Location: ', left( concat(@LocationName, '      '), 6 ),
                        '    ',
                        'SQL Ord: ', right( concat('    ', @SqlOrder), 4 ),
                        ' */ ',
                        @SqlStatement
                     )
    
	return @result
end
GO


