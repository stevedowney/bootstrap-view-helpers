require 'spec_helper'

describe Bootstrap::CommonHelper do
  
  describe '#arrayify_class' do
    def arrayify_class(h); helper.arrayify_class(h) end
    
    it "requires Hash" do
      expect { arrayify_class('x') }.to raise_error(Bootstrap::CommonHelper::ArgumentError)
    end
    
    it "preserves false" do
      arrayify_class(class: false).should == {class: false}
    end
    
    it "no class" do
      arrayify_class({}).should == {class: []}
    end
    
    it "blank class" do
      arrayify_class(class: '').should == {class: []}
      arrayify_class(class: nil).should == {class: []}
    end
    
    it "string" do
      arrayify_class(class: 'klass').should == {class: ['klass']}
    end
    
    it "array" do
      arrayify_class(class: %w(one   two)).should == {class: ['one', 'two']}
    end
    
    it "converts to strings" do
      arrayify_class(class: :symbol).should == {class: ['symbol']}
      arrayify_class(class: [:symbol, 3]).should == {class: ['symbol', '3']}
    end
  end
  
  describe '#caret' do
    def caret(*args)
      Capybara.string(helper.caret(*args))
    end
    
    it "caret" do
      caret.find('span.caret').should_not be_nil
    end
    
    it "options" do
      caret(id: 'foo').find('span.caret[id="foo"]').should_not be_nil
    end
  end
  
  describe '#ensure_class' do
    
    it "adds class" do
      helper.ensure_class({}, 'foo')[:class].should == ['foo']
      helper.ensure_class({class: 'bar'}, 'foo')[:class].should == ['bar', 'foo']
      helper.ensure_class({class: ['bar', 'baz']}, 'foo')[:class].should == ['bar', 'baz', 'foo']
      helper.ensure_class({class: ['bar', 'baz']}, ['foo'])[:class].should == ['bar', 'baz', 'foo']
    end
    
    it "doesn't re-add" do
      helper.ensure_class({class: 'foo'}, 'foo')[:class].should == ['foo']
    end
    
    it "preservers other hash keys" do
      helper.ensure_class({id: 'foo'}, 'bar').should == {id: 'foo', class: ['bar']}
    end
    
    it "doesn't mutate" do
      hash = {}
      hash2 = helper.ensure_class(hash, 'foo')
      hash.object_id.should_not == hash2.object_id
    end
  end
  
  describe '#extract_extras' do
    it "no extras" do
      helper.extract_extras('foo').should == []
      helper.extract_extras('foo', id: 'bar').should == []
    end
    
    it "extras" do
      helper.extract_extras('foo', :small).should == [:small]
      helper.extract_extras('foo', :large, :primary, id: 'bar').should == [:large, :primary]
    end
  end
  
end