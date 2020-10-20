def run_sql(sql, params = [])
    db = PG.connect(dbname: 'the_barter_exchange')
    results = db.exec_params(sql, params)
    db.close
    return results
end

def find_user_by_name(vendor_name)
    results = run_sql("select * from vendors where vendor_name = '#{vendor_name}';")
    return results[0]
end

def find_user_by_id(id)
    results = run_sql("select * from vendors where id = $1;", [id])
    return results[0]
end

def find_product_by_id(id)
    results = run_sql("select * from products where id = $1;", [id])
    return results[0]
end

def all_products()
    run_sql("select * from products;")    
end

