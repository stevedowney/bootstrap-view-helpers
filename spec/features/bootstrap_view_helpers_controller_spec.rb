require 'spec_helper'

describe BootstrapViewHelpersController do
  
  describe '#index' do
    it "ok" do
      visit bvh_path
    end
  end
  
  describe '#accordions' do
    it "ok" do
      visit bvh_path('accordions')
    end
  end
  
  describe '#alerts' do
    it "ok" do
      visit bvh_path('alerts')
    end
  end
  
  describe '#buttons' do
    it "ok" do
      visit bvh_path('buttons')
    end
  end
  
  describe '#icons' do
    it "ok" do
      visit bvh_path('icons')
    end
  end
  
  describe '#form_helpers' do
    it "ok" do
      visit bvh_path('form_helpers')
    end
  end
  
  describe '#flash_helper' do
    it "ok" do
      visit bvh_path('flash_helper')
    end
  end
  
  describe '#labels_and_badges' do
    it "ok" do
      visit bvh_path('labels_and_badges')
    end
  end
  
  describe '#modals' do
    it "ok" do
      visit bvh_path('modal')
    end
  end
  
  describe 'nav helpers' do
    it "ok" do
      visit bvh_path
    end
  end
  
  describe 'tables' do
    it "ok" do
      visit bvh_path('tables')
    end
  end

end