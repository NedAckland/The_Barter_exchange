require "sinatra"
require "sinatra/reloader" if development?
require "httparty"
require 'json'
require 'pry' if development?
require 'pg'
require 'bcrypt'

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

def user_by_id(id)
  find_user_by_id(id)
end

# welcome page // ask for login
get '/' do
  erb :index, :layout => false
end

# send login details to db
post '/login' do
  user = find_user_by_email(params['email'])
  if BCrypt::Password.new(user['password']).== params['password']
    session[:user_id] = user['id']
    redirect "/profile"
  else
    "not good bro"
  end

end

# go to users profile
get '/profile' do
  user = find_user_by_id(session[:user_id])
  items = all_items_by_user_id(session[:user_id])
  wishlist = wishlist_items_by_user_id(session[:user_id])
  # trade_offers = trade_items_by_reciever_id(session[:user_id])
  # trade_offers.to_a.to_s
  erb :profile, locals: {user: user, items: items, wishlist: wishlist, trade_offers: trade_offers}

end

# visit others profile
get '/profile/:id' do
  user = find_user_by_id(params["id"])
  items = all_items_by_user_id(params["id"])
  wishlist = wishlist_items_by_user_id(params["id"])
  # trade_offers = trade_items_by_reciever_id(params["id"])
  erb :profile, locals: {user: user, items: items, wishlist: wishlist, trade_offers: trade_offers}
end


# //////////////////////////---inventory---/////////////////////////////////


delete '/items/:id' do
  id = params["id"]
  run_sql("DELETE FROM items WHERE id = $1;", [id])
  redirect '/profile'
end

post '/items' do
  user = find_user_by_id(session[:user_id])
  unless params['item'] == ''
    run_sql("insert into items (name, user_id) values ('#{params['item']}', '#{session[:user_id]}');")
  end
  redirect "/items"
end

get '/items' do
  user = find_user_by_id(session[:user_id])
  items = all_items_by_user_id(session[:user_id])
  erb :items, locals: {user: user, items: items}
  # erb :items
end

get '/items/:id' do
  items = find_item_by_id(params['id'])
  erb :items, locals: {items: items}
end
# ////////////////////////////---Item Info---////////////////////////////////////

get '/item_info/:id' do
  item = find_item_by_id(params['id'])
  user = find_user_by_id(item['user_id'])
  erb :item_info, locals: {item: item, user: user}
end

post '/item_info/:id' do
  run_sql("update items set description = '#{params['paragraph_text']}' where id = #{params['id']};")
  redirect "/item_info/#{params['id']}"
end

post '/item_name/:id' do
  run_sql("update items set name = '#{params['name']}' where id = #{params['id']};")
  redirect "/item_info/#{params['id']}"
end


# ///////////////////////////---NewsFeed---////////////////////////////////
#  get all users and match the id with items user_id then display in newsfeed

get '/newsfeed' do
  items = all_items()
  erb :newsfeed, locals: {items: items}
end



# /////////////////////////////////---logout ---////////////////////////////////

delete '/logout' do
  session["user_id"] = nil
  redirect "/"
end
# /////////////////////////////////--wishlist---/////////////////////////////////
get '/wishlist' do
  user = find_user_by_id(session[:user_id])
  items = wishlist_items_by_user_id(session[:user_id])
  erb :wishlist, locals: {user: user, items: items}
end


post '/wishlist' do
  user = find_user_by_id(session[:user_id])

  run_sql("insert into wishlist (name, user_id) values ('#{params['wishlist_item']}', '#{session[:user_id]}');")
  redirect "/wishlist"
end


delete '/wishlist/:id' do

  id = params["id"]
  # raise id
  run_sql("DELETE FROM wishlist WHERE id = $1;", [id])
  redirect '/wishlist'
end
# //////////////////////////////////---Sign Up---/////////////////////////////


post '/signup' do
  password_digest = BCrypt::Password.create(params["password"])
  run_sql("INSERT INTO users (name, email, password) VALUES ('#{params["name"]}','#{params["email"]}', '#{password_digest}');")
  user = find_user_by_email(params['email'])
  session[:user_id] = user['id']
  redirect "/profile"
end
# /////////////////////////////////---Trading---///////////////////////////////////////

# trade page // this is to send offers


# to confirm offers
post '/offer_trade/:id' do
  item = find_item_by_id(params['id'])
  user = find_user_by_id(item['user_id'])
  # tem offered with trade
  "INSERT INTO trade_offers (name, item_id, reciever_id, sender_id, offered_item_id) VALUES('#{item['name']}','#{params['id']}','#{user['id']}', #{current_user()['id']}, 'currently not implemented');"

  # item.to_a.to_s
  # redirect '/profile'
end


# to accept offers
# fix sql statement
post '/accept_trade/:id' do
  run_sql("delete from trade_offers where item_id = #{params['id']};")
  
  # run_sql("update items set user_id = #{params['new_owner']} where user_id = #{params['id']};")
  # "you have accepted a trade"
  redirect '/profile'
end



get '/test' do
  erb :test
end