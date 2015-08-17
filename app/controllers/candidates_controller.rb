class CandidatesController < ApplicationController
  before_action :signed_in_user
  respond_to :html, :js

  def index
    fetch
  end

  def new
    @candidate = Candidate.new
    @title = t('candidates.title.new')
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
    params.require(:candidate).permit(:first_name, :last_name, :patronymic)
  end

  def fetch
    @candidates = Candidate.paginate(page: params[:page], per_page: 15)
  end

end
