use DB_QLBH
go
create procedure xemhopdong1
@mahd varchar(15)
as begin
	begin tran
	if not exists (select * from hopdong where MaHD = @mahd) rollback
	waitfor delay '00:00:10'
	select * from hopdong where mahd = @mahd
	commit
end

exec xemhopdong1 @mahd = "HD001"