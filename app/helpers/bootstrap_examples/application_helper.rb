module BootstrapExamples::ApplicationHelper

  # def bvh_navbar_example
  #   erb = IO.read(bvh_partial_dir.join('_bootstrap_view_helper_nav_bar.html.erb'))
  #   content_tag(:pre, erb)
  # end
  # 
  # 
  # def bvh_sidebar_example
  #   erb = IO.read(bvh_partial_dir.join('_bootstrap_view_helper_side_bar.html.erb'))
  #   content_tag(:pre, erb)
  # end
  # 
  # def bvh_accordion_example
  #   erb = IO.read(bvh_example_dir.join('_accordions.html.erb'))
  #   content_tag(:pre, erb)
  # end
  
  def bvh_show_source(path)
    erb = IO.read(bvh_view_dir.join("#{path}.html.erb"))
    content_tag(:pre, erb)
  end
  
  private
  
  def bvh_view_dir
    Rails.root.join('../../app/views')
  end
  
  # def bvh_example_dir
  #   Rails.root.join('../../app/views/bootstrap_view_helpers')
  # end
  # 
  # def bvh_partial_dir
  #   Rails.root.join('../../app/views/application')
  # end
end
  