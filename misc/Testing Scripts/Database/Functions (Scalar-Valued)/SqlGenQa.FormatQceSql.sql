USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[FormatQceSql]    Script Date: 11/23/2022 12:33:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE or ALTER FUNCTION SqlGenQa.FormatQceSql
(	
	@OrisCode               integer,
    @FacilityName           varchar(40),
    @LocationName           varchar(6),
    @QaCertEventCd          varchar(7),
    @QaCertEventDate        date,
    @QaCertEventHour        integer,
    @SystemIdentifier       varchar(3),
    @SystemTypeCd           varchar(7),
    @ComponentIdentifier    varchar(3),
    @ComponentTypeCd        varchar(7),
    @SqlOrder               integer,
    @SqlStatement           varchar(max)
)
RETURNS [varchar](max)
AS
begin
	
	declare @QaCertEventDateTime  datetime = @QaCertEventDate
    
    declare @system varchar(13)

    if ( @SystemIdentifier is not null ) and ( @SystemTypeCd is not null )
        select @system = ltrim( rtrim( concat( @SystemIdentifier, ' (', @SystemTypeCd, ')' ) ) )
    else if ( @SystemIdentifier is not null )
        select @system = ltrim( rtrim( @SystemIdentifier ) )
    else if ( @SystemTypeCd is not null )
        select @system = ltrim( rtrim( concat( '(', @SystemTypeCd, ')' ) ) )
    else
        select @system = null

	
	declare @component varchar(13)

    if ( @ComponentIdentifier is not null ) and ( @ComponentTypeCd is not null )
        select @component = ltrim( rtrim( concat( @ComponentIdentifier, ' (', @ComponentTypeCd, ')' ) ) )
    else if ( @ComponentIdentifier is not null )
        select @component = ltrim( rtrim( @ComponentIdentifier ) )
    else if ( @ComponentTypeCd is not null )
        select @component = ltrim( rtrim( concat( '(', @ComponentTypeCd, ')' ) ) )
    else
        select @component = null

    
    declare @result varchar(max)


    select @result = concat
                     ( 
                        '/* ', 
                        'ORIS: ', right( concat('      ', @OrisCode), 6 ), 
                        '    ',
                        'Location: ', left( concat(@LocationName, '      '), 6 ),
                        '    ',
                        'Event: ', left( concat(@QaCertEventCd, '       '), 7 ),
                        '    ',
                        'Hour: ', left( concat(Format( DateAdd(hour, @QaCertEventHour, @QaCertEventDateTime), 'yyyy-MM-dd HH' ), '             '), 13 ),
                        '    ',
                        'System: ', left( concat(@system, '             '), 13 ),
                        '    ',
                        'Component: ', left( concat(@component, '             '), 13 ),
                        '    ',
                        'SQL Ord: ', right( concat('    ', @SqlOrder), 4 ),
                        ' */ ',
                        @SqlStatement
                     )
    
	return @result
end
GO


