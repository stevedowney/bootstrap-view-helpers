Rails.application.routes.draw do

  get 'bootstrap_view_helpers(/:action)' => 'bootstrap_view_helpers', :as => :bvh
  
end
