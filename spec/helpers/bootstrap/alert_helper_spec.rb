require 'spec_helper'

describe Bootstrap::AlertHelper do
  
  describe '#alert' do
    def alert(*args, &block)
      helper.alert(*args, &block)
    end
    let(:html) { Capybara.string()}
    # def alert(*args, &block)
    #   text = args.shift unless block_given?
    #   options = canonicalize_options(args.extract_options!)
    #   options = ensure_class(options, 'alert')
    #   options = add_alert_classes(options, args)
    #   heading = options.delete(:heading)
    #   show_close = options.delete(:close) != false 
    # 
    #   if block_given?
    #     content_tag(:div, options) do
    #       alert_close(show_close) + 
    #       alert_heading(heading) + 
    #       capture(&block)
    #     end
    #   else
    #     content_tag(:div, options) do
    #       alert_close(show_close) + 
    #       alert_heading(heading) + 
    #       text
    #     end
    #   end
    # end
def h(s); helper.send(:h, s).inspect;end

    it "default" do
      html = alert('foo')
      
      Capybara.string(html).tap do |html|
        html.find('div').tap do |div|
          div.should have_tag(:button)
          div.should_not have_tag(:h4)
          div.should have_content('foo')
        end
      end
    end
    
    it "with heading" do
      html = alert('foo', heading: 'Head')

      Capybara.string(html).tap do |html|
        html.find('div').tap do |div|
          div.should have_tag(:button)
          div.should have_tag(:h4, text: 'Head')
          div.should have_content('foo')
        end
      end
    end

    it "no close" do
      html = alert('foo', close: false)

      Capybara.string(html).tap do |html|
        html.find('div').tap do |div|
          div.should_not have_tag(:button)
          div.should have_content('foo')
        end
      end
    end
    
    it "block" do
      html = alert() { 'block content' }

      Capybara.string(html).tap do |html|
        html.find('div').tap do |div|
          div.should have_tag(:button)
          div.should have_content('block content')
        end
      end
    end
    
    it "bad type" do
      expect { alert('foo', :bad) }.to raise_error(Bootstrap::AlertHelper::InvalidAlertTypeError)
    end

    it "w/options" do
      alert('foo', id: 'i', class: 'c').should have_tag('div', class: ['c', 'alert'], text: 'foo')
    end

  end
  
  describe '#alert_close' do
    it "show=false" do
      helper.alert_close(false).should == ''
    end
    
    it "show=true" do
      html = helper.alert_close
      html.should have_tag(:button, class: 'close', :"data-dismiss" => 'alert')
      html.should include(">&times;<")
    end
  end
  
  describe '#alert_heading' do
    it "heading blank" do
      helper.alert_heading(nil).should == ''
    end
    
    it "heading not blank" do
      helper.alert_heading('Head').should have_tag(:h4, text: 'Head')
    end
  end
  
end