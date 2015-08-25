class SkillActionsController < ApplicationController
	before_action :signed_in_user
	respond_to :html, :js

	def add_skill_to_group
		puts params
		@skill_group = SkillGroup.find(params[:id])
		add_skill @skill_group, params[:skill]
		@skills = get_skills
	end

	def remove_skill_from_group
		@skill_group = SkillGroup.find(params[:skill_group_id])
		remove_skill @skill_group, params[:id]
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

  	def add_skill(item, skill_name)	
  		puts "Add skill processing..."
		if !skill_name.empty? 
			skill = Skill.find_by name: skill_name
			if !skill.nil?
				if (item.instance_of? SkillGroup) 
					puts "Adding skill to skill group"
					relation = SkillGroupToSkillRelationship.find_by skill_group_id: item.id, skill_id: skill.id
					if relation.nil? 
						SkillGroupToSkillRelationship.create(skill_group_id: item.id, skill_id: skill.id)
					else
						item.errors.add(:base, t('skill_group.skill_already_added_msg'))
					end
				end
			else
				item.errors.add(:base, t('skill_group.wrong_skill_name_specified_msg'))
			end
		else
			item.errors.add(:base, t('skill_group.skill_not_specified_msg'))
		end
  	end

  	def remove_skill(item, skill_id)
  		puts "Remove skill processing..."
  		case item
  		when SkillGroup
  			puts "Removing skill from skill group..."
  			relation = SkillGroupToSkillRelationship.find_by skill_group_id: item.id, skill_id: skill_id
  			relation.delete
  		else
  			item.errors.add(:base, t('general_error_msg'))
  		end
  	end
end