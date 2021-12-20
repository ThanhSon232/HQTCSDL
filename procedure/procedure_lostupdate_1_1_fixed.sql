USE DB_QLBH
GO

create PROCEDURE capnhatgiamphivanchuyendonhang
@madh char(15), @giagiam int
as begin
	begin tran
	if not exists(select madh from donhang where @madh = madh) rollback
	declare @phihientai int
	set @phihientai = (select phivanchuyen from donhang with(XLOCK) where @madh = madh)
		waitfor delay '00:00:05'
	set @phihientai = @phihientai - @giagiam
	update DonHang set PhiVanChuyen = @phihientai  where madh = @madh
	commit tran
end

EXEC capnhatgiamphivanchuyendonhang @madh =  "KH001DT001CN001" , @giagiam = 3000
