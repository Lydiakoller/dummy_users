
post '/signup' do
  user = User.create(name: params[:name], email: params[:email], password: params[:password])
  unless user.errors.any?
    redirect '/'
  else
    redirect '/bad_signup'
  end
end


post '/login' do
    authenticated_user = User.authenticate(params[:email], params[:password])
  if authenticated_user.nil?
    redirect '/bad_login'
  else
    session[:user_id] = authenticated_user.id  #possibly not a symbol?
    redirect "/home/#{session[:user_id]}"
  end
end

get '/home/:id' do
  if session[:user_id] == nil
    redirect '/'
  end
  erb :home
end

post '/logout' do
  session[:user_id] = nil
  redirect '/'
end


