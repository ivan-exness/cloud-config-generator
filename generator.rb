require 'sinatra'
require 'digest/sha1'

get '/cloud-config' do

  erb :config, :locals => {:ip => params[:ip],
                           :digest => Digest::SHA1.hexdigest(params[:ip].to_s) }
end