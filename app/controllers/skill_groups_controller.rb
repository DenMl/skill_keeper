class SkillGroupsController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  before_action :skill_ids_params_to_array, only: [:create, :update]

  respond_to :html, :js

  autocomplete :skill, :name
  
  def index
    fetch
  end

  def new
    @skill_group = SkillGroup.new
    @title = t('skill_group.title.new')
    @all_skills = Skill.all
  end

  def create
    fetch
    @skill_group = SkillGroup.create(skill_group_params)
    if @skill_group.save
      flash[:success] = t('skill_group.msg.create_success', skill_group: @skill_group.name)
    end
  end

  def edit
      @skill_group = SkillGroup.find(params[:id])
      @title = t('skill_group.title.edit', skill_group: @skill_group.name)
      @all_skills = Skill.all
  end

  def update
    fetch
    @skill_group = SkillGroup.find(params[:id])
    if @skill_group.update_attributes(skill_group_params)
      flash[:success] = t('skill_group.msg.update_success', skill_group: @skill_group.name)
    end
  end

  def delete
    @skill_group = SkillGroup.find(params[:skill_group_id])
  end

  def destroy
    fetch
    @skill_group = SkillGroup.find(params[:id]).destroy
    @skill_group.destroy
    flash[:success] = t('skill_group.msg.delete_success', skill_group: @skill_group.name)
  end

  private

  def skill_group_params
    params.require(:skill_group).permit(:name, :description, skill_ids: [])
  end

  def skill_ids_params_to_array #skill_ids come from UI as string with comma delimited
    params[:skill_group][:skill_ids] = params[:skill_group][:skill_ids].split(',')
  end

  def fetch
    @skill_groups = SkillGroup.paginate(page: params[:page], per_page: 15)
  end
end
