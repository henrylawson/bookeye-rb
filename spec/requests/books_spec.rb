require 'spec_helper.rb'

describe "Books" do
  describe "view home screen" do
    it "display book editor" do
      visit books_path
      page.should have_content 'Editor'
    end
    
    it "should not display books" do
      visit books_path
      page.should have_content 'No books to display'
    end
  end
  
  describe "add/edit/delete operations" do
    before(:all) do
      @book = Book.new(
        :title => "REST in Practice: Hypermedia and Systems Architecture",
        :author => "Savas Parastatidis", 
        :year => "2010", 
        :hasRead => false, 
        :hasCopy => false, 
        :hasEbook => false)
    end
    
    before(:each) do
      visit books_path
      fill_in 'Title', :with => @book.title
      fill_in 'Author', :with => @book.author
      fill_in 'Year', :with => @book.year
      click_button 'Save Book'
    end
  
    it "should add new book" do
      page.should have_content "REST in Practice: Hypermedia and Systems Architecture"
      current_path.should == books_path
      page.should have_content @book.title
      page.should have_content @book.author
      page.should have_content @book.year
    end
    
    it "should edit added book" do
      click_link 'Edit'
      find_field('Title').value.should == @book.title
      fill_in 'Title', :with => 'updated book title'
      click_button 'Save Book'
      current_path.should == books_path
      page.should have_content 'updated book title'
      page.should have_content "Your book was updated"
    end
    
    it "should delete added book" do
      click_link 'Edit'
      page.should have_content @book.title
      click_link 'Delete'
      page.should_not have_content @book.title
      page.should have_content "The book has been deleted"
    end
  end
  
  describe "attempt invalid add operations" do
    
    before(:each) do
      @title = "The best book ever"
      @author = "Henry Lawson"
      @year = "2007"
    end
    
    it "should not allow blank title" do
      visit books_path
      fill_in 'Title', :with => ""
      fill_in 'Author', :with => @author
      fill_in 'Year', :with => @year
      click_button 'Save Book'
      page.should have_content "Please ensure your fields are complete"
      find_field('Title').value.should == ""
      find_field('Author').value.should == @author
      find_field('Year').value.should == @year
    end
    
    it "should not allow blank author" do
      visit books_path
      fill_in 'Title', :with => @title
      fill_in 'Author', :with => ""
      fill_in 'Year', :with => @year
      click_button 'Save Book'
      page.should have_content "Please ensure your fields are complete"
      find_field('Title').value.should == @title
      find_field('Author').value.should == ""
      find_field('Year').value.should == @year
    end
    
    it "should not allow blank year" do
      visit books_path
      fill_in 'Title', :with => @title
      fill_in 'Author', :with => @author
      fill_in 'Year', :with => ""
      click_button 'Save Book'
      page.should have_content "Please ensure your fields are complete"
      find_field('Title').value.should == @title
      find_field('Author').value.should == @author
      find_field('Year').value.should == ""
    end
    
    it "should not allow characters in year" do
      visit books_path
      fill_in 'Title', :with => @title
      fill_in 'Author', :with => @author
      fill_in 'Year', :with => "sdf"
      click_button 'Save Book'
      page.should have_content "Please ensure your fields are complete"
      find_field('Title').value.should == @title
      find_field('Author').value.should == @author
      find_field('Year').value.should == "sdf"
    end
  end
  
  describe "attempt invalid edit operations" do
    
    before(:each) do
      @title = "The best book ever"
      @author = "Henry Lawson"
      @year = "2007"
      visit books_path
      fill_in 'Title', :with => @title
      fill_in 'Author', :with => @author
      fill_in 'Year', :with => @year
      click_button 'Save Book'
      click_link 'Edit'
    end
    
    it "should not allow blank title" do
      fill_in 'Title', :with => ''
      click_button 'Save Book'
      page.should have_content "There was an error updating your book"
    end
    
    it "should not allow blank author" do
      fill_in 'Author', :with => ''
      click_button 'Save Book'
      page.should have_content "There was an error updating your book"
    end
    
    it "should not allow blank year" do
      fill_in 'Year', :with => ''
      click_button 'Save Book'
      page.should have_content "There was an error updating your book"
    end
    
    it "should not allow characters in year" do
      fill_in 'Year', :with => 'sdf'
      click_button 'Save Book'
      
      page.should have_content "There was an error updating your book"
    end
  end
end