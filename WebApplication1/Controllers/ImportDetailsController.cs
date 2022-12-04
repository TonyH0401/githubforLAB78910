using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    public class ImportDetailsController : Controller
    {
        private DevConn db = new DevConn();

        // GET: ImportDetails
        public ActionResult Index1()
        {
            var importDetails = db.ImportDetails.Include(i => i.Import).Include(i => i.Product);
            return View(importDetails.ToList());
        }
        public ActionResult Index (String id)
        {
            List<ImportDetail> detail = db.ImportDetails.Where(a => a.importID == id).ToList();
            return View(detail);
        }

        // GET: ImportDetails/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ImportDetail importDetail = db.ImportDetails.Find(id);
            if (importDetail == null)
            {
                return HttpNotFound();
            }
            return View(importDetail);
        }
        public ActionResult Details(string id, String id2)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ImportDetail importDetail = db.ImportDetails.Find(id, id2);
            if (importDetail == null)
            {
                return HttpNotFound();
            }
            return View(importDetail);
        }

        // GET: ImportDetails/Create
        public ActionResult Create()
        {
            ViewBag.importID = new SelectList(db.Imports, "importID", "accountID");
            ViewBag.productID = new SelectList(db.Products, "productID", "productName");
            return View();
        }

        // POST: ImportDetails/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "importID,productID,productName,productPrice,productQuantity,productOrigin")] ImportDetail importDetail)
        {
            if (ModelState.IsValid)
            {
                db.ImportDetails.Add(importDetail);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.importID = new SelectList(db.Imports, "importID", "accountID", importDetail.importID);
            ViewBag.productID = new SelectList(db.Products, "productID", "productName", importDetail.productID);
            return View(importDetail);
        }

        // GET: ImportDetails/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ImportDetail importDetail = db.ImportDetails.Find(id);
            if (importDetail == null)
            {
                return HttpNotFound();
            }
            ViewBag.importID = new SelectList(db.Imports, "importID", "accountID", importDetail.importID);
            ViewBag.productID = new SelectList(db.Products, "productID", "productName", importDetail.productID);
            return View(importDetail);
        }

        // POST: ImportDetails/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "importID,productID,productName,productPrice,productQuantity,productOrigin")] ImportDetail importDetail)
        {
            if (ModelState.IsValid)
            {
                db.Entry(importDetail).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.importID = new SelectList(db.Imports, "importID", "accountID", importDetail.importID);
            ViewBag.productID = new SelectList(db.Products, "productID", "productName", importDetail.productID);
            return View(importDetail);
        }

        // GET: ImportDetails/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ImportDetail importDetail = db.ImportDetails.Find(id);
            if (importDetail == null)
            {
                return HttpNotFound();
            }
            return View(importDetail);
        }

        // POST: ImportDetails/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            ImportDetail importDetail = db.ImportDetails.Find(id);
            db.ImportDetails.Remove(importDetail);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
