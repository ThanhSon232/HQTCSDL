using System;
using System.Collections.Generic;

#nullable disable

namespace HQTCSDL.Demo.Models
{
    public partial class Doitac
    {
        public Doitac()
        {
            Chinhanhs = new HashSet<Chinhanh>();
            Donhangs = new HashSet<Donhang>();
        }

        public string MaDt { get; set; }
        public string TenDoiTac { get; set; }
        public string ThanhPho { get; set; }
        public string Quan { get; set; }
        public int? SoChiNhanh { get; set; }
        public int? SoLuongDon { get; set; }
        public string LoaiHangVanChuyen { get; set; }
        public string DiaChiKd { get; set; }
        public string Sdt { get; set; }
        public string Email { get; set; }
        public string MaSoThue { get; set; }

        public virtual ICollection<Chinhanh> Chinhanhs { get; set; }
        public virtual ICollection<Donhang> Donhangs { get; set; }
    }
}
