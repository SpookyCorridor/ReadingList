require 'test_helper'

class ListingBooksTest < ActionDispatch::IntegrationTest
	setup do 
		#create! raise an error if it doesn't work 
    @scifi = Genre.create!(name: 'Science Fiction')

		@scifi.books.create!(title: "Ender's game", rating: 4)
    @scifi.books.create!(title: 'Star Trek', rating: 5)
	end 
	
  test 'listing books' do 
  	get '/books'

  	assert_equal 200, response.status
  	assert_equal Mime::JSON, response.content_type 

    #byebug 
    #can use :books symbol because we're using symbolize 
    books = json(response.body)[:books]
  	assert_equal Book.count, books.size 
    book = Book.find(books.first[:id])

    # using the defined model relationship 
    assert_equal @scifi.id, book.genre.id 
  	#parse returns an array, calling size on it 
  end 

  test 'lists top rated books' do 
    get '/books?rating=5'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    assert_equal 1, json(response.body)[:books].size
  end 
end
