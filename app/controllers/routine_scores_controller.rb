class RoutineScoresController < ApplicationController
  before_action :authorize!, only: %i[index]
  def index
    Score.add_routine_scores(params[:routine_score_params], current_user)
    render status: :created
  end

  def routine_score_params
    params.require(:routine_score_params).permit(
      score_params:
       %i[
         weight
         repetitions
         interval_time
         rpe
         date
       ]
    )
  end
end
