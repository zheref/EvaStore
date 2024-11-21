using Microsoft.UI.Xaml.Controls;
using Microsoft.UI.Xaml.Media;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace EvaStore.Application.MainWindow.ViewModel;

public partial class MainWindowViewModel
{
    internal event Action ChangeColor;

    internal void userWantsToChangeColor()
    {
        ChangeColor();
    }
}
