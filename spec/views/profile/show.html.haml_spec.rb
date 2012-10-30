require 'spec_helper'

describe "profile/show" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :username => "pie",
      :password => "steak&kidney",
      :email => "steak-and-kidney@pie.com",
      :created_at => Time.new
    ))
  end

  it "shows account creation date" do
    render
    rendered.should contain "A Growstuff user since"
  end

  context "never logged in" do
    it "says they've never logged in if they haven't" do
      render
      rendered.should contain "yet to sign in"
    end
  end

  context "logged in" do
    it "shows the date of last login" do
      @user.confirm!
      sign_in @user
      render
      rendered.should contain "Last signed in at"
    end
  end

end
