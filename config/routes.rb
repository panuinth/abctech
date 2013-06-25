Abctech::Application.routes.draw do
  root :to => "candidates#index"
  get '/candidates/show' => 'candidates#show'
  get '/candidates/load' => 'candidates#load'
  get '/candidates/new' => 'candidates#new'
  get '/candidates/upload_picture' => 'candidates#upload_picture'
  post '/candidates/create' => 'candidates#create'
  post '/candidates/update_picture' => 'candidates#update_picture'
end
