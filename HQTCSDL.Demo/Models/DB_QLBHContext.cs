using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

#nullable disable

namespace HQTCSDL.Demo.Models
{
    public partial class DB_QLBHContext : DbContext
    {
        public DB_QLBHContext()
        {
        }

        public DB_QLBHContext(DbContextOptions<DB_QLBHContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Chinhanh> Chinhanhs { get; set; }
        public virtual DbSet<Ctdonhang> Ctdonhangs { get; set; }
        public virtual DbSet<Doitac> Doitacs { get; set; }
        public virtual DbSet<Donhang> Donhangs { get; set; }
        public virtual DbSet<Hopdong> Hopdongs { get; set; }
        public virtual DbSet<Khachhang> Khachhangs { get; set; }
        public virtual DbSet<Sanpham> Sanphams { get; set; }
        public virtual DbSet<Taixe> Taixes { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("Server=DESKTOP-J5SCIIS\\SYNGUYEN;Database=DB_QLBH;Trusted_Connection=True;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("Relational:Collation", "SQL_Latin1_General_CP1_CI_AS");

            modelBuilder.Entity<Chinhanh>(entity =>
            {
                entity.HasKey(e => e.MaCn)
                    .HasName("PK__CHINHANH__27258E0E2048DF60");

                entity.ToTable("CHINHANH");

                entity.Property(e => e.MaCn)
                    .HasMaxLength(30)
                    .IsUnicode(false)
                    .HasColumnName("MaCN");

                entity.Property(e => e.DiaChi).HasMaxLength(150);

                entity.Property(e => e.MaDt)
                    .HasMaxLength(30)
                    .IsUnicode(false)
                    .HasColumnName("MaDT");

                entity.Property(e => e.NguoiDaiDien).HasMaxLength(150);

                entity.HasOne(d => d.MaDtNavigation)
                    .WithMany(p => p.Chinhanhs)
                    .HasForeignKey(d => d.MaDt)
                    .HasConstraintName("FK_CHINHANH_DOITAC");
            });

            modelBuilder.Entity<Ctdonhang>(entity =>
            {
                entity.HasKey(e => new { e.MaDh, e.MaSp })
                    .HasName("PK__CTDONHAN__F557D6E0BD63F45D");

                entity.ToTable("CTDONHANG");

                entity.Property(e => e.MaDh)
                    .HasMaxLength(30)
                    .IsUnicode(false)
                    .HasColumnName("MaDH");

                entity.Property(e => e.MaSp)
                    .HasMaxLength(30)
                    .IsUnicode(false)
                    .HasColumnName("MaSP");

                entity.HasOne(d => d.MaDhNavigation)
                    .WithMany(p => p.Ctdonhangs)
                    .HasForeignKey(d => d.MaDh)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_CTDONHANG_DONHANG");

                entity.HasOne(d => d.MaSpNavigation)
                    .WithMany(p => p.Ctdonhangs)
                    .HasForeignKey(d => d.MaSp)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_CTDONHANG_SANPHAM");
            });

            modelBuilder.Entity<Doitac>(entity =>
            {
                entity.HasKey(e => e.MaDt)
                    .HasName("PK__DOITAC__2725865543854FCE");

                entity.ToTable("DOITAC");

                entity.Property(e => e.MaDt)
                    .HasMaxLength(30)
                    .IsUnicode(false)
                    .HasColumnName("MaDT");

                entity.Property(e => e.DiaChiKd)
                    .HasMaxLength(150)
                    .HasColumnName("DiaChiKD");

                entity.Property(e => e.Email)
                    .HasMaxLength(150)
                    .HasColumnName("email");

                entity.Property(e => e.LoaiHangVanChuyen).HasMaxLength(15);

                entity.Property(e => e.MaSoThue)
                    .HasMaxLength(15)
                    .IsUnicode(false)
                    .IsFixedLength(true);

                entity.Property(e => e.Quan).HasMaxLength(15);

                entity.Property(e => e.Sdt)
                    .HasMaxLength(15)
                    .IsUnicode(false)
                    .HasColumnName("SDT")
                    .IsFixedLength(true);

                entity.Property(e => e.TenDoiTac).HasMaxLength(150);

                entity.Property(e => e.ThanhPho).HasMaxLength(150);
            });

            modelBuilder.Entity<Donhang>(entity =>
            {
                entity.HasKey(e => e.MaDh)
                    .HasName("PK__DONHANG__27258661B2B10FDD");

                entity.ToTable("DONHANG");

                entity.Property(e => e.MaDh)
                    .HasMaxLength(30)
                    .IsUnicode(false)
                    .HasColumnName("MaDH");

                entity.Property(e => e.KhuVuc).HasMaxLength(150);

                entity.Property(e => e.MaDt)
                    .HasMaxLength(30)
                    .IsUnicode(false)
                    .HasColumnName("MaDT");

                entity.Property(e => e.MaKh)
                    .HasMaxLength(30)
                    .IsUnicode(false)
                    .HasColumnName("MaKH");

                entity.Property(e => e.MaTx)
                    .HasMaxLength(30)
                    .IsUnicode(false)
                    .HasColumnName("MaTX");

                entity.Property(e => e.NgayLapHoaDon).HasColumnType("date");

                entity.Property(e => e.TinhTrang).HasMaxLength(150);

                entity.HasOne(d => d.MaDtNavigation)
                    .WithMany(p => p.Donhangs)
                    .HasForeignKey(d => d.MaDt)
                    .HasConstraintName("FK_DONHANG_DOITAC");

                entity.HasOne(d => d.MaKhNavigation)
                    .WithMany(p => p.Donhangs)
                    .HasForeignKey(d => d.MaKh)
                    .HasConstraintName("FK_DONHANG_KHACHHANG");

                entity.HasOne(d => d.MaTxNavigation)
                    .WithMany(p => p.Donhangs)
                    .HasForeignKey(d => d.MaTx)
                    .HasConstraintName("FK_DONHANG_TAIXE");
            });

            modelBuilder.Entity<Hopdong>(entity =>
            {
                entity.HasKey(e => e.MaHd)
                    .HasName("PK__HOPDONG__2725A6E02DF9FAA3");

                entity.ToTable("HOPDONG");

                entity.Property(e => e.MaHd)
                    .HasMaxLength(30)
                    .IsUnicode(false)
                    .HasColumnName("MaHD");

                entity.Property(e => e.MaCn)
                    .HasMaxLength(30)
                    .IsUnicode(false)
                    .HasColumnName("MaCN");

                entity.Property(e => e.NgayHetHan).HasColumnType("date");

                entity.Property(e => e.NgayLap).HasColumnType("date");

                entity.HasOne(d => d.MaCnNavigation)
                    .WithMany(p => p.Hopdongs)
                    .HasForeignKey(d => d.MaCn)
                    .HasConstraintName("FK_HOPDONG_CHINHANH");
            });

            modelBuilder.Entity<Khachhang>(entity =>
            {
                entity.HasKey(e => e.MaKh)
                    .HasName("PK__KHACHHAN__2725CF1E77B3D240");

                entity.ToTable("KHACHHANG");

                entity.Property(e => e.MaKh)
                    .HasMaxLength(30)
                    .IsUnicode(false)
                    .HasColumnName("MaKH");

                entity.Property(e => e.DiaChi).HasMaxLength(150);

                entity.Property(e => e.Email)
                    .HasMaxLength(150)
                    .HasColumnName("email");

                entity.Property(e => e.HoTen).HasMaxLength(150);

                entity.Property(e => e.Sdt)
                    .HasMaxLength(15)
                    .IsUnicode(false)
                    .HasColumnName("SDT")
                    .IsFixedLength(true);
            });

            modelBuilder.Entity<Sanpham>(entity =>
            {
                entity.HasKey(e => e.MaSp)
                    .HasName("PK__SANPHAM__2725081C0BD952ED");

                entity.ToTable("SANPHAM");

                entity.Property(e => e.MaSp)
                    .HasMaxLength(30)
                    .IsUnicode(false)
                    .HasColumnName("MaSP");

                entity.Property(e => e.MaCn)
                    .HasMaxLength(30)
                    .IsUnicode(false)
                    .HasColumnName("MaCN");

                entity.Property(e => e.PhanLoai).HasMaxLength(150);

                entity.HasOne(d => d.MaCnNavigation)
                    .WithMany(p => p.Sanphams)
                    .HasForeignKey(d => d.MaCn)
                    .HasConstraintName("FK_SANPHAM_CHINHANH");
            });

            modelBuilder.Entity<Taixe>(entity =>
            {
                entity.HasKey(e => e.MaTx)
                    .HasName("PK__TAIXE__2725004552E3007C");

                entity.ToTable("TAIXE");

                entity.HasIndex(e => e.Cmnd, "UQ__TAIXE__F67C8D0B42A2B01C")
                    .IsUnique();

                entity.Property(e => e.MaTx)
                    .HasMaxLength(30)
                    .IsUnicode(false)
                    .HasColumnName("MaTX");

                entity.Property(e => e.BienSoXe)
                    .HasMaxLength(15)
                    .IsUnicode(false)
                    .IsFixedLength(true);

                entity.Property(e => e.Cmnd)
                    .HasMaxLength(15)
                    .IsUnicode(false)
                    .HasColumnName("CMND")
                    .IsFixedLength(true);

                entity.Property(e => e.DiaChi).HasMaxLength(150);

                entity.Property(e => e.DienThoai)
                    .HasMaxLength(15)
                    .IsUnicode(false)
                    .IsFixedLength(true);

                entity.Property(e => e.Email)
                    .HasMaxLength(150)
                    .HasColumnName("email");

                entity.Property(e => e.HoTen).HasMaxLength(150);

                entity.Property(e => e.KvhoatDong)
                    .HasMaxLength(150)
                    .HasColumnName("KVHoatDong");

                entity.Property(e => e.Stk)
                    .HasMaxLength(15)
                    .IsUnicode(false)
                    .HasColumnName("STK")
                    .IsFixedLength(true);

                entity.Property(e => e.TenNganHang).HasMaxLength(150);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
