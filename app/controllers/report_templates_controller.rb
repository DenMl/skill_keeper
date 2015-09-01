class ReportTemplatesController < ApplicationController
  before_action :signed_in_user
  before_action :skill_group_ids_params_to_array, only: [:create, :update]

  respond_to :html, :js
  
  def index
    fetch
  end

  def new
    @report_template = ReportTemplate.new
    @title = t('report_template.title.new')
    @all_skill_groups = SkillGroup.all
  end

  def create
    fetch
    @report_template = ReportTemplate.create(report_template_params)
    if @report_template.save
      flash[:success] = t('report_template.msg.create_success', report_template: @report_template.name)
    end
  end

  def edit
    @report_template = ReportTemplate.find(params[:id])
    @title = t('report_template.title.edit', report_template: @report_template.name)
    @all_skill_groups = SkillGroup.all
  end

  def update
    fetch
    @report_template = ReportTemplate.find(params[:id])
    if @report_template.update_attributes(report_template_params)
      flash[:success] = t('report_template.msg.update_success', report_template: @report_template.name)
    end
  end

  def delete
    @report_template = ReportTemplate.find(params[:report_template_id])
  end

  def destroy
    fetch
    @report_template = ReportTemplate.find(params[:id]).destroy
    @report_template.destroy
    flash[:success] = t('report_template.msg.delete_success', report_template: @report_template.name)
  end

  private

  def report_template_params
    params.require(:report_template).permit(:name, :description, skill_group_ids: [])
  end

  def skill_group_ids_params_to_array #skill_groups_ids come from UI as string with comma delimited
    params[:report_template][:skill_group_ids] = params[:report_template][:skill_group_ids].split(',')
  end

  def fetch
    @report_templates = ReportTemplate.paginate(page: params[:page], per_page: 15)
  end
end
