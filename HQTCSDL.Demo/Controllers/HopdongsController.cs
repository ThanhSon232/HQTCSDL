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
    public class HopdongsController : Controller
    {
        private readonly DB_QLBHContext _context;

        public HopdongsController(DB_QLBHContext context)
        {
            _context = context;
        }

        // GET: Hopdongs
        public async Task<IActionResult> Index()
        {
            var dB_QLBHContext = _context.Hopdongs.Include(h => h.MaCnNavigation);
            return View(await dB_QLBHContext.ToListAsync());
        }

        // GET: Hopdongs/Details/5
        public async Task<IActionResult> Details(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var hopdong = await _context.Hopdongs
                .Include(h => h.MaCnNavigation)
                .FirstOrDefaultAsync(m => m.MaHd == id);
            if (hopdong == null)
            {
                return NotFound();
            }

            return View(hopdong);
        }

        // GET: Hopdongs/Create
        public IActionResult Create()
        {
            ViewData["MaCn"] = new SelectList(_context.Chinhanhs, "MaCn", "MaCn");
            return View();
        }

        // POST: Hopdongs/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("MaHd,NgayLap,NgayHetHan,Hoahong,MaCn")] Hopdong hopdong)
        {
            if (ModelState.IsValid)
            {
                _context.Add(hopdong);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["MaCn"] = new SelectList(_context.Chinhanhs, "MaCn", "MaCn", hopdong.MaCn);
            return View(hopdong);
        }

        // GET: Hopdongs/Edit/5
        public async Task<IActionResult> Edit(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var hopdong = await _context.Hopdongs.FindAsync(id);
            if (hopdong == null)
            {
                return NotFound();
            }
            ViewData["MaCn"] = new SelectList(_context.Chinhanhs, "MaCn", "MaCn", hopdong.MaCn);
            return View(hopdong);
        }

        // POST: Hopdongs/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(string id, [Bind("MaHd,NgayLap,NgayHetHan,Hoahong,MaCn")] Hopdong hopdong)
        {
            if (id != hopdong.MaHd)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(hopdong);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!HopdongExists(hopdong.MaHd))
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
            ViewData["MaCn"] = new SelectList(_context.Chinhanhs, "MaCn", "MaCn", hopdong.MaCn);
            return View(hopdong);
        }

        // GET: Hopdongs/Delete/5
        public async Task<IActionResult> Delete(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var hopdong = await _context.Hopdongs
                .Include(h => h.MaCnNavigation)
                .FirstOrDefaultAsync(m => m.MaHd == id);
            if (hopdong == null)
            {
                return NotFound();
            }

            return View(hopdong);
        }

        // POST: Hopdongs/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(string id)
        {
            var hopdong = await _context.Hopdongs.FindAsync(id);
            _context.Hopdongs.Remove(hopdong);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool HopdongExists(string id)
        {
            return _context.Hopdongs.Any(e => e.MaHd == id);
        }
    }
}
