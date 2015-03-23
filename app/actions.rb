# Homepage (Root path)
get '/' do
  @message = params[:message]
  @users = User.all
  @current_user = request.cookies["username"]
  erb :index
end

get '/login' do
  erb :login
end

post '/login' do
  params[:username]
  params[:password]

  users = User.where(username: params[:username]).where(password: params[:password])
  if users.count > 0
    user = users[0]
    response.set_cookie("username", :value => params[:username], :path => "/", :expires => Time.now + 60*60*24*365*3)
    redirect '/'
  else
    # login failed
    redirect '/?message=Failed'
  end
end

get '/signup' do
  erb :signup
end

post '/signup' do
    User.create(username: params[:username], password: params[:password])
    redirect '/'
end

get '/logout' do
    
    response.set_cookie("username", :value => '', :path => "/", :expires => Time.now - 60*60*24*365*3)

    redirect '/'
end
