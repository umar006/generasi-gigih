require 'mysql2'

def create_db_client
  client = Mysql2::Client.new(
    :host => 'localhost',
    :username => 'root',
    :password => 'Sep4tus4nd4l!',
    :database => 'food_oms_db'
  )

  client
end
