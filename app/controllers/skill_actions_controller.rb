class SkillActionsController < ApplicationController
	respond_to :html, :js

	def add_skill
		puts params
		@skill_group = SkillGroup.find(params[:id])
		if !params[:skill].empty?
			skill = Skill.find_by name: params[:skill]
			relation = SkillGroupToSkillRelationship.find_by skill_group_id: params[:id], skill_id: skill.id
			if relation.nil?
				SkillGroupToSkillRelationship.create(skill_group_id: params[:id], skill_id: skill.id)
			else
				@skill_group.errors.add(:base, t('skill_group.skill_already_added_msg'))
			end
		else
			@skill_group.errors.add(:base, t('skill_group.skill_not_specified_msg'))
		end
		@skills = get_skills
	end

	def remove_skill
		@skill_group = SkillGroup.find(params[:skill_group_id])
    	relation = SkillGroupToSkillRelationship.find_by skill_group_id: params[:skill_group_id], skill_id: params[:id]
    	relation.delete
    	@skills = get_skills
	end

	private

	def get_skills
	  	skills = []
	  	@skill_group.skills.each do |item|
	  		skills << Skill.find(item.skill_id)
	  	end
	  	skills
  	end
end