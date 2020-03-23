class ScoresIndexController < ApplicationController
  before_action :authorize!, only: %i[index]
  def index
    user = User.find(params[:id])
    if confirm_user_unpublic?(user)
      raise(ActionController::BadRequest, '非公開ユーザーです')
    end

    render json: user.scores
  end
end
