SELECT	DISTINCT e.employee_id , e.first_name , e.surname, e.known_as_first, e.known_as, v.job_desc, v.JOB_CODE, v.EMP_GROUP_CODE, v.emp_group_desc
FROM	EC_EMPLOYEE e JOIN hd_wrdsb_employee_view v ON e.EMPLOYEE_ID = v.EMPLOYEE_ID
WHERE	(v.job_desc LIKE 'Tchr%' OR v.job_desc LIKE 'Teacher%' OR v.job_desc LIKE 'Admin%' OR v.job_desc LIKE 'DECE%')
--AND		e.EMPLOYEE_ID = '35666'  
--AND		v.job_desc LIKE '


SELECT DESCRIPTION_ABBR, DESCRIPTION_TEXT, JOB_CODE FROM EC_JOBS WHERE 
DESCRIPTION_ABBR LIKE 'Tchr/Elem'
--DESCRIPTION_ABBR LIKE 'tChr%' 
--OR DESCRIPTION_ABBR LIKE 'Teacher%'
--OR DESCRIPTION_ABBR LIKE 'dece%'