require 'spec_helper'

describe Bootstrap::DropdownHelper do
  
  describe '#nav_dropdown' do
    let(:nav_dropdown) { helper.nav_dropdown('text') { content_tag(:li, 'item') } }
    let(:html) { Capybara.string(nav_dropdown) }

    it "has correct html" do
      html.find('li.dropdown').tap do |li|
        li.find('a.dropdown-toggle', text: 'text').tap do |a|
          a.find('span.caret').should_not be_nil
        end
        
        li.find('ul.dropdown-menu').tap do |ul|
          ul.find('li', text: 'item').should_not be_nil
        end
      end
    end
  end
  
  describe '#button_dropdown' do
    let(:button_dropdown) { helper.button_dropdown('text') { content_tag(:li, 'item') } }
    let(:html) { Capybara.string(button_dropdown) }
    
    it "has correct html" do
      html.find('div.btn-group').tap do |div|
        div.find('a.dropdown-toggle[data-toggle="dropdown"][href="#"]', text: 'text ').tap do |a|
          a.find('span.caret').should_not be_nil
        end

        div.find('ul.dropdown-menu').tap do |ul|
          ul.find('li', text: 'item').should_not be_nil
        end
      end
    end
  end
  
  describe '#split_button_dropdown' do
    let(:split_button_dropdown) do
      helper.split_button_dropdown('Small Info Button', :info, :small ) do
        dropdown_item "dd item", 'dd_item_url'
      end
    end
    
    let(:html) { Capybara.string(split_button_dropdown) }
    
    it "has correct html" do
      html.find('div.btn-group').tap do |div|
        div.find('button.btn.btn-info.btn-small', text: 'Small Info Button').should_not be_nil
        
        div.find('button.btn.btn-info.btn-small.dropdown-toggle[data-toggle="dropdown"]').tap do |button|
          button.find('span.caret').should_not be_nil
        end
        
        div.find('ul.dropdown-menu').tap do |ul|
          ul.find('li a[href="dd_item_url"]', text: 'dd item').should_not be_nil
        end
      end
    end
  end
  
  describe '#dropdown_item' do
    it "text, url" do
      di = helper.dropdown_item('Text', '/url')
      di.should have_css('li a[href="/url"]', text: 'Text')
    end
    
    it "text only" do
      di = helper.dropdown_item('Text')
      di.should have_css('li a[href="javascript:void(0)"]', text: 'Text')
    end
    
    it "w/options" do
      di = helper.dropdown_item('Text', '/url', id: 'ID')
      di.should have_css('li a[href="/url"][id="ID"]', text: 'Text')
    end
  end
  
  describe '#dropdown_divider' do
    it "li.divider" do
      helper.dropdown_divider.should have_tag(:li, class: 'divider')
    end
  end
  
end