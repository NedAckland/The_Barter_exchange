string = "Liam
Noah
Oliver
William
Elijah
James
Benjamin
Lucas
Mason
Ethan
Alexander
Henry
Jacob
Michael
Daniel
Logan
Jackson
Sebastian
Jack
Aiden
Owen
Samuel
Matthew
Joseph
Levi
Mateo
David
John
Wyatt
Carter
Julian
Luke
Grayson
Isaac
Jayden"
require 'pg'

def run_sql(sql, params = [])
    db = PG.connect(dbname: 'the_barter_exchange')
    results = db.exec_params(sql, params)
    db.close
    return results
end
  
def insert_item (vendor_name, password)
    sql = "insert into vendors (vendor_name, password) values ('#{vendor_name.join}', '#{password}');"
    run_sql(sql)
    # p sql
end

vendors = string.split()

vendors.size.times do |i|
    insert_item( vendors.sample(1), "#{(i*1023423) * 5 / 100 }")
end