-- ================================
-- Create User-defined Table Type
-- ================================
USE [EASEY-IN]
GO

CREATE TYPE [SqlGenQa].[Qce_Information_Table] AS TABLE(
	[QA_CERT_EVENT_ID] [varchar](45) NOT NULL,
    [ORIS_CODE] [numeric](6,0) NOT NULL,
    [FACILITY_NAME] [varchar](40) NOT NULL,
    [LOCATION_NAME] [varchar](6) NOT NULL,
    [QA_CERT_EVENT_CD] [varchar](7) NOT NULL,
    [QA_CERT_EVENT_DATE] [date] NOT NULL,
    [QA_CERT_EVENT_HOUR] [integer] NOT NULL,
    [SYSTEM_IDENTIFIER] [varchar](3) NULL,
    [SYS_TYPE_CD] [varchar](7) NULL,
    [COMPONENT_IDENTIFIER] [varchar](3) NULL,
    [COMPONENT_TYPE_CD] [varchar](7) NULL,
	PRIMARY KEY CLUSTERED 
(
	[QA_CERT_EVENT_ID] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)
GO

