USE [HDHRP]
GO

/*
Author:		Meenakshi Durairaj 
Date:		2026-AUG-31
Purpose:	Table to store user details who is doing the employee appraisal
*/


SET ANSI_NULLS ON
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[hd_tpa_audit]') AND type in (N'U'))
DROP TABLE [dbo].[hd_tpa_audit]
GO

CREATE TABLE [dbo].[hd_tpa_audit] (
    employee_id VARCHAR(9),
    firstname VARCHAR(30),
    surname VARCHAR(30),   
    emailaddress VARCHAR(60),
    userid VARCHAR(13),
    Purpose VARCHAR(256),
    inquiry_date DATETIME NULL,
    Id INT IDENTITY(1,1) PRIMARY KEY
);


GO
