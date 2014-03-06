require 'spec_helper'

describe AdminHelper do
  before(:all) do
    class AdminHelperClass
      include AdminHelper
      # include Padrino::Admin::Helpers::ViewHelpers
      # include Padrino::Helpers::TranslationHelpers
      # include Padrino::Routing
    end
  end
  subject(:helper) { AdminHelperClass.new }
  let(:admin_app)  { Lenstroy::Admin }

  describe '#sort_resource' do
    it "returns sort object from params and request.path_info" do
      sort = AdminHelperClass::Sort.new('title', 'asc', 1)
      subject.stub(:params).and_return({sort: 'title', order: 'asc'})
      subject.sort_resource.should eq(sort)
    end
  end

  describe '#sort_link' do
    context "with :pages and :title parameters" do
      before do
        app.helpers AdminHelper
        helper.stub(:settings).and_return(admin_app)
        sort = AdminHelperClass::Sort.new('title', 'asc')
        helper.instance_variable_set('@sort', sort)
      end

      it "returns link to resource with sort parameters" do
        pending "Can't load Padrino scope properly"
        app do
          get '/' do
            sort_link(:pages, :title)
          end
        end
        get "/"
        last_response.body.should =~ /<a href=([^ >]+)pages/
      end
    end
  end
end