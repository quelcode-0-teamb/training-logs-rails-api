class RoutinesController < ApplicationController
  before_action :authorize!
  before_action :check_auth_user, only: %i[destroy update show]

  def create
    routine = Routine.new(routine_params)
    routine.user = current_user
    routine.save!
    render status: :created
  end

  def destroy
    Routine.find(params[:id]).destroy
    render status: :no_content
  end

  def update
    routine = Routine.find(params[:id])
    routine.update!(routine_params)
    render json: routine
  end

  def show
    routine_exercise = Routine.find(params[:id]).routine_exercises.order(created_at: :asc).includes(:exercise)
    render json: routine_exercise, each_serializer: RoutineExercisesSerializer
  end

  private

  def routine_params
    params.require(:routine_params).permit(
      :name
    )
  end

  def check_auth_user
    return if current_user.id == Routine.find(params[:id]).user_id

    raise ActionController::BadRequest, 'ユーザーが違います！'
  end
end
