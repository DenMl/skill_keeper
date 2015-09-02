class ReportsController < ApplicationController
  before_action :signed_in_user
  respond_to :html, :js

  def index
    @report_templates = ReportTemplate.paginate(page: params[:page], per_page: items_per_page)
  end

  def show
    @report_template = ReportTemplate.find(params[:id])
  end

end
