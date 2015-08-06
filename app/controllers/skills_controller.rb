class SkillsController < ApplicationController
  before_action :signed_in_user
  respond_to :html, :js
  def index
    fetch
  end

  def fetch
    @skills = Skill.all
  end

  def new
    @skill = Skill.new
    @title = "New skill"
  end

  def create
    fetch
    @skill = Skill.create(skill_params)
  end

  def edit
    @skill = Skill.find(params[:id])
    @title = "Editing #{@skill.name}"
  end

  def update
    fetch
    @skill = Skill.find(params[:id])
    @skill.update_attributes(skill_params)
  end

  def delete
    @skill = Skill.find(params[:skill_id])
  end

  def destroy
    fetch
    @skill = Skill.find(params[:id]).destroy
    @skill.destroy
  end

  private

  def skill_params
    params.require(:skill).permit(:name, :description)
  end

end