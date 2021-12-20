create database DB_QLBH
go
use DB_QLBH
go

create table DOITAC(
	MaDT varchar(30),
	TenDoiTac nvarchar(150),
	ThanhPho nvarchar(150),
	Quan nvarchar(15),
	SoChiNhanh int,
	SoLuongDon int,
	LoaiHangVanChuyen nvarchar(15),
	DiaChiKD nvarchar(150),
	SDT char(15),
	email nvarchar(150),
	MaSoThue char(15),
	primary key(MaDT)
)

create table CHINHANH(
	MaCN varchar(30),
	MaDT varchar(30),
	DiaChi nvarchar(150), 
	NguoiDaiDien nvarchar(150),
	primary key(MaCN)
)

create table HOPDONG(
	MaHD varchar(30),
	NgayLap date,
	NgayHetHan date,
	Hoahong float,
	MaDT varchar(30),
	MaCN varchar(30),
	primary key(MaHD)
)

create table SANPHAM(
	MaSP varchar(30),
	PhanLoai nvarchar(150),
	Gia int,
	MaCN varchar(30),
	primary key(MaSP)
)

create table KHACHHANG(
	MaKH varchar(30),
	HoTen nvarchar(150),
	SDT char(15),
	DiaChi nvarchar(150),
	email nvarchar(150),
	primary key(MaKH)
)

create table CTDONHANG(
	MaDH varchar(30),
	MaSP varchar(30),
	SoLuong int,
	primary key(MaDH,MaSP)
)

create table DONHANG(
	MaDH varchar(30),
	PhiSanPham int,
	PhiVanChuyen int,
	NgayLapHoaDon date,
	Tong int,
	TinhTrang nvarchar(150),
	KhuVuc nvarchar(150),
	MaKH varchar(30),
	MaTX varchar(30),
	MaDT varchar(30)
	primary key(MaDH)
)

create table TAIXE(
	MaTX varchar(30),
	HoTen nvarchar(150),
	CMND char(15) UNIQUE,
	DienThoai char(15),
	DiaChi nvarchar(150),
	BienSoXe char(15),
	KVHoatDong nvarchar(150),
	email nvarchar(150),
	STK char(15),
	TenNganHang nvarchar(150),
	primary key(MaTX)
)

alter table CHINHANH add constraint FK_CHINHANH_DOITAC foreign key(MaDT) references DOITAC(MaDT)
alter table HOPDONG add constraint FK_HOPDONG_CHINHANH foreign key(MaCN) references CHINHANH(MaCN)
alter table HOPDONG add constraint FK_HOPDONG_DOITAC foreign key(MaDT) references DOITAC(MaDT)
alter table SANPHAM add constraint FK_SANPHAM_CHINHANH foreign key(MaCN) references CHINHANH(MaCN)
alter table CTDONHANG add constraint FK_CTDONHANG_DONHANG foreign key(MaDH) references DONHANG(MaDH)
alter table CTDONHANG add constraint FK_CTDONHANG_SANPHAM foreign key(MaSP) references SANPHAM(MaSP)
alter table DONHANG add constraint FK_DONHANG_KHACHHANG foreign key(MaKH) references KHACHHANG(MaKH)
alter table DONHANG add constraint FK_DONHANG_TAIXE foreign key(MaTX) references TAIXE(MaTX)
alter table DONHANG add constraint FK_DONHANG_DOITAC foreign key(MaDT) references DOITAC(MaDT)
