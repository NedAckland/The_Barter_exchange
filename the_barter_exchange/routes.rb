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


# user profile page
# change variables
post '/profile/:id' do
  user = find_user_by_id(params['id'])
  items = find_item_by_id(params['id'])
  erb :profile, locals: {user: user, items: items}
end

# post '/profile' do
#   erb :profile
# end

# //////////////////////////---inventory---/////////////////////////////////

# get all items from users inventory
get '/inventory' do
end

# add a new item
get '/inventory/new' do
  redirect "/inventory"
end

# add items to db
post '/inventory' do
end



# ///////////////////////////////////////////////////////////
# delete item
get '/inventory/:id' do
end

delete '/inventory:id' do
end


# ///////////////////////////////////////////////////////////
# update item
patch '/inventory/:id' do

end


# ///////////////////////////////////////////////////////////




post '/product/add' do
  redirect "/"
end

get '/items' do
  
  erb :items
end

get '/items/:id' do
  items = find_item_by_id(params['id'])

  erb :items, locals: {items: items}
end

# redirect to login
get '/login' do
  erb :login
end

# retrieve amd verify user login
post '/login' do
end


# newsfeed
get '/newsfeed' do
  items = all_items()
  erb :newsfeed, locals: {items: items}
end



get '/wishlist' do
  erb :wishlist
end

post '/wishlist/add' do
  redirect "/"
end

