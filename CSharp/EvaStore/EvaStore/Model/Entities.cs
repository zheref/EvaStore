#nullable enable
using System;

namespace EvaStore.Model;

enum Genre
{
    Fiction, Romance, SelfHelp,
    History, Fantasy, Thriller
}

struct Author
{
    internal string name;
    internal string nationality;
    internal DateTime? birthDate;
    internal Genre[] genres = [];

    internal Author(string name, string nationality, Genre[] genres)
    {
        this.name = name;
        this.nationality = nationality;
        this.genres = genres;
    }
}

struct Book
{
    internal string title;
    internal Uri? coverPicture;
    internal Author author;
    internal DateTime publicationTime;
    internal Genre genre;

    internal Book(string title, Author author, DateTime publicationTime,
        Genre genre)
    {
        this.title = title;
        this.author = author;
        this.publicationTime = publicationTime;
        this.genre = genre;
    }
}
#nullable disable