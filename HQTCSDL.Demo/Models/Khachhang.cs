using System;
using System.Collections.Generic;

#nullable disable

namespace HQTCSDL.Demo.Models
{
    public partial class Khachhang
    {
        public Khachhang()
        {
            Donhangs = new HashSet<Donhang>();
        }

        public string MaKh { get; set; }
        public string HoTen { get; set; }
        public string Sdt { get; set; }
        public string DiaChi { get; set; }
        public string Email { get; set; }

        public virtual ICollection<Donhang> Donhangs { get; set; }
    }
}
