USE DB_QLBH
GO

create PROCEDURE capnhatnamhethanhopdong_error
@mahd VARCHAR(30), @nam int
AS BEGIN
	BEGIN TRAN
	IF NOT EXISTS(SELECT mahd  FROM hopdong WHERE @mahd = mahd) ROLLBACK
	DECLARE @namhethan INT, @hethan DATE,@thanghethan INT, @ngay INT, @new DATE, @outdated DATE
	SET @outdated = (SELECT ngayhethan FROM hopdong WHERE @mahd = mahd)
	SET @namhethan = YEAR(@outdated)
	SET @thanghethan = MONTH(@outdated)
	SET @ngay = DAY(@outdated)
	SET @namhethan = @namhethan + @nam
	WAITFOR DELAY '00:00:05'
	set @new = convert(varchar,@namhethan) +'-' +CONVERT(varchar,@thanghethan)
		+ '-' + convert(varchar, @ngay)
	update hopdong set ngayhethan = @new where @mahd = @mahd
	select * from HOPDONG where @mahd = mahd
	commit tran
end

EXEC capnhatnamhethanhopdong_error @mahd = 'HD001', @nam = 2



update hopdong set NgayHetHan = ngaylap