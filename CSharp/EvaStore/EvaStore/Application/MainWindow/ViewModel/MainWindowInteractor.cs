using System;

namespace EvaStore.Application.MainWindow.ViewModel;

public partial class MainWindowViewModel
{
    internal event Action ChangeColor;

    internal void userWantsToChangeColor()
    {
        ChangeColor();
    }

    /// <summary>
    /// Delete a book from the list
    /// </summary>
    /// <param name="bookIndex">The position of the book in the list</param>
    public void userWantsToDeleteBook(int bookIndex)
    {
        books.RemoveAt(bookIndex);
    }
}
