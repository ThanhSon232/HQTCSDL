USE DB_QLBH
GO

create PROCEDURE capnhatgiamphivanchuyendonhang_deadlock
@madh char(15), @giagiam int
as begin
	begin tran
	SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
	if not exists(select madh  from donhang where @madh = madh) rollback
	declare @phihientai int
	set @phihientai = (select phivanchuyen from donhang where @madh = madh)
	waitfor delay '00:00:05'
	set @phihientai = @phihientai - @giagiam
	update DonHang set PhiVanChuyen = @phihientai  where madh = @madh
	select * from DONHANG where @madh = madh
	commit tran
end

exec capnhatgiamphivanchuyendonhang_deadlock @madh =  "KH001DT001CN001", @giagiam = 2000
