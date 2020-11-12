class RelationshipsController < ApplicationController
	def create
		# current_userがfollowメソッドを呼び出し、followメソッドで生成されたuser_id(followed_id)を受け取る
		current_user.follow(params[:user_id])
		redirect_back(fallback_location: root_path)
	end

	def destroy
		current_user.unfollow(params[:user_id])
		redirect_back(fallback_location: root_path)
	end

	def follow
		user = User.find(params[:user_id])
		@users = user.following_user
	end

	def follower
		user = User.find(params[:user_id])
		@users = user.follower_user
	end

end