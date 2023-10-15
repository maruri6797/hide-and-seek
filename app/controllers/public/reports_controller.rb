class Public::ReportsController < ApplicationController
  before_action :authenticate_user!

  def new

  end

  def create
    @report = Report.new(report_params)
    @report.target_id = params[:report][:target_id]
    @report.target_type = params[:report][:target_type]
    @report.reporter_id = current_user
    if @report.save
      redirect_to posts_path
    else
      redirect_to root_path
    end
  end

  private

  def report_params
    params.require(:report).permit(:target_id, :target_type, :reason)
  end
end
