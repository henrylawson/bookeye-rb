require 'google_books'

class BooksController < ApplicationController
  before_filter :prepare
  
  def index
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
    else 
      book = Object.new
    end  
    render :json => book
  end
  
  def edit
    @book = Book.find_by_id params[:id]
    if @book
      render "index"
    else
      redirect_to books_path, :notice => "Error, invalid parameter"
    end
  end
  
  def create
    newBook = Book.new params[:book]
    if newBook.valid? and newBook.save
      redirect_to books_path, :notice => "The book you created was saved"
    else
      set_book_and_flash_and_render_index newBook, "Please ensure your fields are complete"
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
    updateBook = Book.find params[:id]
    if updateBook.update_attributes params[:book]
      redirect_to books_path, :notice => "Your book was updated"
    else
      set_book_and_flash_and_render_index updateBook, "There was an error updating your book"
    end
  end
  
  protected
    def prepare
      @book = Book.new
      if params[:filter] == nil
        params[:filter] = 'all'
      end
      @books = Book.find_using_filter params[:filter]
    end
    
    def set_book_and_flash_and_render_index book, flashNotice
      @book = book
      flash[:notice] = flashNotice
      render "index"
    end
end
