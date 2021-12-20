USE DB_QLBH
GO

create procedure capnhatsoluongdondoitac_deadlock
@madt varchar(30), @soluong int
as begin
	begin tran
	SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
	if not exists(select madt from doitac where @madt = madt) rollback
	declare @soluonghientai int
	set @soluonghientai = (select SoLuongDon from DOITAC where @madt = madt)
		waitfor delay '00:00:05'
	set @soluonghientai = @soluonghientai + @soluong
	update DOITAC set  SoLuongDon = @soluonghientai  where madt = @madt
	select * from DoiTac where @madt = madt
	commit tran
end

exec capnhatsoluongdondoitac_deadlock @madt = 'DT001', @soluong = 2
		