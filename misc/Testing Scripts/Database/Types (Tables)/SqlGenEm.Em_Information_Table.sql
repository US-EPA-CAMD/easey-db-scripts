USE [EASEY-IN]
GO

/****** Object:  UserDefinedTableType [SqlGenEm].[Em_Information_Table]    Script Date: 2/7/2023 2:36:52 PM ******/
CREATE TYPE SqlGenEm.Em_Information_Table AS TABLE(
	[ORIS_CODE] [numeric](6, 0) NOT NULL,
	[FACILITY_NAME] [varchar](40) NOT NULL,
	[LOCATIONS] [varchar](max) NOT NULL,
	[QUARTER] [varchar](32) NOT NULL,
	[LOCATION_NAME] [varchar](6) NOT NULL,
	[MON_PLAN_ID] [varchar](45) NOT NULL,
	[RPT_PERIOD_ID] int NOT NULL,
	[MON_LOC_ID] [varchar](45) NOT NULL,
	PRIMARY KEY CLUSTERED 
(
	[MON_PLAN_ID] ASC,
    [RPT_PERIOD_ID] ASC,
    [MON_LOC_ID] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)
GO
