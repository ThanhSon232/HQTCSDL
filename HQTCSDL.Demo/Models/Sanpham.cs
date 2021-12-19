using System;
using System.Collections.Generic;

#nullable disable

namespace HQTCSDL.Demo.Models
{
    public partial class Sanpham
    {
        public Sanpham()
        {
            Ctdonhangs = new HashSet<Ctdonhang>();
        }

        public string MaSp { get; set; }
        public string PhanLoai { get; set; }
        public int? Gia { get; set; }
        public string MaCn { get; set; }

        public virtual Chinhanh MaCnNavigation { get; set; }
        public virtual ICollection<Ctdonhang> Ctdonhangs { get; set; }
    }
}
