class RoutinesController < ApplicationController
  before_action :authorize!

  def create
    current_user.routines.create(routine_params)
    render status: :created
  end

  def destroy
    current_user.routines.find(params[:id]).destroy
    render status: :no_content
  end

  def update
    routine = current_user.routines.find(params[:id])
    routine.update!(routine_params)
    render json: routine
  end

  def show
    routine_exercise = current_user.routines.find(params[:id]).routine_exercises.order(created_at: :asc).includes(:exercise)
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
