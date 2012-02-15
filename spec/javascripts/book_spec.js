describe("GoogleBookSearch wih MockAjax", function() {
	
	var mockAjaxEngine = function(requestUrl, loadBookFunction) {
		var bookStub = new Object();
		bookStub.title = 'awesome book';
		bookStub.author = 'awesome author';
		bookStub.year = '2009'
		bookStub.cover = 'cover';
		loadBookFunction(bookStub);
	}
	
	beforeEach(function() {
		loadFixtures("book_edit_form.html");
		var bookSearch = new GoogleBookSearch(mockAjaxEngine);
		$('#Search').val("Awesome book");
		$('#pullButton').trigger('click');
	});
	
	it("should have title set after call", function() {
		expect($("#book_title").val()).toEqual("awesome book");
	});
	
	it("should have author set after call", function() {
		expect($("#book_author").val()).toEqual("awesome author");
	});
	
	it("should have year set after call", function() {
		expect($("#book_year").val()).toEqual("2009");
	});
	
	it("should have cover set after call", function() {
		expect($("#book_cover").val()).toEqual("cover");
	});
});