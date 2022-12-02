-- ================================
-- Create User-defined Table Type
-- ================================
USE [EASEY-IN]
GO

CREATE TYPE [SqlGenQa].[Test_Information_Table] AS TABLE(
	[TEST_SUM_ID] [varchar](45) NOT NULL,
    [ORIS_CODE] [numeric](6,0) NOT NULL,
    [FACILITY_NAME] [varchar](40) NOT NULL,
    [LOCATION_NAME] [varchar](6) NOT NULL,
    [TEST_TYPE_CD] [varchar](7) NOT NULL,
    [TEST_NUM] [varchar](18) NOT NULL,
	PRIMARY KEY CLUSTERED 
(
	[TEST_SUM_ID] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)
GO

