use DB_QLBH
go
create procedure xemhopdong
@mahd varchar(15)
as begin
	begin tran
	if not exists (select * from hopdong where MaHD = @mahd) rollback
	select * from hopdong where mahd = @mahd
	waitfor delay '00:00:10'
	commit
end

exec xemhopdong1 @mahd = "HD001"