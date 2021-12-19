using System;
using System.Collections.Generic;

#nullable disable

namespace HQTCSDL.Demo.Models
{
    public partial class Ctdonhang
    {
        public string MaDh { get; set; }
        public string MaSp { get; set; }
        public int? SoLuong { get; set; }

        public virtual Donhang MaDhNavigation { get; set; }
        public virtual Sanpham MaSpNavigation { get; set; }
    }
}
