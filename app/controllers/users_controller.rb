class UsersController < ApplicationController

  def show
    params[:id] = current_user.id

    user = UserResource.find(params)
    respond_with(user)
  end
end
