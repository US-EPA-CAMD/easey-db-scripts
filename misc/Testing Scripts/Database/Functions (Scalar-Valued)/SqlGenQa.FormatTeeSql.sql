USE [EASEY-IN]
GO

/****** Object:  UserDefinedFunction [SqlGenQa].[FormatTeeSql]    Script Date: 11/28/2022 10:42:13 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE or ALTER FUNCTION SqlGenQa.FormatTeeSql
(	
	@OrisCode               integer,
    @FacilityName           varchar(40),
    @LocationName           varchar(6),
    @Quarter                varchar(32),
    @ExtensExemptCd         varchar(7),
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
                        'Quarter: ', left( concat(@Quarter, '       '), 32 ),
                        '    ',
                        'Code: ', left( concat(@ExtensExemptCd, '       '), 7 ),
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


