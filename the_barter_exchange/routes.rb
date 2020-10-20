require "sinatra"
require "sinatra/reloader"
require "httparty"
require 'json'
require 'pry'
require 'pg'
require_relative "db/data_access.rb"
enable :sessions
also_reload 'db/data_access'


def logged_in? ()
  if session[:user_id]
    true 
  else 
    false
  end
end

#  can only use this if logged in
def current_user()
  find_user_by_id(session[:user_id])
end


# welcome page // ask for login
get '/' do
  erb :index, :layout => false
end

# redirect to login
get '/login' do
  erb :login
end

# retrieve amd verify user login
post '/login' do
end

# user profile page
post '/profile/:id' do
  trader = find_user_by_id(params['id'])
  erb :profile, locals: {trader: trader}
end

# post '/profile' do
#   erb :profile
# end

# newsfeed
get '/newsfeed' do
  products = all_products()
  erb :newsfeed, locals: {products: products}
end

get '/items' do
  
  erb :items
end

get '/items/:id' do
  items = find_product_by_id(params['id'])

  erb :items, locals: {items: items}
end


get '/wishlist' do
  erb :wishlist
end

post '/wishlist/add' do
  redirect "/"
end

post '/product/add' do
  redirect "/"
end