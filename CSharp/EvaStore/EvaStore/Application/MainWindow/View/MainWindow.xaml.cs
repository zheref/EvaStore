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
using System.Drawing;
using EvaStore.Application.MainWindow.ViewModel;

// To learn more about WinUI, the WinUI project structure,
// and more about our project templates, see: http://aka.ms/winui-project-info.

// SOLID
// S: Single Responsibility Princilpe

namespace EvaStore
{
    /// <summary>
    /// Controller: An empty window that can be used on its own or navigated to within a Frame.
    /// </summary>
    public sealed partial class MainWindow : Window
    {
        MainWindowViewModel model = new MainWindowViewModel();

        public MainWindow()
        {
            this.InitializeComponent();

            model.ChangeColor += () =>
            {
                myButton.Content = "Color Changed!";
                myButton.Background = new SolidColorBrush(Microsoft.UI.Colors.Red);
            };

            myButton.Content = "Change Color";
        }

        private void myButton_Click(object sender, RoutedEventArgs e)
        {
            model.userWantsToChangeColor();
        }
    }
}