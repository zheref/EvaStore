using EvaStore.Application.MainWindow.ViewModel;
using Microsoft.UI.Xaml.Controls;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Microsoft.VisualStudio.TestTools.UnitTesting.AppContainer;
using System;
using System.Collections.Generic;
using System.Linq;

namespace EvaStoreTests
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void TestMethod1()
        {
            Assert.AreEqual(0, 0);
        }

        [TestMethod]
        public void TestDeleteBook()
        {
            // Dado (precondiciones)
            var sujeto = new MainWindowViewModel();
            var initialCount = sujeto.books.Count;
            var selectedIndex = 0;
            var bookToDelete = sujeto.books.ElementAt(selectedIndex);

            // Cuando (accion o evento)
            sujeto.userWantsToDeleteBook(selectedIndex);

            // Entonces (expectativas)
            Assert.AreEqual(expected: initialCount - 1, actual: sujeto.books.Count);
            Assert.IsFalse(sujeto.books.Contains(bookToDelete));
        }
    }
}
