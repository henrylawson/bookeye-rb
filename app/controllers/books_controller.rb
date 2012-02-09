class BooksController < ApplicationController
  def index
    @book = Book.new
    @books = Book.all
  end
  
  def edit
    @book = Book.find params[:id]
    @books = Book.all
    render "index"
  end
  
  def create
    book = Book.new params[:book]
    if book.valid? and book.save
      redirect_to books_path, :notice => "The book you created was saved."
    else
      prepareForRender book, "The book you created could not be saved, please ensure your fields are complete."
      render "index"
    end
  end
  
  def destroy
    Book.destroy params[:id]
    redirect_to books_path, :notice => "The book has been deleted."
  end
  
  def update
    book = Book.find params[:id]
    if book.update_attributes params[:book]
      redirect_to books_path, :notice => "Your book was updated."
    else
      prepareForRender book, "There was an error updating your book."
      render "index"
    end
  end
  
  def prepareForRender book, notice
    @book = book
    @books = Book.all
    flash[:notice] ||= []
    flash[:notice] << notice
  end
end
