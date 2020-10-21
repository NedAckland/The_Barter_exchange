require "sinatra"
require "sinatra/reloader" if development?
require "httparty"
require 'json'
require 'pry' if development?
require 'pg'
require_relative "db/data_access.rb"
enable :sessions
also_reload 'db/data_access' if development?


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
get '/items/new' do
  redirect "/profile"
end


post '/items/add' do
  redirect "/profile"
end

get '/items' do
  erb :items
end

get '/items/:id' do
  items = find_item_by_id(params['id'])

  erb :items, locals: {items: items}
end


# retrieve amd verify user login
post '/profile' do
  user = find_user_by_email(params['email'])
  # user['id']
  items = find_item_by_user_id(user['id'])
  erb :profile, locals: {user: user, items: items}
end


# newsfeed
get '/newsfeed' do
  items = all_items()
  # items[0].to_a.to_s
  erb :newsfeed, locals: {items: items}
end



