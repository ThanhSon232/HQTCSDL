use DB_QLBH
go

--DANG KY DOI TAC MOI
GO
alter PROCEDURE DANGKYDOITAC
(@ten nvarchar(150), @tp nvarchar(150), @quan nvarchar(15), @loaihang nvarchar(15), @diachikd nvarchar(150), @sodt char, @email nvarchar(150), @masothue char(15))
AS BEGIN
	BEGIN TRAN
	waitfor delay '00:00:04'
	DECLARE @ID INT
	IF (SELECT COUNT(MADT) FROM DOITAC) = 0
		SET @ID = '0'
	ELSE
	
	SET @ID=(SELECT COUNT(dt.mycount) 
	FROM (SELECT MADT,COUNT(MADT) as mycount 
			FROM DOITAC 
			GROUP BY MADT) as dt)

	DECLARE @MA VARCHAR(10)
	IF (@ID >= 0 and @ID < 9) SET @MA = 'DT00' + CONVERT(varchar,  @ID + 1)
			ELSE SET @MA = 'DT0' + CONVERT(VARCHAR, @ID + 1)
		if(exists(select * from doitac where @MA=MaDT)) 
		begin
			print('Da ton tai')
			rollback transaction;
			end
		ELSE
		INSERT INTO DOITAC VALUES(@MA,@ten,@tp,@quan,0,0,@loaihang,@diachikd,@sodt,@email,@masothue)
	COMMIT TRAN
END


--EXEC DANGKYDOITAC @ten="MAI",@tp = "HCM", @quan = "10", @loaihang ="mypham", @diachikd = "abc", @sodt="123", @email="abc", @masothue="999"
--EXEC DANGKYDOITAC @ten="la",@tp = "HCM", @quan = "10", @loaihang ="mypham", @diachikd = "abc", @sodt="123", @email="abc", @masothue="999"

--EXEC DANGKYDOITAC @ten="toan",@tp = "HCM", @quan = "5", @loaihang ="mypham", @diachikd = "abc", @sodt="123", @email="abc", @masothue="999"

--DROP PROCEDURE DANGKYDOITAC



--DANG KY CHI NHANH
GO
CREATE PROCEDURE DANGKYCHINHANH
@madt varchar(15), @diachi nvarchar(150), @nguoidaidien nvarchar(150)
AS BEGIN
	BEGIN TRAN
	if not exists (select * from doitac where madt = @madt) rollback tran

	DECLARE @ID INT
	IF (SELECT COUNT(MADT) FROM CHINHANH where MADT = @madt) = 0
		SET @ID = '0'
	ELSE
	SET @ID=(SELECT MAX(dt.mycount) 
	FROM (SELECT macn,COUNT(macn) as mycount 
			FROM chinhanh
			where madt = @madt
			GROUP BY macn) as dt)

	DECLARE @MA VARCHAR(15)
	IF (@ID >= 0 and @ID < 9) SET @MA =@madt + 'CN00' + CONVERT(varchar,  @ID + 1)
			ELSE SET @MA =@madt + 'CN00' + CONVERT(VARCHAR, @ID + 1)

	INSERT INTO CHINHANH VALUES(@MA,@madt,@diachi,@nguoidaidien)
	
	

	UPDATE DOITAC SET SoChiNhanh = SoChiNhanh+1 WHERE MADT = @madt
	COMMIT TRAN
END


go
--EXEC DANGKYCHINHANH @madt = 'DT001', @diachi = 'abc', @nguoidaidien = 'abc'

--drop PROCEDURE DANGKYCHINHANH



--LAP HOP DONG
GO
CREATE PROCEDURE DANGKYHOPDONG
@madt varchar(30), @macn varchar(30)
AS BEGIN
	BEGIN TRAN
	if not exists (select madt,macn from chinhanh where @madt=madt and @macn = macn) rollback
	DECLARE @ID INT
	IF (SELECT COUNT(MADT) FROM hopdong where MADT = @madt) = 0
		SET @ID = '0'
	ELSE
	SET @ID=(SELECT MAX(dt.mycount) 
	FROM (SELECT macn,COUNT(macn) as mycount 
	FROM hopdong
	where madt = @madt
	GROUP BY macn) as dt)

	DECLARE @MA VARCHAR(10)
	IF (@ID >= 0 and @ID < 9) SET @MA =  'HD00' + CONVERT(varchar,  @ID + 1)
			ELSE SET @MA = 'HD00' + CONVERT(VARCHAR, @ID + 1)

	INSERT INTO hopdong VALUES(@MA, CURRENT_TIMESTAMP, NULL, NULL,@madt,@macn)
	
	

	COMMIT TRAN
END


go
--EXEC DANGKYHOPDONG @madt = 'DT001', @macn = 'DT001CN001'

