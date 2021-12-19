using System;
using System.Collections.Generic;

#nullable disable

namespace HQTCSDL.Demo.Models
{
    public partial class Donhang
    {
        public Donhang()
        {
            Ctdonhangs = new HashSet<Ctdonhang>();
        }

        public string MaDh { get; set; }
        public int? PhiSanPham { get; set; }
        public int? PhiVanChuyen { get; set; }
        public DateTime? NgayLapHoaDon { get; set; }
        public int? Tong { get; set; }
        public string TinhTrang { get; set; }
        public string KhuVuc { get; set; }
        public string MaKh { get; set; }
        public string MaTx { get; set; }
        public string MaDt { get; set; }

        public virtual Doitac MaDtNavigation { get; set; }
        public virtual Khachhang MaKhNavigation { get; set; }
        public virtual Taixe MaTxNavigation { get; set; }
        public virtual ICollection<Ctdonhang> Ctdonhangs { get; set; }
    }
}
