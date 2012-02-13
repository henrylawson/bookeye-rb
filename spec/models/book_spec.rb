require 'spec_helper'

describe Book do
  before(:each) do
    @book = Book.new(
      :title => "REST in Practice: Hypermedia and Systems Architecture",
      :author => "Savas Parastatidis", 
      :year => "2010", 
      :cover => "http://google.com/covers/awesome.jpg",
      :hasRead => false, 
      :hasCopy => false, 
      :hasEbook => false)
  end
  
  it "is valid with valid atrributes" do
    @book.should be_valid
  end
  
  it "is not valid without title" do 
    @book.title = nil
    @book.should_not be_valid
  end
  
  it "is not valid without author" do
    @book.author = nil
    @book.should_not be_valid
  end
  
  it "is not valid without year" do
    @book.year = nil
    @book.should_not be_valid
  end
  
  it "is not valid without cover" do
    @book.cover = nil
    @book.should_not be_valid
  end
  
  it "has correct title" do
    @book.title.should == "REST in Practice: Hypermedia and Systems Architecture"
  end
  
  it "has correct author" do
    @book.author.should == "Savas Parastatidis"
  end
  
  it "has correct year" do
    @book.year.should == "2010"
  end
  
  it "has correct cover" do
    @book.cover.should == "http://google.com/covers/awesome.jpg"
  end
  
  it "has correct hasRead" do
    @book.hasRead.should == false
  end
  
  it "has correct hasCopy" do
    @book.hasCopy.should == false
  end
  
  it "has correct hasEbook" do
    @book.hasEbook.should == false
  end
end
