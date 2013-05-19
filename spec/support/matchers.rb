module SelectorMethods

#   # The default ActiveRecord instance used in various selector and click methods.
#   def default_instance(instance = nil)
#     if instance.present?
#       @default_instance = instance
#     elsif @default_instance.present?
#       @default_instance
#     else
#       raise ArgumentError, "default instance not set"
#     end
#   end
# 
#   def create_and_login_user()
#     user = FactoryGirl.create(:user, :username => 'test_user', :password => 'secret', :confirmed_at => Time.now)
#     login_as(user, :scope => :user)
#     user
#   end
# 
#   def create_and_login_admin_user()
#     FactoryGirl.create(:admin_user).tap do |admin_user|
#       login_as(admin_user, :scope => :user)
#     end
#   end
#   
#   def should_require_admin
#     page.should have_content('Admin required')
#   end
#   
#   # def should_have_alert
#   #   page.should have_tag('div', :id => 'tb-alert')
#   # end
#   
#   # def should_have_confirm
#   #   page.should have_tag('div', :id => 'tb-confirm')
#   # end
#   
#   # def should_be_on_login_page
#   #   should_be_on_controller('sessions')
#   # end
#   
  def have_tag(tag, attributes = {})
    has_text = attributes.has_key?(:text)
    text = has_text && attributes.delete(:text)
    classes = Array(attributes.delete(:class))
    
    selector = tag.to_s
    classes.each do |c|
      selector << ".#{c}"
    end

    attributes.each do |k, v|
      selector << "[#{k}='#{v}']"
    end

    args = [selector]
    args << {:text => text} if has_text

    have_selector *args
  end

  def on_controller?(controller, action = nil)
    body_tag = find(:xpath, '//body')

    data_controller = body_tag['data-controller']
    if controller != data_controller
      msg = %(Expected to find body[data-controller] == "#{controller}", found "#{data_controller}")
      raise Capybara::ExpectationNotMet, msg
    end
    
    if action.present?
      data_action = body_tag['data-action']
      if action != data_action
        msg = %(Expected to find body[data-action] == "#{action}", found "#{data_action}")
        raise Capybara::ExpectationNotMet, msg
      end
    end
    
    true
  end
  
#   def should_have_div(instance = default_instance)
#     page.should have_tag(:div, :id => instance.dom_id, :class => instance.class.underscore)
#   end
#   
#   def should_not_have_div(instance = default_instance)
#     page.should_not have_tag(:div, :id => instance.dom_id)
#   end
  
  def has_tr?(instance = default_instance)
    selector = "tr##{instance.dom_id}.#{instance.dom_class}"
    if has_css?(selector)
      return true
    else
      raise Capybara::ExpectationNotMet, "Didn't find #{selector}"
    end
  end
  
#   def should_not_have_tr(instance = default_instance)
#     page.should_not have_tag(:tr, :id => instance.dom_id)
#   end
#   
#   def should_have_edit_link(instance = default_instance)
#     page.should have_tag(:a, :id => instance.dom_id('edit'))
#   end
# 
#   def should_not_have_edit_link(instance = default_instance)
#     page.should_not have_tag(:a, :id => instance.dom_id('edit'))
#   end
#   
#   def should_have_delete_link(instance = default_instance)
#     page.should have_tag(:a, :id => instance.dom_id('delete'))
#   end
# 
#   def should_not_have_delete_link(instance = default_instance)
#     page.should_not have_tag(:a, :id => instance.dom_id('delete'))
#   end
  
end

Capybara::Session.send(:include, SelectorMethods)
RSpec.configure { |c| c.include SelectorMethods }

