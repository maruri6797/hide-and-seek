# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :user_state, only: [:create]

  def after_sign_in_path_for(resource)
    posts_path(current_user)
  end

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to posts_path, notice: "ゲストユーザーでログインしました。"
  end
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def user_state
    @user = User.find_by(email: params[:user][:email])
    if @user.present? && @user.valid_password?(params[:user][:password])
      unless @user.is_deleted == false
        redirect_to new_user_registration_path, notice: "退会済みです。再度ご登録をしてご利用ください。"
      end
    end
  end
end
