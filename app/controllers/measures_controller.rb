class MeasuresController < ApplicationController
  before_action :authorize!
  before_action :check_auth_user, only: %i[destroy update]

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
    check_params_present(measure_params)
    measure = Measure.find(params[:id])
    measure.update!(@params_array)
    render json: measure
  end

  private

  def check_auth_user
    return if current_user.id == Measure.find(params[:id]).user_id

    raise ActionController::BadRequest, 'この記録はnameが違うので変更、削除できません！'
  end

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