--drop PROCEDURE DANGKYCHINHANH



--Them san pham
GO
CREATE PROCEDURE THEMSANPHAM
 @phanloai nvarchar(15), @gia int, @macn varchar(15)
AS BEGIN
	BEGIN TRAN
	if not exists (select macn from HOPDONG where @macn=macn) rollback
	DECLARE @TIME DATE
	SET @TIME = CURRENT_TIMESTAMP
	if @TIME > (select ngayhethan from hopdong where @macn = macn) rollback
	DECLARE @ID INT
	IF (SELECT COUNT(macn) FROM SANPHAM where MaCN = @macn) = 0
		SET @ID = '0'
	ELSE
	SET @ID=(SELECT MAX(dt.mycount) 
	FROM (SELECT macn,COUNT(macn) as mycount 
	FROM SANPHAM
	where macn = @macn
	GROUP BY macn) as dt)

	DECLARE @MA VARCHAR(15)
	IF (@ID >= 0 and @ID < 9) SET @MA = @macn + 'SP00' + CONVERT(varchar,  @ID + 1)
			ELSE SET @MA = @macn + 'SP00' + CONVERT(VARCHAR, @ID + 1)

	INSERT INTO SANPHAM VALUES(@MA,@phanloai,@gia,@macn)
	
	

	COMMIT TRAN
END

go 
--exec THEMSANPHAM @phanloai = "vip", @gia = 20, @macn = "DT001CN001"

--drop procedure themsanpham

--XOA SAN PHAM
go
CREATE PROCEDURE XOASANPHAM
@masp varchar(15), @macn varchar(15)
as begin
	begin tran
	if not exists(select masp from sanpham where @masp = masp) or not exists (select macn from chinhanh where macn = @macn) rollback
	DECLARE @DATE DATE
	SET @DATE = CURRENT_TIMESTAMP
	if @DATE > (SELECT NGAYHETHAN FROM HOPDONG WHERE @MACN = MACN) ROLLBACK
	delete from sanpham where masp = @masp and @macn = MaCN
	commit tran
end

go
--exec xoasanpham @masp = 'DT001CN001SP001', @macn = 'DT001CN001'

--drop procedure xoasanpham

--cap nhat thong tin sanpham
go
alter procedure capnhatsanpham
@masp varchar(15), @phanloai nvarchar(150), @gia int, @macn varchar(15)
as begin
	begin tran
	
	DECLARE @DATE DATE
	SET @DATE = CURRENT_TIMESTAMP
	update sanpham set phanloai = @phanloai, gia = @gia, macn = @macn where masp = @masp
	if @DATE > (SELECT NGAYHETHAN FROM HOPDONG WHERE @MACN = MACN)
	begin
		print('date rollback')
		ROLLBACK
	end
	if not exists(select masp from sanpham where @masp = masp) or not exists (select macn from chinhanh where macn = @macn) rollback
	if @@trancount > 0 
		commit tran
end

--EXEC CAPNHATSANPHAM @masp = "DT001CN001SP001", @phanloai = "css", @gia = 1000, @macn = "DT001CN00000000"
--DROP PROCEDURE CAPNHATSANPHAM


--DANG KY KHACH HANG
GO
CREATE PROCEDURE DANGKYKHACHHANG
@hoten nvarchar(150), @sdt char(15), @diachi nvarchar(150), @email nvarchar(150)
AS BEGIN
	BEGIN TRAN
	DECLARE @ID INT
	IF (SELECT COUNT(MAKH) FROM KHACHHANG) = 0
		SET @ID = '0'
	ELSE
	SET @ID=(SELECT MAX(dt.mycount) 
	FROM (SELECT MAKH,COUNT(MAKH) as mycount 
	FROM KHACHHANG 
	GROUP BY MAKH) as dt)

	DECLARE @MA VARCHAR(10)
	IF (@ID >= 0 and @ID < 9) SET @MA = 'KH00' + CONVERT(varchar,  @ID + 1)
			ELSE SET @MA = 'KH0' + CONVERT(VARCHAR, @ID + 1)
		if(exists(select MAKH from KHACHHANG where @MA=MaKH)) rollback transaction;
		ELSE
		INSERT INTO KHACHHANG VALUES(@MA,@hoten,@sdt,@diachi,@email)
	COMMIT TRAN
END

go
--exec dangkykhachhang @hoten = "VIP PRO", @sdt = "123", @diachi = "abc", @email="abc"

--drop procedure dangkykhachhang


