class SkillsController < ApplicationController
  before_action :signed_in_user
  respond_to :html, :js

  def index
    fetch
  end

  def new
    @skill = Skill.new
    @title = "New skill"
  end

  def create
    fetch
    @skill = Skill.create(skill_params)
    if @skill.save
      flash[:success] = "Skill #{@skill.name} created"
    end
  end

  def edit
    @skill = Skill.find(params[:id])
    @title = "Editing #{@skill.name}"
  end

  def update
    fetch
    @skill = Skill.find(params[:id])
    if @skill.update_attributes(skill_params)
      flash[:success] = "Skill #{@skill.name} updated"
    end
  end

  def delete
    @skill = Skill.find(params[:skill_id])
  end

  def destroy
    fetch
    @skill = Skill.find(params[:id]).destroy
    @skill.destroy
    flash[:success] = "Skill #{@skill.name} deleted."
  end

  private

  def skill_params
    params.require(:skill).permit(:name, :description)
  end

  def fetch
    @skills = Skill.paginate(page: params[:page], per_page: 15)
  end

end