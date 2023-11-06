class Public::ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_active?

  def new
    @report = Report.new
    @user = User.find(params[:user_id])
  end

  def create
    @user = User.find(params[:user_id])
    @report = Report.new(report_params)
    @report.reporter_id = current_user.id
    @report.reported_id = @user.id
    if @report.save
      redirect_to user_path(@user), notice: "ご報告ありがとうございます。"
    else
      render :new
    end
  end

  private

  def report_params
    params.require(:report).permit(:content, :reason)
  end
  
  def user_active?
    if current_user.is_deleted == true
      reset_session
      redirect_to root_path, notice: "退会されているため操作できません。"
    end
  end
end
