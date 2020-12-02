# frozen_string_literal: true

require  'sinatra'
require  'sinatra/reloader'
require  'json'
require  'pg'

before do
  begin
      @memos = []
      con = PG.connect dbname: 'message_note', user: 'noteuser'
      rs = con.exec 'SELECT * FROM memos ORDER BY id ASC;'
      rs.each do |r|
        @memos << { id: r['id'], title: r['title'], content: r['content'] }
      end
  rescue PG::Error => e
    puts e.message
  ensure
    rs&.clear
    con&.close
    end
end

get '/' do
  @title = 'メモアプリ'
  erb :index
end

get '/add' do
  @title = 'メモ追加'
  erb :add
end

post '/add' do
  begin
    con = PG.connect dbname: 'message_note', user: 'noteuser'
    rs =  con.exec "INSERT INTO memos(title,content) VALUES('#{params[:title]}','#{params[:content]}')"
  rescue PG::Error => e
    puts e.message
  ensure
    rs&.clear
    con&.close
  end
  redirect '/'
end

get '/show/:id' do
  @title = "メモ#{params[:id]}"
  @memo_id = params[:id].to_i  # 1
  erb :show
end

get '/edit/:id' do
  @title = 'メモ編集'
  erb :edit
end

patch '/edit/patch/:id' do
  begin
    con = PG.connect dbname: 'message_note', user: 'noteuser'
    rs =  con.exec "UPDATE memos SET title = '#{params[:title]}', content = '#{params[:content]}' \
                    WHERE id = #{params[:id]}"
  rescue PG::Error => e
    puts e.message
  ensure
    rs&.clear
    con&.close
  end
  redirect '/'
end

delete '/delete/:id' do
  begin
    con = PG.connect dbname: 'message_note', user: 'noteuser'
    rs =  con.exec "DELETE FROM memos WHERE id = #{params[:id]}"
  rescue PG::Error => e
    puts e.message
  ensure
    rs&.clear
    con&.close
  end
  redirect '/'
end
