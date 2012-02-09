require 'spec_helper'

describe Book do
  before(:each) do
    @book = Book.new(
      :title => "REST in Practice: Hypermedia and Systems Architecture",
      :author => "Savas Parastatidis", 
      :year => "2010", 
      :hasRead => false, 
      :hasCopy => false, 
      :hasEbook => false)
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
