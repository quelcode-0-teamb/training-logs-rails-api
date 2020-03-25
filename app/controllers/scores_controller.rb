class ScoresController < ApplicationController
  before_action :authorize!

  def create
    set_num = params[:score_params][:sets].to_i
    Score.add_exercise_to_scores(score_params, set_num, params[:id], current_user)
    render status: :created
  end

  def update
    score = current_user.scores.find(params[:id])
    score.update!(check_params_present(score_params))
    render status: :ok
  end

  def destroy
    current_user.scores.find(params[:id]).destroy!
    render status: :no_content
  end

  def index
    user = User.find(params[:id])
    if confirm_user_unpublic?(user)
      raise(ActionController::BadRequest, '非公開ユーザーです')
    end

    render json: user.scores
  end

  private

  def score_params
    params.require(:score_params).permit(
      :weight,
      :repetitions,
      :interval_time,
      :rpe,
      :date
    )
  end
end
