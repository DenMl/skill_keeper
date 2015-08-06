class SkillsController < ApplicationController
  before_action :signed_in_user

  def index
    fetch
  end

  def fetch
    @skills = Skill.paginate(page: params[:page], per_page: 15 )
    @page = params[:page]
  end

  def new
    @skill = Skill.new
    @page = params[:page]
    flash = nil
  end

  def create
    @skill = Skill.new(skill_params)
    if @skill.save
      flash[:success] = "Skill added."
      fetch
    else
      render 'new'
    end
  end

  def edit
    @skill = Skill.find(params[:id])
  end

  def update
    @skill = Skill.find(params[:id])
    if @skill.update_attributes(skill_params)
      flash[:success] = "Skill updated"
      redirect_to skills_url
    else
      render 'edit'
    end
  end

  def destroy
    Skill.find(params[:id]).destroy
    flash[:success] = "Skill deleted."
    redirect_to skills_url
  end

  private

  def skill_params
    params.require(:skill).permit(:name, :description)
  end

end