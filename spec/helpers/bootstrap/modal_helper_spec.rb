require 'spec_helper'

describe Bootstrap::ModalHelper do
  def h(s); helper.send(:h, s).inspect;end
  
  describe '#modal_trigger' do
    def modal_trigger(*args, &block)
      helper.modal_trigger(*args, &block)
    end
    
    it "basic" do
      html = modal_trigger("Click", href: "trigger")

      Capybara.string(html).tap do |html|
        html.should have_tag('a.btn[href="trigger"][data-toggle="modal"][role="button"]', text: "Click" )
      end
    end

    it "options" do
      html = modal_trigger("Click", href: "trigger", id: 'my-id', class: 'my-class')

      Capybara.string(html).tap do |html|
        html.should have_tag('a.my-class.btn[id="my-id"][href="trigger"][data-toggle="modal"][role="button"]', text: "Click" )
      end
    end
    
    it "required param" do
      expect { modal_trigger("Click") }.to raise_error(ArgumentError, "missing :href option")
    end
  end
  
  describe '#modal' do
    def modal(*args, &block)
      helper.modal(*args, &block)
    end
    
    it "basic" do
      html = modal(id: 'ID') { 'Body' }
      
      Capybara.string(html).tap do |html|
        html.should have_tag('div.modal.hide.fade', id: "ID", role: 'dialog', text: 'Body')
      end
    end

    it "options" do
      html = modal(id: 'ID', class: 'my-class') { 'Body' }
      
      Capybara.string(html).tap do |html|
        html.should have_tag('div.my-class.modal.hide.fade', id: "ID", role: 'dialog', text: 'Body')
      end
    end

    it "error if no :id" do
      expect { modal() {"Body"} }.to raise_error(ArgumentError, "missing :id option")
    end
  end
  
  describe '#modal_header' do
    def modal_header(*args, &block)
      helper.modal_header(*args, &block)
    end
    
    it "basic" do
      html = modal_header("Header")
      
      Capybara.string(html).tap do |html|
        html.find('div.modal-header').tap do |div|
          div.should have_tag('button.close')
          div.should have_tag(:h3, text: 'Header')
        end
      end
    end

    it "block" do
      html = modal_header() { "Header"}
      
      Capybara.string(html).tap do |html|
        html.find('div.modal-header').tap do |div|
          div.should have_tag('button.close')
          div.should have_tag(:h3, text: 'Header')
        end
      end
    end

    it "options" do
      html = modal_header(close: false, id: 'my-id', class: 'my-class') { "Header"}
      
      Capybara.string(html).tap do |html|
        html.find('div.modal-header.my-class[id="my-id"]').tap do |div|
          div.should_not have_tag('button.close')
          div.should have_tag(:h3, text: 'Header')
        end
      end
    end

  end

  describe '#modal_body' do
    def modal_body(*args, &block)
      helper.modal_body(*args, &block)
    end
    
    it "basic" do
      html = modal_body("Body")
      
      Capybara.string(html).tap do |html|
        html.should have_tag('div.modal-body', text: 'Body')
      end
    end

    it "block" do
      html = modal_body() { "Body" }
      
      Capybara.string(html).tap do |html|
        html.should have_tag('div.modal-body', text: 'Body')
      end
    end

    it "options" do
      html = modal_body(id: 'my-id', class: 'my-class') { "Body"}
      
      Capybara.string(html).tap do |html|
        html.should have_tag('div.modal-body.my-class[id="my-id"]', text: 'Body')
      end
    end

  end
  
  describe '#modal_footer' do
    def modal_footer(*args, &block)
      helper.modal_footer(*args, &block)
    end

    it "default" do
      html = modal_footer
      
      Capybara.string(html).tap do |html|
        html.find('div.modal-footer').tap do |div|
          div.should have_tag('button.modal-close.modal-footer-close', text: "Close")
        end
      end
    end
    
    it "footer as first arg" do
      html = modal_footer("Footer")
      
      Capybara.string(html).tap do |html|
        html.should have_tag('div.modal-footer', text: 'Footer')
      end
    end
    
    it "block" do
      html = modal_footer() { "Block Footer" }
      
      Capybara.string(html).tap do |html|
        html.should have_tag('div.modal-footer', text: 'Block Footer')
      end
    end
    
    it "options" do
      html = modal_footer(id: 'my-id', class: 'my-class') { "Block Footer" }
      
      Capybara.string(html).tap do |html|
        html.should have_tag('div.modal-footer.my-class[id="my-id"]', text: 'Block Footer')
      end
    end
  end
  
  describe '#modal_header_close_button' do
    def modal_header_close_button(*args, &block)
      helper.modal_header_close_button(*args, &block)
    end

    it "show" do
      html = modal_header_close_button
      
      Capybara.string(html).tap do |html|
        html.find('button.close.modal-close.modal-header-close').tap do |button|
          button.should_not be_nil
        end
      end
    end
    
    it "don't show" do
      modal_header_close_button(false).should == ''
    end
  end

  describe '#modal_footer_close_button' do
    def modal_footer_close_button(*args, &block)
      helper.modal_footer_close_button(*args, &block)
    end

    it "default" do
      html = modal_footer_close_button
      
      Capybara.string(html).tap do |html|
        html.should have_tag('button.btn.modal-close.modal-footer-close[data-dismiss="modal"]', text: 'Close')
      end
    end
    
    it "specify text, options" do
      html = modal_footer_close_button("Return", id: 'my-id', class: 'my-class')
      
      Capybara.string(html).tap do |html|
        html.should have_tag('button.my-class.btn.modal-close.modal-footer-close[data-dismiss="modal"][id="my-id"]', text: 'Return')
      end
    end
  end
  
  describe '#modal_footer_ok_button' do
    def modal_footer_ok_button(*args, &block)
      helper.modal_footer_ok_button(*args, &block)
    end

    it "default" do
      html = modal_footer_ok_button
      
      Capybara.string(html).tap do |html|
        html.should have_tag('button.btn.modal-footer-ok[data-dismiss="modal"]', text: "Ok")
      end
    end
    
    it "specify text, options" do
      html = modal_footer_ok_button("Save", id: 'my-id', class: 'my-class')
      
      Capybara.string(html).tap do |html|
        html.should have_tag('button.my-class.btn.modal-footer-ok[data-dismiss="modal"][id="my-id"]', text: 'Save')
      end
    end
  end

  describe '#modal_alert' do
    def modal_alert(*args, &block)
      helper.modal_alert(*args, &block)
    end

    it "default" do
      html = modal_alert("Body", id: 'ID')

      Capybara.string(html).tap do |html|
        html.find('div.modal').tap do |modal|
          modal.should have_tag('div.modal-header', text: 'Alert')
          modal.should have_tag('div.modal-body', text: 'Body')
          modal.find('div.modal-footer').tap do |footer|
            footer.should have_tag('button.modal-footer-close', text: 'Close')
          end
        end
      end
    end
    
    it "header, block, options" do
      html = modal_alert(id: 'ID', header: 'Header', class: 'my-class') { 'Block Body'}

      Capybara.string(html).tap do |html|
        html.find('div.my-class.modal').tap do |modal|
          modal.should have_tag('div.modal-header', text: 'Header')
          modal.should have_tag('div.modal-body', text: 'Block Body')
          modal.find('div.modal-footer').tap do |footer|
            footer.should have_tag('button.modal-footer-close', text: 'Close')
          end
        end
      end
    end
  end

  describe '#modal_confirm' do
    def modal_confirm(*args, &block)
      helper.modal_confirm(*args, &block)
    end

    it "default" do
      html = modal_confirm("Body", id: 'ID')

      Capybara.string(html).tap do |html|
        html.find('div.modal').tap do |modal|
          modal.should have_tag('div.modal-header', text: 'Confirm')
          modal.should have_tag('div.modal-body', text: 'Body')
          modal.find('div.modal-footer').tap do |footer|
            footer.should have_tag('button.modal-footer-close', text: 'Cancel')
            footer.should have_tag('button.modal-footer-ok', text: 'Ok')
          end
        end
      end
    end
    
    it "header, block, options" do
      html = modal_confirm(id: 'ID', header: 'Header', class: 'my-class') { 'Block Body'}
      
      Capybara.string(html).tap do |html|
        html.find('div.my-class.modal').tap do |modal|
          modal.should have_tag('div.modal-header', text: 'Header')
          modal.should have_tag('div.modal-body', text: 'Block Body')
          modal.find('div.modal-footer').tap do |footer|
            footer.should have_tag('button.modal-footer-close', text: 'Cancel')
            footer.should have_tag('button.modal-footer-ok', text: 'Ok')
          end
        end
      end
    end
  end
end