require 'spec_helper'

feature "follows" do

  context "signed out member" do
    let(:member) { FactoryGirl.create(:member) }

    context "someone else's profile page" do
      scenario "doesn't have a follow button" do
        visit member_path(member)
        expect(page).not_to have_content "Follow"
      end
    end
  end

  context "signed in member" do
    let(:member) { FactoryGirl.create(:member) }
    let(:other_member) { FactoryGirl.create(:member) }

    background do
      login_as(member)
    end

    context "your own profile page" do
      background do
        visit member_path(member)
      end

    end

    context "someone else's profile page" do
      background do
        visit member_path(other_member)
      end

      scenario "has a follow button" do
        expect(page).to have_link "Follow", :href => follows_path(:followed_id => other_member.id)
      end
    end

    context "following another member" do
      background do
        visit member_path(other_member)
        click_link 'Follow'
      end

      scenario "has correct message and unfollow button" do
        expect(page).to have_content "Followed #{other_member.login_name}"
        expect(page).to have_link "Unfollow", :href => follow_path(member.get_follow(other_member))
      end

      scenario "has a followed member listed in the following page" do
        visit member_follows_path(member)
        expect(page).to have_content "#{other_member.login_name}"
      end

      scenario "has correct message and follow button after unfollow" do
        click_link 'Unfollow'
        expect(page).to have_content "Unfollowed #{other_member.login_name}"
        visit member_path(other_member) # unfollowing redirects to root
        expect(page).to have_link "Follow", :href => follows_path(:followed_id => other_member.id)
      end

      scenario "has member in following list" do
        visit member_follows_path(member)
        expect(page).to have_content "#{other_member.login_name}"
      end

      scenario "appears in in followed member's followers list" do
        visit member_followers_path(other_member)
        expect(page).to have_content "#{member.login_name}"
      end

      scenario "removes members from following and followers lists after unfollow" do
        click_link 'Unfollow'
        visit member_follows_path(member)
        expect(page).not_to have_content "#{other_member.login_name}"
        visit member_followers_path(other_member)
        expect(page).not_to have_content "#{member.login_name}"
      end

    end

  end
end
