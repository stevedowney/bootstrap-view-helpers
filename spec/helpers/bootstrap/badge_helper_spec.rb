require 'spec_helper'

describe Bootstrap::BadgeHelper do
  
  describe '#badge' do
    def badge(*args)
      Capybara.string(helper.badge(*args))
    end
    
    it 'various types' do
      badge('foo').find('span.badge', text: 'foo').should_not be_nil
      badge('foo', :success).find('span.badge.badge-success', text: 'foo').should_not be_nil
      badge('foo', :warning).find('span.badge.badge-warning', text: 'foo').should_not be_nil
      badge('foo', :important).find('span.badge.badge-important', text: 'foo').should_not be_nil
      badge('foo', :info).find('span.badge.badge-info', text: 'foo').should_not be_nil
      badge('foo', :inverse).find('span.badge.badge-inverse', text: 'foo').should_not be_nil
    end

    it "bad type" do
      expect { badge('foo', :bad) }.to raise_error(Bootstrap::BadgeHelper::InvalidBadgeTypeError)
    end

    it "w/options" do
      badge('foo', id: 'i', class: 'c').find('span.c.badge[id="i"]', text: 'foo').should_not be_nil
    end

  end
  
end