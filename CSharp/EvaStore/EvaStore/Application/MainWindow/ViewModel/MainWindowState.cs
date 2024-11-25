using EvaStore.Model;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EvaStore.Application.MainWindow.ViewModel;

public partial class MainWindowViewModel
{
    public ObservableCollection<Book> books = [
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
}
