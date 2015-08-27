class SkillActionsController < ApplicationController
	before_action :signed_in_user
	respond_to :html, :js

	def add_skill_to_group
		@skill_group = SkillGroup.find(params[:id])
    skill = Skill.find(params[:skill_id])
    if skill.in_group?(@skill_group)
      @skill_group.errors.add(:base, t('skill_group.msg.skill_already_added'))
    else
      @skill_group.skills << skill
    end
	end

	def remove_skill_from_group
		@skill_group = SkillGroup.find(params[:id])
    @skill_group.skill_group_to_skill_relationships.find_by(skill_id: params[:skill_id]).destroy
	end
end