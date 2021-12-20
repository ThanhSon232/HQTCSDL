use DB_QLBH
go

create PROCEDURE capnhatgiamphivanchuyendonhang_error
@madh char(15), @giagiam INT
as begin
	begin tran
	if not exists(select madh  from donhang where @madh = madh) rollback
	declare @phihientai int
	set @phihientai = (select phivanchuyen from donhang where @madh = madh)
	waitfor delay '00:00:05'
	set @phihientai = @phihientai  - @giagiam
	update DonHang set PhiVanChuyen = @phihientai  where madh = @madh
	select * from DONHANG where @madh = madh
	commit tran
end

EXEC capnhatgiamphivanchuyendonhang_error @madh =  "KH001DT001CN001", @giagiam = 4000
