require 'spec_helper'

describe BooksController do
  let(:book) { mock_model(Book).as_null_object }
  
  describe "GET index" do
    before(:each) do 
      Book.stub(:new).and_return(book)
    end
    
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
    
    it "should get wish list books" do
      Book.should_receive(:find_using_filter).
        with('wish_list').
        and_return([:book])
      get :index, :filter => :wish_list
    end
    
    it "should get to read books" do
      Book.should_receive(:find_using_filter).
        with('to_read').
        and_return([:book])
      get :index, :filter => :to_read
    end
    
    it "should get own books" do
      Book.should_receive(:find_using_filter).
        with('owned').
        and_return([:book])
      get :index, :filter => :owned
    end
    
    it "should get read books" do
      Book.should_receive(:find_using_filter).
        with('read').
        and_return([:book])
      get :index, :filter => :read
    end
  end
  
  describe "POST create" do
    context "receives no book and" do
      it "should get all books" do
        Book.should_receive(:all).and_return([:book])
        post :create
      end
  
      it "should set correct flash notice" do
        post :create
        flash[:notice].should eq("Please ensure your fields are complete")
      end
      
      it "should render correct template" do
        post :create
        response.should render_template("index")
      end
    end
    
    context "receives a book that" do
      context "can not be saved" do
        before(:each) do
            book.stub(:valid?).and_return(false)
            post :create
        end
        
        it "should have correct flash notice" do
          flash[:notice].should eq("Please ensure your fields are complete")
        end
        
        it "should render correct template" do
          response.should render_template("index")
        end
      end
      
      context "can be saved" do
        before(:each) do
          Book.stub(:new).and_return(book)
          book.stub(:valid?).and_return(true)
          book.stub(:save).and_return(true)
          post :create
        end
        
        it "should have correct flash notice" do
          flash[:notice].should eq("The book you created was saved")
        end
        
        it "should have correct redirect" do
          response.should redirect_to(:action => 'index')
        end
      end
    end
  end
  
  describe "POST edit" do
    context "receives correct id" do
      it "should get all books" do
        Book.should_receive(:find_by_id).and_return(:book)
        Book.should_receive(:all).and_return([:book])
        post :edit
      end

      it "should render template" do
        id = 99
        Book.should_receive(:find_by_id).
          with(id.to_s).
          and_return(:book)
        post :edit, :id => id
        response.should render_template("index")
      end
     end
    
    context "receives incorrect id" do
      before(:each) do 
        post :edit, :id => 99
      end
      
      it "should set correct flash ntoice" do
        flash[:notice].should eq("Error, invalid parameter")
      end
      
      it "should do correct redirect" do
        response.should redirect_to(:action => 'index')
      end
    end
  end
  
  describe "DELETE destroy" do
    context "receives correct it" do
      before(:each) do
        Book.should_receive(:destroy)
        Book.should_receive(:find_by_id).and_return(:book)
        delete :destroy, :id => 1
      end
      
      it "should set correct flash message" do
        flash[:notice].should eq("The book has been deleted")
      end
      
      it "should do correct redirect" do
        response.should redirect_to(:action => 'index')
      end
    end
    
    context "receives incorrect it" do
      before(:each) do
        delete :destroy, :id => 1
      end
      
      it "should set correct flash message" do
        flash[:notice].should eq("Error, invalid parameter")
      end
      
      it "should do correct redirect" do
        response.should redirect_to(:action => 'index')
      end
    end
  end
  
  describe "PUT update" do
    context "receives correct book" do
      before(:each) do
        book.stub(:update_attributes).and_return(true)
        Book.should_receive(:find).and_return(book)
        put :update, :id => 99
      end
      
      it "should set correct flash message" do 
        flash[:notice].should eq("Your book was updated")
      end
      
      it "should do correct redirect" do
        response.should redirect_to(:action => 'index')
      end
    end
    
    context "receives invalid book" do
      before(:each) do
        book.stub(:update_attributes).and_return(false)
        Book.should_receive(:find).and_return(book)
      end
      
      it "should get all books" do
        Book.should_receive(:all).and_return([:book])
        put :update
      end
    
      it "should set flash message" do
        put :update
        flash[:notice].should eq("There was an error updating your book")
      end
      
      it "should render correct template" do
        put :update
        response.should render_template('index')
      end
    end
  end
end
