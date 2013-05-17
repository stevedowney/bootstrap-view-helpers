require 'spec_helper'

describe Bootstrap::AccordionHelper do
  
  describe '#accordion' do
    let(:accordion) do
      helper.accordion do
        helper.accordion_group('Group') do
          content_tag(:span, 'content')
        end
      end
    end
    let(:html) { Capybara.string(accordion) }

    it "has correct html" do
      html.find('div.accordion[id="accordion-1"]').tap do |accordion|
        accordion.find('div.accordion-group').tap do |group|
          group.find('div.accordion-heading').tap do |heading|
            selector = [
              'a.accordion-toggle',
              '[data-parent="#accordion-1"]',
              '[data-toggle="collapse"]',
              '[href="#accordion-1-group-1"]'
            ].join
            heading.find(selector, text: 'Group').should_not be_nil
          end
          
          group.find('div.accordion-body.collapse[id="accordion-1-group-1"]').tap do |body|
            body.find('div.accordion-inner', text: 'content').should_not be_nil
          end
        end
      end
    end
  end
  
end