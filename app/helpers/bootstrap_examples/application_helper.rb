module BootstrapExamples::ApplicationHelper

  def bvh_navbar_example
    erb = IO.read(bvh_partial_dir.join('_bootstrap_view_helper_nav_bar.html.erb'))
    content_tag(:pre, erb)
  end

  
  def bvh_sidebar_example
    erb = IO.read(bvh_partial_dir.join('_bootstrap_view_helper_side_bar.html.erb'))
    content_tag(:pre, erb)
  end

  private
  
  def bvh_partial_dir
    Rails.root.join('../../app/views/application')
  end
end
  