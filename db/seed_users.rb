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
  
def insert_item (name, email, password)
    sql = "insert into users (name, email, password) values ('#{name}', '#{email}', '#{password}');"
    run_sql(sql)
    # p sql
end

users = string.split()

users.size.times do |i|
    insert_item( users[i], "#{users[i]}@gmail.com", "password")
end