class SignInsController < ApplicationController
  def create
    sign_in_check(params[:sign_in_params][:sign_in_text])
    raise(ActiveRecord::RecordNotFound, 'ユーザー名、emailが見つかりません') if @data.blank?
    raise(ActionController::BadRequest, 'パスワードが間違っています') unless @data.authenticate(params[:sign_in_params][:password])

    render json: @data.as_json
  end

  def sign_in_params
    params.require(:sign_in_params).permit(
      :sign_in_text,
      :password,
      :password_confirmation
    )
  end

  # UX向上
  def sign_in_check(data)
    @data = if data.include?('@')
              User.find_by(email: params[:sign_in_params][:sign_in_text])
            else
              User.find_by(name: params[:sign_in_params][:sign_in_text])
            end
  end
end
