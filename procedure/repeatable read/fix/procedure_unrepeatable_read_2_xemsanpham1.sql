--Xem san pham
go 
CREATE procedure xemsanpham1
@masp varchar(30)
as begin
	begin tran
	SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
	if(not exists(select * from sanpham where masp = @masp)) rollback
	WAITFOR DELAY '00:00:10';
	select * from sanpham where masp = @masp
	commit
end
