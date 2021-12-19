using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using HQTCSDL.Demo.Models;

namespace HQTCSDL.Demo.Controllers
{
    public class TaixesController : Controller
    {
        private readonly DB_QLBHContext _context;

        public TaixesController(DB_QLBHContext context)
        {
            _context = context;
        }

        // GET: Taixes
        public async Task<IActionResult> Index()
        {
            return View(await _context.Taixes.ToListAsync());
        }

        // GET: Taixes/Details/5
        public async Task<IActionResult> Details(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var taixe = await _context.Taixes
                .FirstOrDefaultAsync(m => m.MaTx == id);
            if (taixe == null)
            {
                return NotFound();
            }

            return View(taixe);
        }

        // GET: Taixes/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Taixes/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("MaTx,HoTen,Cmnd,DienThoai,DiaChi,BienSoXe,KvhoatDong,Email,Stk,TenNganHang")] Taixe taixe)
        {
            if (ModelState.IsValid)
            {
                _context.Add(taixe);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(taixe);
        }

        // GET: Taixes/Edit/5
        public async Task<IActionResult> Edit(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var taixe = await _context.Taixes.FindAsync(id);
            if (taixe == null)
            {
                return NotFound();
            }
            return View(taixe);
        }

        // POST: Taixes/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(string id, [Bind("MaTx,HoTen,Cmnd,DienThoai,DiaChi,BienSoXe,KvhoatDong,Email,Stk,TenNganHang")] Taixe taixe)
        {
            if (id != taixe.MaTx)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(taixe);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!TaixeExists(taixe.MaTx))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            return View(taixe);
        }

        // GET: Taixes/Delete/5
        public async Task<IActionResult> Delete(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var taixe = await _context.Taixes
                .FirstOrDefaultAsync(m => m.MaTx == id);
            if (taixe == null)
            {
                return NotFound();
            }

            return View(taixe);
        }

        // POST: Taixes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(string id)
        {
            var taixe = await _context.Taixes.FindAsync(id);
            _context.Taixes.Remove(taixe);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool TaixeExists(string id)
        {
            return _context.Taixes.Any(e => e.MaTx == id);
        }
    }
}
