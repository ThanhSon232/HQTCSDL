use DB_QLBH
go
create procedure thaydoihoahong_unrepeatable
@mahd varchar(15), @hoahong float
as begin
	begin tran
	if not exists (select * from hopdong where MaHD = @mahd) rollback
	update hopdong set hoahong = @hoahong where mahd = @mahd
	commit
end

exec thaydoihoahong_unrepeatable @mahd = "HD001", @hoahong = 2000

