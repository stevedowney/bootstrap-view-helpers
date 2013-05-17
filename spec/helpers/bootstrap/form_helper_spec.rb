require 'spec_helper'

describe Bootstrap::FormHelper do

  describe '#submit_tag' do

    def submit_tag(*args)
      tag = helper.submit_tag(*args)
      Capybara.string(tag)
    end

    it "submit_tag()" do
      submit_tag.should have_tag(:input,
      type: 'submit', 
      name: 'commit',
      value: 'Save changes',
      class: %w(btn btn-primary),
        :"data-disable-with" => 'Processing ...',
        )
    end

    it "override text" do
      submit_tag('Save').should have_tag(:input,
      type: 'submit',
      name: 'commit',
      value: 'Save',
      class: %w(btn btn-primary),
        :"data-disable-with" => 'Processing ...',
        )
    end

    it "add a non-btn class" do
      submit_tag('Non btn class', class: 'my-class').should have_tag(:input,
      type: 'submit',
      name: 'commit',
      value: 'Non btn class',
      class: %w(btn btn-primary my-class),
        :"data-disable-with" => 'Processing ...',
        )
    end

    it "override btn class(es) by providing a btn class" do
      tag = submit_tag('Save', class: 'btn-info')
      tag.should have_tag(:input,
      type: 'submit',
      name: 'commit',
      value: 'Save',
      class: %w(btn btn-info),
        :"data-disable-with" => 'Processing ...',
        )
    end


    it "override disable_with" do
      submit_tag('Save', disable_with: 'my disable').should have_tag(:input,
      type: 'submit',
      name: 'commit',
      value: 'Save',
      class: %w(btn btn-primary),
        :"data-disable-with" => 'my disable',
        )
    end

    it "turn off disable_with" do
      submit_tag('Save', disable_with: false).find('input')[:"data-disable-with"].should be_blank
    end

    it "options" do
      submit_tag('Options', id: 'foo', name: 'my name').should have_tag('input', id: 'foo', name: 'my name')
    end

  end

end