Grooves::Application.routes.draw do

  root :to => 'tracks#home'
  get '/track' => 'tracks#track'
  get '/test' => 'tracks#test'
  get '/get_database_tracks' => 'tracks#get_database_tracks'

end
