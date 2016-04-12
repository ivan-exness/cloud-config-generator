require 'sinatra'

get '/cloud-config' do
  erb :config, :locals => {:ip => params[:ip]}
end