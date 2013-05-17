require 'spec_helper'

describe Bootstrap::ButtonHelper do
  
  describe '#button' do
    def button(*args)
      helper.button(*args)
    end

    it "<button>" do
      button('foo').should have_tag(:button, class: 'btn', text: 'foo')
    end
    
    it "<a>" do
      button('foo', url: 'path').should have_tag(:a, class: 'btn', href: 'path', text: 'foo')
    end
    
    it "type and/or size" do
      button('foo', :primary, :small).should have_tag(:button, class: %w(btn btn-primary btn-small), text: 'foo')
    end
    
    it "bad modifier" do
      expect { button('foo', :bad) }.to raise_error(Bootstrap::ButtonHelper::InvalidButtonModifierError)
    end
    
    it "w/options" do
      button('foo', :info, id: 'i', class: 'c').should have_tag(:button, class: %w(c btn btn-info), id: 'i')
    end

  end
  
  describe '#button_toolbar' do
    let(:button_toolbar) { helper.button_toolbar { content_tag(:div, 'BUTTONS') } }
    let(:html) { Capybara.string(button_toolbar) }
    
    it "should have correct html" do
      html.find('div.btn-toolbar').tap do |div|
        div.find('div', text: 'BUTTONS').should_not be_nil
      end
    end
  end
  
  describe '#button_group' do
    let(:button_group) { helper.button_group { content_tag(:div, 'BUTTONS') } }
    let(:html) { Capybara.string(button_group) }
    
    it "should have correct html" do
      html.find('div.btn-group').tap do |div|
        div.find('div', text: 'BUTTONS').should_not be_nil
      end
    end
  end
  
end