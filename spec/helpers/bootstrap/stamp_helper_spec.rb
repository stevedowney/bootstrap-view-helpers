require 'spec_helper'

describe Bootstrap::StampHelper do
  
  describe '#stamp' do
    def stamp(*args)
      helper.stamp(*args)
    end
    
    it 'various types' do
      stamp('foo').should have_tag(:span, class: 'label', text: 'foo')
      stamp('foo', :success).should have_tag('span', class: ['label', 'label-success'], text: 'foo')
      stamp('foo', :warning).should have_tag('span', class: ['label', 'label-warning'])
      stamp('foo', :important).should have_tag('span', class: ['label', 'label-important'])
      stamp('foo', :info).should have_tag('span', class: ['label', 'label-info'])
      stamp('foo', :inverse).should have_tag('span', class: ['label', 'label-inverse'])
    end

    it "bad type" do
      expect { stamp('foo', :bad) }.to raise_error(Bootstrap::StampHelper::InvalidStampTypeError)
    end

    it "w/options" do
      stamp('foo', id: 'i', class: 'c').should have_tag('span', class: ['c', 'label'], text: 'foo')
    end

  end
  
end