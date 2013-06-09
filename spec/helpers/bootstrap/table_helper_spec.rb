require 'spec_helper'

describe Bootstrap::TableHelper do
  
  describe '#bs_table_tag' do
    def bs_table_tag(*args, &block)
      helper.bs_table_tag(*args, &block)
    end
    let(:html) { Capybara.string()}

    # def h(s); helper.send(:h, s).inspect;end

    
    it "default" do
      html = bs_table_tag {'Content'}
      
      Capybara.string(html).tap do |html|
        html.find('table.table.table-bordered.table-striped.table-hover').tap do |table|
          table.should have_content('Content')
        end
      end
    end

    it "optins" do
      html = bs_table_tag(id: 'my-id', class: 'my-class') {'Content'}
      
      Capybara.string(html).tap do |html|
        html.find('table.my-class.table.table-bordered.table-striped.table-hover[id="my-id"]').tap do |table|
          table.should have_content('Content')
        end
      end
    end

    describe 'custom class lists' do
      before { Bootstrap::TableHelper.class_lists[:foo] = 'table foo'}
      after  { Bootstrap::TableHelper.class_lists.delete(:foo) }
      
      it "uses list" do
        html = bs_table_tag(:foo) { 'Content' }

        Capybara.string(html).tap do |html|
          html.find('table.foo').tap do |table|
            table.should have_content('Content')
          end
        end
      end
      
      it "raise error on unknown class_lists key" do
        expect { bs_table_tag(:junk) { 'Conent' } }
          .to raise_error(Bootstrap::TableHelper::InvalidClassListsKeyError)
      end
    end
    
  end
  
end