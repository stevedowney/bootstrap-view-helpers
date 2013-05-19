require 'spec_helper'

describe Bootstrap::CommonHelper do
  
  describe '#arrayify_and_stringify_elements' do
    def a_and_se(h); arrayify_and_stringify_elements(h) end
    
    it "preserves false" do
      a_and_se(false).should == false
    end
    
    it "no class" do
      a_and_se(nil).should == []
      a_and_se(' ').should == []
      a_and_se([]).should == []
    end
    
    it "string" do
      a_and_se('klass').should == ['klass']
    end
    
    it "array" do
      a_and_se(%w(one   two)).should == ['one', 'two']
    end
    
    it "converts to strings" do
      a_and_se(:symbol).should == ['symbol']
      a_and_se([:symbol, 3]).should == ['symbol', '3']
    end
  end
  
  describe '#caret' do
    it "caret" do
      caret.should have_tag(:span, class: 'caret')
    end
    
    it "options" do
      caret(id: 'foo').should have_tag(:span, class: 'caret', id: 'foo')
    end
  end
  
  describe '#ensure_class' do
    
    it "adds class" do
      ensure_class({class: []}, 'foo')[:class].should == ['foo']
      ensure_class({class: ['bar']}, 'foo')[:class].should == ['bar', 'foo']
      ensure_class({class: ['bar', 'baz']}, ['foo'])[:class].should == ['bar', 'baz', 'foo']
    end
    
    it "doesn't re-add" do
      ensure_class({class: ['foo']}, 'foo')[:class].should == ['foo']
    end
    
    it "preservers other hash keys" do
      ensure_class({class: [], id: 'foo'}, 'bar').should == {id: 'foo', class: ['bar']}
    end
    
    it "doesn't mutate" do
      hash = {class: []}
      hash2 = ensure_class(hash, 'foo')
      hash.object_id.should_not == hash2.object_id
    end
  end
  
  describe '#extract_extras' do
    it "no extras" do
      extract_extras('foo').should == []
      extract_extras('foo', id: 'bar').should == []
    end
    
    it "extras" do
      extract_extras('foo', :small).should == [:small]
      extract_extras('foo', :large, :primary, id: 'bar').should == [:large, :primary]
    end
  end
  
end