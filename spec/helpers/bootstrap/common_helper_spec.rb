require 'spec_helper'

describe Bootstrap::CommonHelper do
  
  describe '#arrayify_class_and_stringify_elements' do
    def ac_and_se(h); helper.arrayify_class_and_stringify_elements(h) end
    
    it "preserves false" do
      ac_and_se(false).should == false
    end
    
    it "no class" do
      ac_and_se(nil).should == []
      ac_and_se(' ').should == []
      ac_and_se([]).should == []
    end
    
    it "string" do
      ac_and_se('klass').should == ['klass']
    end
    
    it "array" do
      ac_and_se(%w(one   two)).should == ['one', 'two']
    end
    
    it "converts to strings" do
      ac_and_se(:symbol).should == ['symbol']
      ac_and_se([:symbol, 3]).should == ['symbol', '3']
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
      helper.ensure_class({class: []}, 'foo')[:class].should == ['foo']
      helper.ensure_class({class: ['bar']}, 'foo')[:class].should == ['bar', 'foo']
      helper.ensure_class({class: ['bar', 'baz']}, ['foo'])[:class].should == ['bar', 'baz', 'foo']
    end
    
    it "doesn't re-add" do
      helper.ensure_class({class: ['foo']}, 'foo')[:class].should == ['foo']
    end
    
    it "preservers other hash keys" do
      helper.ensure_class({class: [], id: 'foo'}, 'bar').should == {id: 'foo', class: ['bar']}
    end
    
    it "doesn't mutate" do
      hash = {class: []}
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