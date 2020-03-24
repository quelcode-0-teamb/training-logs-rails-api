class RoutineExercisesController < ApplicationController
  before_action :authorize!
  before_action :check_auth_user

  def create
    render json: RoutineExercise.add_exercises(Routine.find(params[:id]), routine_exercise_params), status: :created
  end

  def destroy
    exercise = RoutineExercise.find(params[:routine_exercise_id])
    exercise.destroy!
    render :no_content
  end

  private

  def routine_exercise_params
    params.require(:routine_exercise_params)
  end

  def check_auth_user
    return if current_user.id == Routine.find(params[:id]).user_id

    raise ActionController::BadRequest, 'ユーザーが違います！'
  end
end
