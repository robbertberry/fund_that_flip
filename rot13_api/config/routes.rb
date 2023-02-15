Rails.application.routes.draw do
  post 'encode', to: 'encoder#encode'
end
