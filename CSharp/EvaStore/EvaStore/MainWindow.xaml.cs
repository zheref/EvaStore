using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices.WindowsRuntime;
using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using Microsoft.UI.Xaml.Controls.Primitives;
using Microsoft.UI.Xaml.Data;
using Microsoft.UI.Xaml.Input;
using Microsoft.UI.Xaml.Media;
using Microsoft.UI.Xaml.Navigation;
using Windows.Foundation;
using Windows.Foundation.Collections;
using ABI.Windows.ApplicationModel.Store.Preview.InstallControl;
using EvaStore.Model;

// To learn more about WinUI, the WinUI project structure,
// and more about our project templates, see: http://aka.ms/winui-project-info.

namespace EvaStore
{
    /// <summary>
    /// An empty window that can be used on its own or navigated to within a Frame.
    /// </summary>
    public sealed partial class MainWindow : Window
    {
        private Book[] books = [
            new(
                title: "The Alchemist", 
                author: new("Paulo Coelho", "Brazilian", [Genre.Fiction, Genre.Fantasy]),
                publicationTime:DateTime.Now,
                genre: Genre.Fiction
            ),
            new(
                title: "The Great Gatsby",
                author: new("F. Scott Fitzgerald", "American", [Genre.Fiction, Genre.Fantasy]),
                publicationTime:DateTime.Now,
                genre: Genre.Fiction
            ),
            new(
                title: "The Alchemist",
                author: new("Dan Brown", "American", [Genre.Fiction, Genre.Thriller]),
                publicationTime:DateTime.Now,
                genre: Genre.Fiction
            )
        ];

        public MainWindow()
        {
            this.InitializeComponent();
        }

        private void myButton_Click(object sender, RoutedEventArgs e)
        {
            myButton.Content = "Clicked";
        }
    }
}
