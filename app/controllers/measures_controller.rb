class MeasuresController < ApplicationController
  before_action :authorize!

  # 計測記録の作成
  def create
    current_user.measures.create(measure_params)
    render status: :created
  end

  # 記録の消去
  def destroy
    Measure.find(params[:id]).destroy!
    render status: :no_content
  end

  # 計測記録の作成
  def update
    measure = current_user.measures.find(params[:id])
    measure.update!(check_params_present(measure_params))
    render status: :ok
  end

  def index
    user = User.find(params[:id])
    if confirm_user_unpublic?(user)
      raise(ActionController::BadRequest, '非公開ユーザーです')
    end

    render json: user.measures.order(date: :desc)
  end

  private

  def measure_params
    params.require(:measure_params).permit(
      :body_weight,
      :body_fat,
      :calorie,
      :neck,
      :shoulder,
      :chest,
      :left_biceps,
      :right_biceps,
      :left_forearm,
      :right_forearm,
      :upper_abdomen,
      :lower_abdomen,
      :waist,
      :hips,
      :left_thigh,
      :right_thigh,
      :left_calf,
      :right_calf,
      :date
    )
  end
end
