


-- =============================================
-- =============================================


USE AdventureWorks2016  
GO  

--Create Log File
create table dbo.Log
(
	LogName varchar(255) not null,
	LogDate datetime not null,
	LogMessage nvarchar(max) null
)
create index IdxLogNameLogDate on dbo.Log (LogName, LogDate)
GO

--Example Showing Steps to Use Log File to Cach Error
--Log it to Log Table, and Throw to calling process.


DROP PROCEDURE IF EXISTS dbo.GetAverageEmployeeVacationHours
GO

create proc dbo.GetAverageEmployeeVacationHours
as
begin try
	declare @logMsg varchar(max)
	declare @logKey varchar(255) = 'GetAverageEmployeeVacationHours'
	declare @now as datetime

	declare @totalHours float, 
			@totalEmployees float,
			@avgHours float


	select @totalHours =  sum(VacationHours)
	from HumanResources.Employee;

	select @totalEmployees = COUNT(*)
	from HumanResources.Employee
	WHERE HireDate > '2020-01-01' -- ---> p' lanzar el error

	set @AvgHours = @TotalHours / @TotalEmployees;
	print 'Average Vacation Hours For Employees Are:  ' + cast(@AvgHours as varchar);
	
end try

begin catch
	set @now = getdate()
    set @logMsg = 'Error: ' + cast(error_number() as varchar(50))    
            + ' State: ' + cast(error_state() as varchar(50))
            + ' Proc: ' + cast(isnull(error_procedure(), '') as varchar(100)) 
            + ' Msg: ' + cast(isnull(error_message(), '') as varchar(max))

    insert into dbo.Log (LogName, LogDate, LogMessage)
           values (@logKey, @now, @logMsg)

    ;throw;  --Rethrow to calling process        ESTE HACE Q SI SE MANDE UN ERROR COMO SI NO TUVIERA TRY-CATCH
end catch  
go


DROP PROCEDURE IF EXISTS dbo.GetAverageEmployeeVacationHours
GO


-- ====================================


select * from Log;

-- p' filtrar en q sp ocurrio
-- p'q aca voy a tirar los de todos los sps

select * from Log
where LogName = 'GetAverageEmployeeVacationHours';




