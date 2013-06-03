require 'spec_helper'

describe Bootstrap::NavHelper do
  
  describe '#nav_bar' do
    let(:nav_bar) { helper.nav_bar { content_tag(:span, 'content') } }
    let(:html) { Capybara.string(nav_bar) }
    
    it "has correct html" do
      html.find('header.navbar').tap do |header|
        header.find('nav.navbar-inner').tap do |nav|
          nav.should have_tag(:span, text: 'content')
        end
      end
    end
  end
  
  describe '#brand' do
    def brand(*args); helper.brand(*args); end
    
    it "no url" do
      brand('foo').should have_tag(:span, class: 'brand', text: 'foo')
    end
    
    it "url" do
      brand('foo', url: 'url').should have_tag(:a, class: 'brand', href: 'url', text: 'foo')
    end
    
    it "with_environment - not 'production'" do
     brand('foo', with_environment: true)
        .should have_tag(:span, class: ['brand', 'rails-test'], text: 'foo - test')
    end

    it "with_environment - 'production'" do
      Rails.stub(env: 'production')
      html = brand('foo', with_environment: true)

      html.should have_tag(:span, class: ['brand'], text: 'foo')
      
      html.should_not have_tag(:span, class: 'rails-production')
      html.should_not have_tag(:span, text: 'production')
    end
  end
  
  describe '#nav_bar_links' do
    let(:nav_bar_links) { helper.nav_bar_links(pull: 'right') { content_tag(:span, 'content') } }
    let(:html) { Capybara.string(nav_bar_links) }
    
    it "has correct html" do
      html.find('div.nav').tap do |div|
        div.should have_tag(:span, text: 'content')
      end
    end
    
    it "supports :pull option" do
      html.should have_tag('div.nav.pull-right')
    end
  end
  
  describe '#nav_bar_link' do
    it "li a" do
      html = Capybara.string(helper.nav_bar_link('text', 'url'))
      html.find('li a[href="url"]', text: 'text').should_not be_nil
    end

    it "li.active a" do
      html = Capybara.string(helper.nav_bar_link('text', 'url', active: true))
      html.find('li.active a[href="url"]', text: 'text').should_not be_nil
    end
  end

  describe '#nav_bar_divider' do
    it "li.divider-vertical" do
      helper.nav_bar_divider.should have_tag(:li, class: 'divider-vertical', text: nil)
    end
  end
  
  describe '#nav_list' do
    it "div.well ul.nav.nav-list" do
      html = Capybara.string(helper.nav_list(id: 'ID') { content_tag(:span, 'LIs')})
      
      html.find('div.well[id="ID"]').tap do |well|
        well.find('ul.nav.nav-list').tap do |ul|
          ul.should have_tag(:span, text: 'LIs')
        end
      end
    end
  end
  
  describe '#nav_list_header' do
    it "<li.nav-header>text</li>" do
      helper.nav_list_header('TEXT').should have_tag(:li, class: 'nav-header', text: 'TEXT')
    end
  end
  
  describe '#nav_bar_text' do
    def nbt(*args); helper.nav_bar_text(*args) end
    
    it "defaults" do
      html = nbt('Text', id: 'ID')
      html.should have_tag(:p, class: ['navbar-text', 'pull-left'], id: 'ID', text: 'Text')
      html.should include('&nbsp;&nbsp;&nbsp;Text&nbsp;&nbsp;&nbsp;')
    end
    
    it "pull right" do
      nbt('Text', pull: 'right').should have_tag(:p, class: ['navbar-text', 'pull-right'], text: 'Text')
    end
    
    it "suppress padding" do
      html = nbt('Text', pad: false)
      html.should have_tag(:p, class: ['navbar-text', 'pull-left'], text: 'Text')
      html.should_not include('&nbsp;')
    end
  end
  
end
    