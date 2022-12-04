using Microsoft.VisualStudio.TestTools.UnitTesting;
using Finals_Project;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace Finals_Project.Tests
{
    [TestClass()]
    public class frmLoginTests
    {
        [TestMethod()]
        public void check_DataTest()
        {
            frmLogin f = new frmLogin();
            int expected = 3;
            int act = f.check_Data(1, 2);
            
            Assert.AreEqual(expected, act);
        }
    }
}