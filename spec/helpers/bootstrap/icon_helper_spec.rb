require 'spec_helper'

describe Bootstrap::IconHelper do
  
  describe '#icon' do
    def icon(*args); helper.icon(*args); end
    
    describe 'errors' do
      it "must pass icon type" do
        expect { icon(nil) }.to raise_error(Bootstrap::IconRenderer::ArgumentError)
      end
      
      it "at most two non-hash args" do
        expect { icon(:type, 'Text', 'too many args') }. to raise_error(Bootstrap::IconRenderer::ArgumentError)
      end
    end
    
    describe 'icon only' do
      
      it "icon(:search)" do
        icon('search').should have_tag(:i, class: 'icon-search', text: nil)
        icon(:search).should have_tag(:i, class: 'icon-search', text: nil)
      end
      
      it "icon(:delete, :white)" do
        icon(:delete, :white).should have_tag(:i, class: ['icon-delete', 'icon-white'], text: nil)
      end
      
      it "icon(:search, id: 'ID', class: 'CLASS')" do
        icon(:search, id: 'ID', class: 'CLASS').should have_tag(:i, class: ['icon-search', 'CLASS'], id: 'ID', text: '')
      end
    end
    
    describe 'icon w/text' do
      
      it "icon(:search, 'Search')" do
        html = icon(:search, 'Search')
        html.should have_tag(:i, class: ['icon-search'], text: '')
        html.should match %r{</i> Search$}
      end
    
      it "icon(:search, :white, 'Search')" do
        html = icon(:search, :white, 'Search')
        html.should have_tag(:i, class: ['icon-search', 'icon-white'], text: nil)
        html.should match %r{</i> Search$}
      end
    
      it "icon(:spacer, 'Search')" do
        html = icon(:blank, 'Search')
        html.should have_tag(:i, class: ['icon-search'], text: '', style: 'opacity: 0')
        html.should match %r{</i> Search$}
      end
    end
    
  end
  
end