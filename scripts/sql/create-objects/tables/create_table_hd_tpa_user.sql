USE [HDHRP]
GO

/*
Author:		Meenakshi Durairaj 
Date:		2026-AUG-31
Purpose:	Table will contain authorized/admin person records who is allowed to do appraisal
*/


SET ANSI_NULLS ON
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[hd_tpa_user]') AND type in (N'U'))
DROP TABLE [dbo].[hd_tpa_user]
GO
 CREATE TABLE   [dbo].[hd_tpa_user] 
                (
                employee_id VARCHAR(10) UNIQUE  NOT NULL
                , userid    VARCHAR(20) UNIQUE  NOT NULL
                , admin     BIT
                , Id        INT IDENTITY(1,1) PRIMARY KEY
                );

GO
