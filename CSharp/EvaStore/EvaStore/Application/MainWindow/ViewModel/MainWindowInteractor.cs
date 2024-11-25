using System;

namespace EvaStore.Application.MainWindow.ViewModel;

public partial class MainWindowViewModel
{
    internal event Action ChangeColor;

    internal void userWantsToChangeColor()
    {
        ChangeColor();
    }

    internal void userWantsToDeleteBook(int bookIndex)
    {
        books.RemoveAt(bookIndex);
    }
}
