require 'google_books'

class BooksController < ApplicationController
  
  def index
    if params[:filter] == nil
      params[:filter] = 'all'
    end
    @book = Book.new
    @books = Book.find_using_filter params[:filter]
    render 'index'
  end
  
  def google_book_search
    googleBooks = GoogleBooks::API.search params[:search]
    if googleBooks.total_results > 0
      googleBook = googleBooks.first
      book = Book.new(:title => googleBook.title, 
        :author => googleBook.authors.join('; '), 
        :year => googleBook.published_date[0, 4],
        :cover => googleBook.covers[:small])
      render :inline => book.to_json
    else 
      render :inline => '{}'
    end
  end
  
  def edit
    @book = Book.find_by_id params[:id]
    if @book
      @books = Book.all
      render "index"
    else
      redirect_to books_path, :notice => "Error, invalid parameter"
    end
  end
  
  def create
    book = Book.new params[:book]
    if book.valid? and book.save
      redirect_to books_path, :notice => "The book you created was saved"
    else
      prepareForRender book, "Please ensure your fields are complete"
      render "index"
    end
  end
  
  def destroy
    book = Book.find_by_id params[:id]
    if book
      Book.destroy params[:id]
      redirect_to books_path, :notice => "The book has been deleted"
    else
      redirect_to books_path, :notice => "Error, invalid parameter"
    end
  end
  
  def update
    book = Book.find params[:id]
    if book.update_attributes params[:book]
      redirect_to books_path, :notice => "Your book was updated"
    else
      prepareForRender book, "There was an error updating your book"
      render "index"
    end
  end
  
  def prepareForRender book, notice
    @book = book
    @books = Book.all
    flash[:notice] = notice
  end
end
