go
create procedure thaydoidoitac
@madt varchar(15), @tendt nvarchar(150), @tentp nvarchar(150),
@quan int, @socn int, @sldon int, @loaihang nvarchar(150), 
@diachi nvarchar(150), @sdt varchar(30), @email varchar(150),
@masothue varchar(30)
as begin
	begin tran
	if not exists (select * From doitac where @madt = madt) rollback
	update doitac
	set TenDoiTac = @tendt, ThanhPho=@tentp, Quan = @quan,
	SoChiNhanh = @socn, SoLuongDon = @sldon, LoaiHangVanChuyen = @loaihang,
	DiaChiKD = @diachi,SDT = @sdt, email = @email, MaSoThue = @masothue
	where madt = @madt
	commit
end

exec thaydoidoitac @madt = "dt001", @tendt = "Thanh Son",
@tentp = "Ha Noi", @quan = 11,@socn = 1, @sldon = 2, @loaihang = "my pham",
@diachi = "bcd", @sdt = 321, @email = a, @masothue = 888



