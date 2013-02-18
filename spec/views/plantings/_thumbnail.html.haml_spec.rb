require 'spec_helper'

describe 'plantings/_thumbnail' do
  before(:each) do
    @member = FactoryGirl.create(:member)
    @garden = FactoryGirl.create(:garden, :owner => @member)
    @crop = FactoryGirl.create(:tomato)
    @planting = FactoryGirl.create(:planting,
      :garden => @garden,
      :crop => @crop
    )
  end

  context "view from owner page" do
    before(:each) do
      render :partial => "thumbnail", :locals => { :planting => @planting }
    end

    it "renders the quantity planted" do
      rendered.should contain "33"
    end

    it "shows the name of the crop" do
      rendered.should contain "Tomato"
    end

    it "does not show the name of the owner" do
      rendered.should_not contain @member.login_name
    end
  end

  context "view from crop page" do
    before(:each) do
      render :partial => "thumbnail", :locals => {
        :planting => @planting,
        :title => "owner"
      }
    end

    it "renders the quantity planted" do
      rendered.should contain "33"
    end

    it "does not show the name of the crop" do
      rendered.should_not contain "Tomato"
    end

    it "shows the name of the owner" do
      rendered.should contain @member.login_name
    end
  end
end
