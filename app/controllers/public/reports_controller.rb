class Public::ReportsController < ApplicationController
  before_action :authenticate_user!

  def new
    @report = Report.new
  end

  def create
    target_id = params[:report][:target_id]
    target_type = params[:report][:target_type]
    @target = target_type.constantize.find(target_id)

    if @target
      @report = Report.new(report_params)
      @report.reporter = current_user
      @report.reported = @target.user
      if @report.save
        redirect_to request.referer
      else
        redirect_to posts_path
      end
    end
  end
end
