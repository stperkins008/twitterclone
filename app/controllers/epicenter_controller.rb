class EpicenterController < ApplicationController

  before_action :authenticate_user!

  def following
    @user = User.find(params[:id])
    @users = []

    User.all.each do |user|
      if @user.following.include?(user.id)
        @users.push(user)
      end
    end
  end

  def followers
    @user = User.find(params[:id])
    @users = []
    User.all.each do |user|
      if user.following.include?(@user.id)
        @users.push(user)
      end
    end
  end

  def all_users
    @users = User.all
  end

  def tag_tweets
    @tag = Tag.find(params[:id])
  end
  
  def feed
    @tweet = Tweet.new
  	@following_tweets = []

  	Tweet.all.each do |x|
  		if current_user.following.include?(x.user_id) || current_user.id == x.user_id
  			@following_tweets.push(x)
  		end
  	end
  end

  def show_user
  	@user = User.find(params[:id])
  end

  def now_following
  	current_user.following.push(params[:id].to_i)
  	current_user.save

  	redirect_to show_user_path(id: params[:id])

  end

  def unfollow
  	current_user.following.delete(params[:id].to_i)
  	current_user.save

  	redirect_to show_user_path(id: params[:id])

  end

end













