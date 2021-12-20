use DB_QLBH
go

create procedure capnhatnamhethanhopdong
@mahd varchar(30), @sonam int
as begin
	begin tran
	if not exists(select mahd  from hopdong where @mahd = mahd) rollback
	declare @namhethan int, @hethan date,@thanghethan int, @ngay int, @new date, @outdated date
	set @outdated = (select ngayhethan from hopdong with(XLOCK) where @mahd = mahd)
	set @namhethan = year(@outdated)
	set @thanghethan = month(@outdated)
	set @ngay = day(@outdated)
	set @namhethan = @namhethan + @sonam
		waitfor delay '00:00:05'
	set @new = convert(varchar,@namhethan) +'-' 
		+CONVERT(varchar,@thanghethan) + '-' + convert(varchar, @ngay)
	update hopdong set ngayhethan = @new where @mahd = @mahd
	commit tran
end

EXEC capnhatnamhethanhopdong @mahd = 'HD001', @sonam = 2

update hopdong set NgayHetHan = ngaylap