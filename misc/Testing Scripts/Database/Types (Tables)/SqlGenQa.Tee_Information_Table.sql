-- ================================
-- Create User-defined Table Type
-- ================================
USE [EASEY-IN]
GO

CREATE TYPE [SqlGenQa].[Tee_Information_Table] AS TABLE(
	[TEST_EXTENSION_EXEMPTION_ID] [varchar](45) NOT NULL,
    [ORIS_CODE] [numeric](6,0) NOT NULL,
    [FACILITY_NAME] [varchar](40) NOT NULL,
    [LOCATION_NAME] [varchar](6) NOT NULL,
    [QUARTER] [varchar](32) NOT NULL,
    [EXTENS_EXEMPT_CD] [varchar](7) NOT NULL,
    [SYSTEM_IDENTIFIER] [varchar](3) NULL,
    [SYS_TYPE_CD] [varchar](7) NULL,
    [COMPONENT_IDENTIFIER] [varchar](3) NULL,
    [COMPONENT_TYPE_CD] [varchar](7) NULL,
	PRIMARY KEY CLUSTERED 
(
	[TEST_EXTENSION_EXEMPTION_ID] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)
GO

