--cap nhat thong tin sanpham
go
create procedure capnhattinhtrangdonhang
@madh char(15), @tinhtrang nvarchar(15)
as begin
	begin tran
	if not exists(select madh from donhang where @madh = madh) rollback
	update DonHang set tinhtrang = @tinhtrang where madh = @madh
	commit tran
end

EXEC capnhattinhtrangdonhang @madh = "KH001DT001CN001",
@tinhtrang = "dang giao hang"