--DAT HANG
GO
CREATE PROCEDURE DATHANG
@makh varchar(30), @masp varchar(30), @soluong int
as begin
	begin tran
	if not exists(select makh from khachhang where makh = @makh) or not exists( select masp from sanpham where masp = @masp) or @soluong <=0 rollback

	--if @soluong > (select soluong from sanpham where @masp = masp) rollback
	DECLARE @ID INT
	IF (SELECT COUNT(MAKH) FROM DONHANG) = 0
		SET @ID = '0'
	ELSE
	SET @ID=(SELECT MAX(dt.mycount) 
			FROM (SELECT MAKH,COUNT(MAKH) as mycount 
			FROM DONHANG 
			GROUP BY MAKH) as dt)

	DECLARE @MA VARCHAR(15)
	
	SET @MA = @makh + @masp

	Declare @khuvuc nvarchar(150)
	set @khuvuc = (select diachi from khachhang where @makh = MaKH)
	INSERT INTO DONHANG(makh, madh, khuvuc) values (@makh, @ma, @khuvuc)
	INSERT INTO CTDONHANG values (@ma, @masp, @soluong)

	commit tran
end

go 
--exec dathang @makh = 'KH001',@masp = 'DT001CN001SP001', @soluong = 20

-- drop procedure dathang

--DANG KY TAI XE
GO
CREATE PROCEDURE DANGKYTAIXE
@hoten nvarchar(150),
@cmnd char(15),
@sdt char(15),
@diachi nvarchar(150),
@biensoxe char(15),
@kvhoatdong nvarchar(150),
@email nvarchar(150),
@stk char(15),
@tennganhang nvarchar(150)

AS BEGIN
	BEGIN TRAN
	DECLARE @ID INT
	IF (SELECT COUNT(MaTX) FROM TAIXE) = 0
		SET @ID = '0'
	ELSE
	SET @ID=(SELECT MAX(dt.mycount) 
	FROM (SELECT MaTX,COUNT(MaTX) as mycount 
	FROM TAIXE 
	GROUP BY MATX) as dt)

	DECLARE @MA VARCHAR(10)
	IF (@ID >= 0 and @ID < 9) SET @MA = 'TX00' + CONVERT(varchar,  @ID + 1)
			ELSE SET @MA = 'TX0' + CONVERT(VARCHAR, @ID + 1)
		if(exists(select MaTX from TAIXE where @MA=MaTX)) rollback transaction;
		ELSE
		INSERT INTO TAIXE VALUES(
			@MA,
			@hoten,
			@cmnd,
			@sdt,
			@diachi,
			@biensoxe,
			@kvhoatdong,
			@email,
			@stk,
			@tennganhang
			)
	COMMIT TRAN
END

go
--exec dangkytaixe @hoten = "VIP PRO",@cmnd = "123456789", @sdt = "123", @diachi = "abc", @biensoxe="abc", @kvhoatdong="abc", @email="abc", @stk="abc", @tennganhang="abc"

--drop procedure dangkytaixe


-- create table DONHANG(
-- 	MaDH char(15),
-- 	PhiSanPham int,
-- 	PhiVanChuyen int,
-- 	Tong int,
-- 	TinhTrang nvarchar(150),
-- 	MaKH char(15),
-- 	KhuVuc nvarchar(150),
-- 	MaTX char(15),
-- 	primary key(MaDH)
-- )

--cap nhat thong tin sanpham
-- non-repeatable read
go
alter procedure capnhattinhtrangdonhang
@madh char(15), @tinhtrang nvarchar(15)
as begin
	begin tran
	waitfor delay '00:00:05'
	if not exists(select madh from donhang where @madh = madh) 
	begin
		print('sai')
		rollback
	end
	update DonHang set tinhtrang = @tinhtrang where madh = @madh
	commit tran
end
--EXEC capnhattinhtrangdonhang @madh = "KH001DT001CN001", @tinhtrang = "da giao"
EXEC capnhattinhtrangdonhang @madh = "KH001DT001CN001", @tinhtrang = "da giao"
select * from DONHANG
waitfor delay'00:00:03'
select * from DONHANG
--DROP PROCEDURE CAPNHATSANPHAM

--drop database DB_QLBH

create procedure xemhopdong
@mahd varchar(15)
as begin
	begin tran
	if not exists (select * from hopdong where MaHD = @mahd) rollback
	select * from hopdong where mahd = @mahd
	commit
end

go
exec xemhopdong @mahd = "HD001"



--Xem don hang
go 
create procedure xemdonhang
@madh varchar(30)
as begin
	begin tran
	if(not exists(select * from donhang where madh = @madh)) rollback
	select * from donhang where madh = @madh
	commit
end

go
exec xemdonhang @madh = "KH001DT001CN001"



go 
create procedure xemdoitac
@madt varchar(30)
as begin
	begin tran
	if(not exists(select * from doitac where madt = @madt)) rollback
	select * from doitac where madt = @madt
	commit
end

go
exec xemdoitac @madt = "dt001"



