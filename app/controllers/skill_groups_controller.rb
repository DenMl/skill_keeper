class SkillGroupsController < ApplicationController
  before_action :signed_in_user
  respond_to :html, :js

  autocomplete :skill, :name
  
  def index
    fetch
  end

  def new
    @skill_group = SkillGroup.new
    @title = t('skill_group.title.new')
  end

  def create
    fetch
    @skill_group = SkillGroup.create(skill_group_params)
    if @skill_group.save
      flash[:success] = t('skill_group.msg.create_success', skill_group: @skill_group.name)
    end
  end

  def show
  	@skill_group = SkillGroup.find(params[:id])
  	@skills = get_skills
  end

  def edit
      @skill_group = SkillGroup.find(params[:id])
      @title = t('skill_group.title.edit', skill_group: @skill_group.name)
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
    params.require(:skill_group).permit(:name, :description)
  end

  def fetch
    @skill_groups = SkillGroup.paginate(page: params[:page], per_page: 15)
  end

  def get_skills
  	skills = []
  	@skill_group.skills.each do |item|
  		skills << Skill.find(item.skill_id)
  	end
  	skills
  end
end
