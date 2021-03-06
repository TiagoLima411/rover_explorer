Rails.application.routes.draw do
  root 'dashboards#new'

  get  'dashboards/new', to: 'dashboards#new'
  post 'dashboards/process_file', to: 'dashboards#process_file'
  get  'dashboards/charts_ajax', to: 'dashboards#charts_ajax'
end
