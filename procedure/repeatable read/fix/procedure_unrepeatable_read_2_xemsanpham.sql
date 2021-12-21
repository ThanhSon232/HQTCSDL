--Xem san pham
go 
CREATE procedure xemsanpham
@masp varchar(30)
as begin
	begin tran
	set TRANSACTION isolation level repeatable read
	if(not exists(select * from sanpham where masp = @masp)) rollback
	select * from sanpham where masp = @masp
	WAITFOR DELAY '00:00:05';
	commit
end
