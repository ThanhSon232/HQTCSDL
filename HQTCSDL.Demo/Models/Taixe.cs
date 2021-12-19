using System;
using System.Collections.Generic;

#nullable disable

namespace HQTCSDL.Demo.Models
{
    public partial class Taixe
    {
        public Taixe()
        {
            Donhangs = new HashSet<Donhang>();
        }

        public string MaTx { get; set; }
        public string HoTen { get; set; }
        public string Cmnd { get; set; }
        public string DienThoai { get; set; }
        public string DiaChi { get; set; }
        public string BienSoXe { get; set; }
        public string KvhoatDong { get; set; }
        public string Email { get; set; }
        public string Stk { get; set; }
        public string TenNganHang { get; set; }

        public virtual ICollection<Donhang> Donhangs { get; set; }
    }
}
