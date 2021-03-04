Rails.application.routes.draw do
  root 'dashboards#new'

  get  'dashboards/new', to: 'dashboards#new'
  post 'dashboards/read_file', to: 'dashboards#read_file'
  get  'dashboards/charts_ajax', to: 'dashboards#charts_ajax'
end
