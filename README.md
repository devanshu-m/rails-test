# Rails Bookshelf

This is a rails bookshelf application. Two approaches are implemented in this project:

## Design for Rails Bookshelf on the master branch

* Guest users can view all books and books' details. They can also choose to view books by a specific author by selecting an author from the drop down menu on the books index page.
* Authenticated authors can also view all books and books' details. Along with this, they can create new books. Books created by an author belong to that author.
* Updating or deleting rights for any book belong only to the author who created the book, i.e., book can only be updated or deleted by the owner of the book.
* Authors can choose to provide citation details for the books they create.
* One-to-many approach has been implemented on the master branch, i.e., one author can create many books; and a book can belong to one author.

## Design for Rails Bookshelf on the many-to-many-association branch

* Guest users can view all books and books' details. They can also choose to view books by a specific author by selecting an author from the drop down menu on the books index page.
* Authenticated authors can also view all books and books' details. Along with this, they can create new books. While creating new books, authors will need to choose themselves and all registered co-authors. Multiple authors can be selected for a book from the 'Author(s)' option by holding the command(⌘) key on mac or the control key on windows.
* Updating or deleting rights for any book belong to the authors who wrote (own) the book, i.e., book can only be updated or deleted by the authors selected when book was created.
* Authors can choose to provide citation details for the books they create.
* Many-to-many approach has been implemented on the many-to-many-association branch, i.e., an author can create many books; and a book can belong to many authors.
* [Branch:](https://github.com/devanshu-m/rails-test/tree/many-to-many-association)

# Travis build status image

[![Build Status](https://travis-ci.org/devanshu-m/rails-app.svg?branch=master)](https://travis-ci.org/devanshu-m/rails-app)