class SignUpsController < ApplicationController
  def create
    user = User.create!(sign_up_params)
    render json: user.as_json, status: :created
  end

  def sign_up_params
    params.require(:sign_up_params).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :user_private
    )
  end
end
