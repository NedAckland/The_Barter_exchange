def run_sql(sql, params = [])
    db = PG.connect(dbname: 'the_barter_exchange')
    results = db.exec_params(sql, params)
    db.close
    return results
end

def find_user_by_name(name)
    results = run_sql("select * from users where name = '#{name}';")
    return results[0]
end

def find_user_by_email(email)
    results = run_sql("select * from users where email = '#{email}';")
    return results[0]
end


def find_user_by_id(id)
    results = run_sql("select * from users where id = $1;", [id])
    return results[0]
end

def find_item_by_id(id)
    results = run_sql("select * from items where id = $1;", [id])
    return results[0]
end
def find_item_by_user_id(id)
    results = run_sql("select * from items where user_id = $1;", [id])
    return results
end

def all_items()
    run_sql("select * from items;")    
end

