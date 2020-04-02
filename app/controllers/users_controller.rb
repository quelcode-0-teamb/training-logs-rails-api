class UsersController < ApplicationController
  before_action :authorize!, only: %i[update destroy show]

  def top
    readme_url = 'https://mukimukiroku.herokuapp.com/'
    render json: { 'welcome!': 'APIサーバーだよ', 'how_to_use': readme_url }
  end

  # ユーザー情報変更
  def update
    current_user.update!(check_params_present(user_update_params))
    render json: current_user
  end

  # ユーザー消去
  def destroy
    current_user.destroy!
    render status: :no_content
  end

  def show
    response = if current_user == User.find(params[:id])
                 UserSerializer.new(current_user)
               else
                 {
                   "user": OtherUserSerializer.new(User.find(params[:id])),
                   "follow_status": current_user.follow_status(User.find(params[:id]))
                 }
               end
    render json: response.as_json
  end

  private

  def user_update_params
    params.require(:user_update_params).permit(
      :name,
      :email,
      :user_private
    )
  end
end
