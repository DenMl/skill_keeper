class SkillsController < ApplicationController
  before_action :signed_in_user
  respond_to :html, :js

  def index
    fetch
  end

  def new
    @skill = Skill.new
    @title = t('skill.new_skill_title')
  end

  def create
    fetch
    @skill = Skill.create(skill_params)
    if @skill.save
      flash[:success] = t('skill.create_success', skill: @skill.name)
    end
  end

  def edit
      @skill = Skill.find(params[:id])
      @title = t('skill.edit_skill_title', skill: @skill.name)
  end

  def update
    fetch
    @skill = Skill.find(params[:id])
    if @skill.update_attributes(skill_params)
      flash[:success] = t('skill.update_success', skill: @skill.name)
    end
  end

  def delete
    @skill = Skill.find(params[:skill_id])
  end

  def destroy
    fetch
    @skill = Skill.find(params[:id]).destroy
    @skill.destroy
    flash[:success] = t('skill.delete_success', skill: @skill.name)
  end

  private

  def skill_params
    params.require(:skill).permit(:name, :description)
  end

  def fetch
    @skills = Skill.paginate(page: params[:page], per_page: 15)
  end

end