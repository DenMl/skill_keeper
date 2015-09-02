class CandidatesController < ApplicationController
  before_action :signed_in_user
  before_action :skill_ids_params_to_array, only: [:create, :update]
  respond_to :html, :js

  autocomplete :skill, :name

  def index
    fetch
  end

  def new
    @candidate = Candidate.new
    @title = t('candidates.title.new')
    @all_skills = Skill.all
  end

  def create
    fetch
    @candidate = Candidate.create(candidate_params)
    if @candidate.save
      flash[:success] = t('candidates.success.create', first_name: @candidate.first_name, last_name: @candidate.last_name)
    end
  end

  def edit
    @candidate = Candidate.find(params[:id])
    @title = t('candidates.title.edit', first_name: @candidate.first_name, last_name: @candidate.last_name)
    @all_skills = Skill.all
  end

  def update
    fetch
    @candidate = Candidate.find(params[:id])
    if @candidate.update_attributes(candidate_params)
      flash[:success] = t('candidates.success.update', first_name: @candidate.first_name, last_name: @candidate.last_name)
    end
  end

  def delete
    @candidate = Candidate.find(params[:candidate_id])
  end

  def destroy
    fetch
    @candidate = Candidate.find(params[:id]).destroy
    @candidate.destroy
    flash[:success] = t('candidates.success.delete', first_name: @candidate.first_name, last_name: @candidate.last_name)
  end

  private

  def candidate_params
    params.require(:candidate).permit(:first_name, :last_name, :patronymic, skill_ids: [])
  end

  def skill_ids_params_to_array #skill_ids come from UI as string with comma delimited
    params[:candidate][:skill_ids] = params[:candidate][:skill_ids].split(',')
  end

  def fetch
    @candidates = Candidate.paginate(page: params[:page], per_page: items_per_page)
  end
end
