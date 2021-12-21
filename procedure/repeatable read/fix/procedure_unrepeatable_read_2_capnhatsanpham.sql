—Cap nhat san pham
go
create procedure capnhatsanpham
@masp varchar(30), @phanloai nvarchar(150), @gia int, @macn varchar(30)
as begin
	begin tran
	DECLARE @DATE DATE
	SET @DATE = CURRENT_TIMESTAMP
	update sanpham set phanloai = @phanloai, gia = @gia,
	macn = @macn where masp = @masp
	if @DATE > (SELECT NGAYHETHAN FROM HOPDONG WHERE @MACN = MACN) ROLLBACK
	if not exists(select masp from sanpham where @masp = masp) or
	not exists (select macn from chinhanh where macn = @macn) rollback
	commit tran
end

EXEC CAPNHATSANPHAM @masp = "DT001CN001SP001",
@phanloai = "Dien tu", @gia = 2000, @macn = "DT001CN001"