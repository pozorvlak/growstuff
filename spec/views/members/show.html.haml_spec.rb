require 'spec_helper'

describe "members/show" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :username => "pie",
      :password => "steak&kidney",
      :email => "steak-and-kidney@pie.com",
      :created_at => Time.new,
      :slug => "pie"
    ))
  end

  it "shows account creation date" do
    render
    rendered.should contain "A Growstuff member since"
  end

end
