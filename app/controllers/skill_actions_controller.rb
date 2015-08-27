class SkillActionsController < ApplicationController
  before_action :signed_in_user
  respond_to :html, :js

  def add_skill_to_group
    puts params
    @skill_group = SkillGroup.find(params[:id])
    add_skill @skill_group, params[:skill]
    @skills = get_skills @skill_group
  end

  def remove_skill_from_group
    @skill_group = SkillGroup.find(params[:skill_group_id])
    remove_skill @skill_group, params[:id]
    @skills = get_skills @skill_group
  end

  def add_skill_to_candidate
    puts params
    @candidate = Candidate.find(params[:id])
    add_skill @candidate, params[:skill]
    @skills = get_skills @candidate
  end

  def remove_skill_from_candidate
    @candidate = Candidate.find(params[:candidate_id])
    remove_skill @candidate, params[:id]
    @skills = get_skills @candidate
  end


  private

  def get_skills (item)
    skills = []
    item.skills.each do |skill|
      skills << Skill.find(skill.skill_id)
    end
    skills
  end

  def add_skill(item, skill_name)
    puts "Add skill processing..."
    if !skill_name.empty?
      skill = Skill.find_by name: skill_name
      if !skill.nil?
        puts "Adding skill to item..."
        create_skill_to_item_relation item, skill.id
      else
        item.errors.add(:base, t('skill.warning.wrong_skill_name_specified'))
      end
    else
      item.errors.add(:base, t('skill.warning.skill_not_specified'))
    end
  end

  def remove_skill(item, skill_id)
    puts "Remove skill processing..."
    delete_skill_to_item_relation item, skill_id
  end

  def create_skill_to_item_relation(item, skill_id)
    case item
      when SkillGroup
        relation = SkillGroupToSkillRelationship.find_by skill_group_id: item.id, skill_id: skill_id
        if relation.nil?
          SkillGroupToSkillRelationship.create(skill_group_id: item.id, skill_id: skill_id)
        else
          item.errors.add(:base, t('skill_group.msg.skill_already_added'))
        end
      when Candidate
        relation = CandidateToSkillRelationship.find_by candidate_id: item.id, skill_id: skill_id
        if relation.nil?
          CandidateToSkillRelationship.create(candidate_id: item.id, skill_id: skill_id)
        else
          item.errors.add(:base, t('candidates.warning.skill_already_added'))
        end
      else
        item.errors.add(:base, t('general_error_msg'))
    end
    item
  end

  def delete_skill_to_item_relation(item, skill_id)
    case item
      when SkillGroup
        puts "Removing skill from skill group..."
        relation = SkillGroupToSkillRelationship.find_by skill_group_id: item.id, skill_id: skill_id
        relation.delete
      when Candidate
        puts "Removing skill from candidat..."
        relation = CandidateToSkillRelationship.find_by candidate_id: item.id, skill_id: skill_id
        relation.delete
      else
        item.errors.add(:base, t('general_error_msg'))
    end
  end
end