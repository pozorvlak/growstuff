class FollowsController < ApplicationController
  before_filter :authenticate_member!
  load_and_authorize_resource

  # POST /follows
  def create
    @follow = current_member.follows.build(:followed_id => params[:followed_id])

    if @follow.save
      flash[:notice] = "Followed #{ @follow.followed.login_name }"
      redirect_to :back
    else
      flash[:error] = "Already following or error while following."
      redirect_to :back
    end
  end

  # DELETE /follows/1
  def destroy
    @follow = current_member.follows.find(params[:id])
    unfollowed_name = @follow.followed.login_name
    @follow.destroy

    flash[:notice] = "Unfollowed #{ unfollowed_name }"
    redirect_to root_path
  end
end
