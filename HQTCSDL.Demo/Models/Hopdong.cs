using System;
using System.Collections.Generic;

#nullable disable

namespace HQTCSDL.Demo.Models
{
    public partial class Hopdong
    {
        public string MaHd { get; set; }
        public DateTime? NgayLap { get; set; }
        public DateTime? NgayHetHan { get; set; }
        public double? Hoahong { get; set; }
        public string MaCn { get; set; }

        public virtual Chinhanh MaCnNavigation { get; set; }
    }
}
