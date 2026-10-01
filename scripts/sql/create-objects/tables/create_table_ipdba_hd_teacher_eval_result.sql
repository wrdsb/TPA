-- script to create table

CREATE TABLE	[IPDBA].[HD_TEACHER_EVAL_RESULT]
(
				[EMPLOYEE_ID] [varchar](9) NOT NULL
				, [CONTRACT_CATEGORY] [varchar](15) NOT NULL
				, [REVIEW_YEAR_START] [numeric](4, 0) NOT NULL
				, [REVIEW_YEAR_END] [numeric](4, 0) NOT NULL
				, [REVIEW_DATE] [datetime2](0) NULL
				, [RATING] [varchar](15) NULL
				, [LOCATION_CODE] [varchar](8) NULL
				, [NEXT_REVIEW_YEAR_START] [numeric](4, 0) NULL
				, [NEXT_REVIEW_YEAR_END] [numeric](4, 0) NULL
				, [COMMENT_TEXT] [varchar](250) NULL
				, [ADDED_BY] [varchar](30) NOT NULL
				, [ADDED_DATE] [datetime2](0) NOT NULL
				, [CHANGED_BY] [varchar](30) NULL
				, [CHANGED_DATE] [datetime2](0) NULL
				, [SUPERINTENDENT_ID] [varchar](9) NULL
				, [Id] [int] IDENTITY(1,1)  PRIMARY KEY
)
GO

-- incase if table is already exist

ALTER TABLE [IPDBA].[HD_TEACHER_EVAL_RESULT]
ADD Id INT IDENTITY(1,1) PRIMARY KEY;