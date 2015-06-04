Bookeye::Application.routes.draw do
  root :to => 'Books#index'
  resources :books
  match 'books/google_book_search/:search' => 'books#google_book_search'
end
