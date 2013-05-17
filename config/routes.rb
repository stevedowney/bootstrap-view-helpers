Rails.application.routes.draw do
  
  match 'bootstrap_view_helpers' => 'bootstrap_view_helpers#index', :as => :bootstrap_view_helpers
end
