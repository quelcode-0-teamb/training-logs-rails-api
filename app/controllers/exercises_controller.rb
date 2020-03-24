class ExercisesController < ApplicationController
  before_action :authorize!

  def create
    current_user.exercises.create(exercise_params)
    render status: :created
  end

  def destroy
    Exercise.find(params[:id]).destroy!
    render status: :no_content
  end

  def update
    exercise = current_user.exercises.find(params[:id])
    exercise.update!(check_params_present(exercise_params))
    render status: :ok
  end

  def index
    if params[:category].blank?
      default_exercise = Exercise.default
      user_exercise = current_user.exercises
      exercises = default_exercise + user_exercise
    else
      exercises = Exercise.where(category: params[:category])
    end
    render json: exercises
  end

  private

  def exercise_params
    params.require(:exercise_params).permit(
      :name,
      :category
    )
  end
end
