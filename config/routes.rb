Rails.application.routes.draw do
  root 'dashboards#new'

  get  'dashboards/new', to: 'dashboards#new'
  post 'dashboards/read_file', to: 'dashboards#read_file'
end
