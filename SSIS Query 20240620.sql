-- SSIS Query
-- checking current running job
USE ssisdb

SELECT ja.job_id
	,j.name AS job_name
	,ja.start_execution_date
	,ISNULL(last_executed_step_id, 0) + 1 AS current_executed_step_id
	,Js.step_name
FROM msdb.dbo.sysjobactivity ja --information about the activity of SQL Server Agent jobs
LEFT JOIN msdb.dbo.sysjobhistory jh --historical information about the job's execution
	ON ja.job_history_id = jh.instance_id
JOIN msdb.dbo.sysjobs j --job's metadata, such as the job name
	ON ja.job_id = j.job_id
JOIN msdb.dbo.sysjobsteps js ON ja.job_id = js.job_id
	AND ISNULL(ja.last_executed_step_id, 0) + 1 = js.step_id --information about the current step being executed
WHERE ja.session_id = (
		SELECT TOP 1 session_id
		FROM msdb.dbo.syssessions
		ORDER BY agent_start_date DESC
		)
	AND start_execution_date IS NOT NULL
	AND stop_execution_date IS NULL;

-- Start a ssis job
Msdb.dbo.sp_start_job @job_name = 'job name'

-- Stop a job
EXEC msdb.dbo.sp_stop_job @SSISPackage

--Checking SSIS Job activity like job name, Start Time , duration of execution
SELECT sj.name
	,sja.run_requested_date
	,CONVERT(VARCHAR(12), sja.stop_execution_date - sja.start_execution_date, 114) Duration
FROM msdb.dbo.sysjobactivity sja
INNER JOIN msdb.dbo.sysjobs sj ON sja.job_id = sj.job_id
WHERE sja.run_requested_date IS NOT NULL
ORDER BY sja.run_requested_date DESC;
