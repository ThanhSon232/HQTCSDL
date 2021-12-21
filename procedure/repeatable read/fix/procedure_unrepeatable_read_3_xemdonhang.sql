--Xem don hang
go 
create procedure xemdonhang
@madh varchar(30)
as begin
	begin tran
	set TRANSACTION isolation level repeatable read
	if(not exists(select * from donhang where madh = @madh)) rollback
	select * from donhang where madh = @madh
	WAITFOR DELAY '00:00:05';
	commit
end

exec xemdonhang @madh = "KH001DT001CN001"
