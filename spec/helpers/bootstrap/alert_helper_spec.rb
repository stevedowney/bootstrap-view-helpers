require 'spec_helper'

describe Bootstrap::AlertHelper do
  
  describe '#alert' do
    def alert(*args, &block)
      helper.alert(*args, &block)
    end

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