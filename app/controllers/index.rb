enable :sessions

get '/' do
  "value = " << session[:value].inspect
  # signup & #create options link to whichever
  erb :index
end

get '/signup' do

end

post '/signup' do
  user = User.create(name: params[:name], email: params[:email], password: params[:password])
  unless user.errors.any?
    redirect '/'
  else
    redirect '/bad_signup'
  end
  # if user creation successful
  #   redirect to /secret
  # else show signup error, redirect to '/'
end


post '/login' do
    authenticated_user = User.authenticate(params[:email], params[:password])
  if authenticated_user.nil?
    redirect '/bad_login'
  else
    session["email"] = authenticated_user.email
    redirect '/home'
  end
  # if user login successful
  #   redirect to /secret
  # else show signup error, redirect to '/'
end

get '/home' do
 if session['email'] == nil
  redirect '/'
end
  erb :home
end

get '/logout' do
  session['email'] = nil
  redirect '/'
end


