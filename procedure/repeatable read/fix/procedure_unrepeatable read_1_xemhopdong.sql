use DB_QLBH
go
create procedure xemhopdong
@mahd varchar(15)
as begin
	begin tran
		set TRANSACTION isolation level repeatable read
	if not exists (select * from hopdong where MaHD = @mahd) rollback
	select * from hopdong where mahd = @mahd
	waitfor delay '00:00:05'
	commit
end

exec xemhopdong1 @mahd = "HD001"