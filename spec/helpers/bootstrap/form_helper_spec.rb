require 'spec_helper'

describe Bootstrap::FormHelper do

  describe '#submit_button_tag' do

    def submit_button_tag(*args)
      tag = helper.submit_button_tag(*args)
      Capybara.string(tag)
    end

    it "submit_button_tag()" do
      submit_button_tag.should have_tag(:input,
        type: 'submit', 
        name: 'commit',
        value: 'Save changes',
        class: %w(btn btn-primary),
          :"data-disable-with" => 'Processing ...',
          )
    end

    it "override text" do
      submit_button_tag('Save').should have_tag(:input,
      type: 'submit',
      name: 'commit',
      value: 'Save',
      class: %w(btn btn-primary),
        :"data-disable-with" => 'Processing ...',
        )
    end
    
    it "error if bad button modifier" do
      submit_button_tag('Save')
      expect { submit_button_tag('Save', :bad) }.to raise_error(Bootstrap::FormHelper::InvalidButtonModifierError)
    end
    
    it "add a non-btn class" do
      submit_button_tag('Non btn class', class: 'my-class').should have_tag(:input,
      type: 'submit',
      name: 'commit',
      value: 'Non btn class',
      class: %w(btn btn-primary my-class),
        :"data-disable-with" => 'Processing ...',
        )
    end
    
    it "provide type and size" do
      tag = submit_button_tag(:small, :info)
      tag.should have_tag(:input,
      type: 'submit',
      name: 'commit',
      value: 'Save changes',
      class: %w(btn btn-info btn-small),
        :"data-disable-with" => 'Processing ...',
        )
    end
    
    it "override disable_with" do
      submit_button_tag('Save', disable_with: 'my disable').should have_tag(:input,
      type: 'submit',
      name: 'commit',
      value: 'Save',
      class: %w(btn btn-primary),
        :"data-disable-with" => 'my disable',
        )
    end
    
    it "turn off disable_with" do
      submit_button_tag('Save', disable_with: false).find('input')[:"data-disable-with"].should be_blank
    end
    
    it "options" do
      submit_button_tag('Options', id: 'foo', name: 'my name').should have_tag('input', id: 'foo', name: 'my name')
    end

  end

end