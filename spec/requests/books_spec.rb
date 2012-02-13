require 'spec_helper.rb'

describe "Books" do
  context "when the home screen is viewed" do
    it "should display book editor title" do
      visit books_path
      page.should have_content 'Editor'
    end
    
    it "should not display books" do
      visit books_path
      page.should have_content 'No books to display'
    end
  end
  
  context "when a user accessess index" do
    before(:all) do
      @book = Book.new(
        :title => "REST in Practice: Hypermedia and Systems Architecture",
        :author => "Savas Parastatidis", 
        :year => "2010", 
        :cover => "http://google.com/bookcover.jpg",
        :hasRead => false, 
        :hasCopy => false, 
        :hasEbook => false)
    end
    
    context "and does an add with valid data" do
      before(:each) do
        visit books_path
        fill_in 'Title', :with => @book.title
        fill_in 'Author', :with => @book.author
        fill_in 'Year', :with => @book.year
        fill_in 'Cover', :with => @book.cover
        click_button 'Save Book'
      end
  
      it "should add new book" do
        page.should have_content "REST in Practice: Hypermedia and Systems Architecture"
        current_path.should == books_path
        page.should have_content @book.title
        page.should have_content @book.author
        page.should have_content @book.year
      end

      it "should be able to edit added book" do
        click_link 'Edit'
        find_field('Title').value.should == @book.title
        fill_in 'Title', :with => 'updated book title'
        click_button 'Save Book'
        current_path.should == books_path
        page.should have_content 'updated book title'
        page.should have_content "Your book was updated"
      end

      it "should be able to delete added book" do
        click_link 'Edit'
        page.should have_content @book.title
        click_link 'Delete'
        page.should_not have_content @book.title
        page.should have_content "The book has been deleted"
      end
    end
    
    context "and does an add with invalid data" do
      before(:each) do
        visit books_path
        fill_in 'Title', :with => @book.title
        fill_in 'Author', :with => @book.author
        fill_in 'Year', :with => @book.year
        fill_in 'Cover', :with => @book.cover
      end

      it "should not allow blank title" do
        fill_in 'Title', :with => ""
        click_button 'Save Book'
        page.should have_content "Please ensure your fields are complete"
      end

      it "should not allow blank author" do
        fill_in 'Author', :with => ""
        click_button 'Save Book'
        page.should have_content "Please ensure your fields are complete"
      end

      it "should not allow blank year" do
        fill_in 'Year', :with => ""
        click_button 'Save Book'
        page.should have_content "Please ensure your fields are complete"
      end

      it "should not allow characters in year" do
        fill_in 'Year', :with => "sdf"
        click_button 'Save Book'
        page.should have_content "Please ensure your fields are complete"
      end

      it "should not allow balnk cover" do
        fill_in 'Cover', :with => ""
        click_button 'Save Book'
        page.should have_content "Please ensure your fields are complete"
      end
    end
    
    context "and does an edit with invalid data" do
       before(:each) do
         visit books_path
         fill_in 'Title', :with => @book.title
         fill_in 'Author', :with => @book.author
         fill_in 'Year', :with => @book.year
         fill_in 'Cover', :with => @book.cover
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
     
     context "and trys to search" do 
       it "should be able to enter search" do
         visit books_path
         searchFieldName = 'Search'
         searchTerm = 'My awesome book'
         fill_in searchFieldName, :with => searchTerm
         find_field(searchFieldName).value.should == searchTerm
       end
     end
  end
end