go 
create procedure xemdoitac1
@madt varchar(30)
as begin
	begin tran
	if(not exists(select * from doitac where madt = @madt)) rollback
	WAITFOR DELAY '00:00:10';
	select * from doitac where madt = @madt
	commit
end

exec xemdoitac @madt = "dt001"
