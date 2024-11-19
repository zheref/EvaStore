#nullable enable
using System;

namespace EvaStore.Model;

enum Genre
{
    Fiction, Romance, SelfHelp,
    History, Fantasy, Thriller
}

public struct Author
{
    public string Name { get; set; }
    internal string nationality;
    internal DateTime? birthDate;
    internal Genre[] genres = [];

    internal Author(string name, string nationality, Genre[] genres)
    {
        this.Name = name;
        this.nationality = nationality;
        this.genres = genres;
    }
}

public struct Book
{
    public string Title { get; set; }
    internal Uri? coverPicture;
    public Author Author { get; set; }
    internal DateTime publicationTime;
    internal Genre genre;

    internal Book(string title, Author author, DateTime publicationTime,
        Genre genre)
    {
        this.Title = title;
        this.Author = author;
        this.publicationTime = publicationTime;
        this.genre = genre;
    }
}
#nullable disable