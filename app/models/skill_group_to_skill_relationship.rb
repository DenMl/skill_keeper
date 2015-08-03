class SkillGroupToSkillRelationship < ActiveRecord::Base
  belongs_to :skill, class_name: 'Skill'
  belongs_to :skill_group, class_name: 'SkillGroup'

  validates :skill_id, presence: true
  validates :skill_group_id, presence: true

end
