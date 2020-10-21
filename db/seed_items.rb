require 'pg'

def run_sql(sql, params = [])
    db = PG.connect(dbname: 'the_barter_exchange')
    results = db.exec_params(sql, params)
    db.close
    return results
end
  
def insert_item (name, user_id)
    sql = "insert into items (name, user_id) values ('#{name.join}', #{user_id});"
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
items = string.split()

items.size.times do |i|
    insert_item( items.sample(1), i+1)
end