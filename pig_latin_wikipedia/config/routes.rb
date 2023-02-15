Rails.application.routes.draw do
  get 'wiki/:article_title', to: 'articles#translate'
end
