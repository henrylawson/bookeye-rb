require 'spec_helper'

describe BooksController do
  let(:book) { mock_model(Book).as_null_object }
  
  before do 
    Book.stub(:new).and_return(book)
  end
  
  describe "GET index" do
    it "should get all books" do
      Book.should_receive(:all).and_return([:book])
      get :index
    end
  
    it "should render correct template" do
      get :index
      response.should render_template("index")
    end
    
    it "should provide a new book" do
      Book.should_receive(:new).and_return(:book)
      get :index
    end
  end
  
  describe "POST create" do
    it "should get all books" do
      Book.should_receive(:all).and_return([:book])
      post :create
    end
  
    it "receives no book, should set flash ntoice and render index" do
      post :create
      flash[:notice].should eq(["Please ensure your fields are complete"])
      response.should render_template("index")
    end
    
    context "receives a book and" do
      it "does not save with currect flash notice and redirect" do
        book.stub(:valid?).and_return(false)
        post :create
        flash[:notice].should eq(["Please ensure your fields are complete"])
        response.should render_template("index")
      end
      
      it "saves successfully and sets correct flash notice and redirect" do
        book.stub(:valid?).and_return(true)
        book.stub(:save).and_return(true)
        post :create
        flash[:notice].should eq("The book you created was saved")
        response.should redirect_to(:action => 'index')
      end
    end
  end
  
  describe "POST edit" do
    it "should get all books" do
      Book.should_receive(:find).and_return(:book)
      Book.should_receive(:all).and_return([:book])
      post :edit
    end
  
    it "receives correct id and returns a book" do
      id = 99
      Book.should_receive(:find).
        with(id.to_s).
        and_return(:book)
      post :edit, :id => id
      response.should render_template("index")
    end
    
    it "receives incorrect id and sets correct flash message and redirect"
  end
  
  describe "DELETE destroy" do
    it "receives correct id, destroys book and sets correct flash notice and redirect" do
      Book.should_receive(:destroy)
      delete :destroy, :id => 1
      flash[:notice].should eq("The book has been deleted")
      response.should redirect_to(:action => 'index')
    end
    
    it "receives incorrect id and sets correct flash message"
  end
  
  describe "PUT update" do
    it "receives correct book" do 
      book.stub(:update_attributes).and_return(true)
      Book.should_receive(:find).and_return(book)
      put :update, :id => 99
      flash[:notice].should eq("Your book was updated")
      response.should redirect_to(:action => 'index')
    end
    
    context "it receives invalid book" do
      it "should get all books" do
        book.stub(:update_attributes).and_return(false)
        Book.should_receive(:find).and_return(book)
        Book.should_receive(:all).and_return([:book])
        put :update
      end
    
      it "should set flash message and render" do
        book.stub(:update_attributes).and_return(false)
        Book.should_receive(:find).and_return(book)
        put :update
        flash[:notice].should eq(["There was an error updating your book"])
        response.should render_template('index')
      end
    end
  end
end
