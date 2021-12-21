go 
create procedure xemdoitac
@madt varchar(30)
as begin
	begin tran
	if(not exists(select * from doitac where madt = @madt)) rollback
	select * from doitac where madt = @madt
	WAITFOR DELAY '00:00:10';
	commit
end

exec xemdoitac @madt = "dt001"
