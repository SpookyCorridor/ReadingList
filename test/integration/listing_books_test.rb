require 'test_helper'

class ListingBooksTest < ActionDispatch::IntegrationTest
	setup do 
		#create! raise an error if it doesn't work 
		Book.create!(title: 'Pragmatic Programmer', rating: 5)
		Book.create!(title: "Ender's game", rating: 5)
	end 
	
  test 'listing books' do 
  	get '/books'

  	assert_equal 200, response.status
  	assert_equal Mime::JSON, response.content_type 

  	assert_equal Book.count, JSON.parse(response.body).size 
  	#parse returns an array, calling size on it 
  end 
end
