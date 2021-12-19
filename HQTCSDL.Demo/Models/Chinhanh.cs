using System;
using System.Collections.Generic;

#nullable disable

namespace HQTCSDL.Demo.Models
{
    public partial class Chinhanh
    {
        public Chinhanh()
        {
            Hopdongs = new HashSet<Hopdong>();
            Sanphams = new HashSet<Sanpham>();
        }

        public string MaCn { get; set; }
        public string MaDt { get; set; }
        public string DiaChi { get; set; }
        public string NguoiDaiDien { get; set; }

        public virtual Doitac MaDtNavigation { get; set; }
        public virtual ICollection<Hopdong> Hopdongs { get; set; }
        public virtual ICollection<Sanpham> Sanphams { get; set; }
    }
}
