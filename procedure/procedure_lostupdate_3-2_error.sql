USE DB_QLBH
GO

create PROCEDURE capnhatsoluongdondoitac_error
@madt VARCHAR(30), @soluong int
AS BEGIN
	BEGIN TRAN
	IF NOT EXISTS(SELECT madt FROM doitac WHERE @madt = madt) ROLLBACK
	DECLARE @soluonghientai INT
	SET @soluonghientai = (SELECT SoLuongDon FROM DOITAC  WHERE @madt = madt)
		WAITFOR DELAY '00:00:05'
	SET @soluonghientai = @soluonghientai + @soluong
	UPDATE DOITAC SET  SoLuongDon = @soluonghientai  WHERE madt = @madt
	SELECT * from DoiTac where @madt = madt
	commit tran
end

exec capnhatsoluongdondoitac_error @madt = 'DT003',@soluong = 3