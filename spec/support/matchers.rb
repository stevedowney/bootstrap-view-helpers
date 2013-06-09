module SelectorMethods

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

end

Capybara::Session.send(:include, SelectorMethods)
RSpec.configure { |c| c.include SelectorMethods }

