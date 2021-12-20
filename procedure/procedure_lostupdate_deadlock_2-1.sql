use DB_QLBH
go

create procedure capnhatnamhethanhopdong_deadlock
@mahd varchar(30), @nam int
as begin
	begin tran
	SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
	if not exists(select mahd  from hopdong where @mahd = mahd) rollback
	declare @namhethan int, @hethan date,@thanghethan int, @ngay int, @new date
	set @namhethan = (select year(ngayhethan) from hopdong where @mahd = mahd)
	set @thanghethan = (select month(ngayhethan) from hopdong where @mahd = mahd)
	set @ngay = (select day(ngayhethan) from hopdong where @mahd = mahd)
	set @hethan = (select ngayhethan from hopdong where @mahd = mahd)
	waitfor delay '00:00:05'
	set @namhethan = @namhethan + @nam
	set @new = convert(varchar,@namhethan) +'-' 
		+CONVERT(varchar,@thanghethan) + '-' + convert(varchar, @ngay)
	update hopdong set ngayhethan = @new where @mahd = @mahd
	select * from HOPDONG where @mahd = mahd
	commit tran
end

exec capnhatnamhethanhopdong_deadlock @mahd = 'HD001', @nam = 2

--update hopdong set NgayHetHan = '2022-11-18'