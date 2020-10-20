require 'pg'

def run_sql(sql, params = [])
    db = PG.connect(dbname: 'the_barter_exchange')
    results = db.exec_params(sql, params)
    db.close
    return results
end
  
def insert_item (item_name, image_url, user_id)
    sql = "insert into products (item_name, image_url, user_id) values ('#{item_name.join}', '#{image_url}', #{user_id});"
    run_sql(sql)
    # p sql
end



string = "pipe
Peel-off face mask
Nail polish
Exercise bands
Water bottles
Blankets
Yoga and pilates mats
Kayak accessories
Jigsaw puzzles
Kitchen and dining room furniture
Rugs
Board games Laptop skins"
wares = string.split()

wares.size.times do |i|
    insert_item( wares.sample(1), "https://loremflickr.com/320/240/?random=#{i+1}", i+1)
end