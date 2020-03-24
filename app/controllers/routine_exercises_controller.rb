class RoutineExercisesController < ApplicationController
  before_action :authorize!

  def create
    render json: RoutineExercise.add_exercises(current_user.routines.find(params[:id]), routine_exercise_params), status: :created
  end

  def destroy
    exercise = current_user.routine_exercises.find(params[:routine_exercise_id])
    exercise.destroy!
    render :no_content
  end

  private

  def routine_exercise_params
    params.require(:routine_exercise_params)
  end
end
