# frozen_string_literal: true

# require 'pg'

# begin

#     con = PG.connect :dbname => 'cars', :user => 'postgres'

#     con.exec "DROP TABLE IF EXISTS Cars"
#     con.exec "CREATE TABLE Cars(Id INTEGER PRIMARY KEY,
#         Name VARCHAR(20), Price INT)"
#     con.exec "INSERT INTO Cars VALUES(1,'Audi',52642)"
#     con.exec "INSERT INTO Cars VALUES(2,'Mercedes',57127)"
#     con.exec "INSERT INTO Cars VALUES(3,'Skoda',9000)"
#     con.exec "INSERT INTO Cars VALUES(4,'Volvo',29000)"
#     con.exec "INSERT INTO Cars VALUES(5,'Bentley',350000)"
#     con.exec "INSERT INTO Cars VALUES(6,'Citroen',21000)"
#     con.exec "INSERT INTO Cars VALUES(7,'Hummer',41400)"
#     con.exec "INSERT INTO Cars VALUES(8,'Volkswagen',21600)"

# rescue PG::Error => e

#     puts e.message

# ensure

#     con.close if con

# end

require 'pg'

begin
  con = PG.connect dbname: 'message_note', user: 'noteuser'

  rs = con.exec 'SELECT * FROM memos'
  @memos = rs
  #  p @memos
  p @memos[0]['title']

  @memos.each do |memo|
    p memo['title']
  end

# p rs[0]['title']
# p rs[2]['title']
# rs.each do |row|
#   puts "%s %s %s" % [ row['id'], row['name'], row['price'] ]
# end
rescue PG::Error => e
# puts e.message
ensure
  rs&.clear
  con&.close
end
