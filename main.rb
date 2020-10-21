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


post '/login' do
  user = find_user_by_email(params['email'])
  session[:user_id] = user['id']
  redirect '/profile'
end

get '/profile' do

  user = find_user_by_id(session[:user_id])
  items = all_items_by_user_id(session[:user_id])
  erb :profile, locals: {user: user, items: items}
end

# //////////////////////////---inventory---/////////////////////////////////

post '/items' do
  user = find_user_by_id(session[:user_id])
  user.to_a.to_s
  run_sql("insert into items (name, user_id) values ('#{params['item']}', '#{session[:user_id]}');")
  redirect "/profile"
end

get '/items' do
  erb :items
end

get '/items/:id' do
  items = find_item_by_id(params['id'])
  erb :items, locals: {items: items}
end


get '/newsfeed' do
  items = all_items()
  erb :newsfeed, locals: {items: items}
end



