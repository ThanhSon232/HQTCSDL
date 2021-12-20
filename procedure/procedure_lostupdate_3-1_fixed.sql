USE DB_QLBH
GO

Create procedure capnhatsoluongdondoitac
@madt varchar(30), @soluong int
as begin
	begin tran
	if not exists(select madt from doitac where @madt = madt) rollback
	declare @soluonghientai int
	set @soluonghientai = (select SoLuongDon from DOITAC with(XLOCK) where @madt = madt)
		waitfor delay '00:00:05'
	set @soluonghientai = @soluonghientai + @soluong
	update DOITAC set  SoLuongDon = @soluonghientai  where madt = @madt
	commit tran
end

exec capnhatsoluongdondoitac @madt = 'DT003',@soluong = 2
		