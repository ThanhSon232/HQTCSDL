--Xem don hang
go 
create procedure xemdonhang
@madh varchar(30)
as begin
	begin tran
	if(not exists(select * from donhang where madh = @madh)) rollback
	WAITFOR DELAY '00:00:10';
	select * from donhang where madh = @madh
	commit
end

exec xemdonhang @madh = "KH001DT001CN001"
