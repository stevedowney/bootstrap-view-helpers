Rails.application.routes.draw do
  
  match 'bootstrap_view_helpers(/:action)' => 'bootstrap_view_helpers', :as => :bvh
end
