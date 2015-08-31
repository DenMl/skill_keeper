class SkillGroupToSkillRelationship < ActiveRecord::Base
  belongs_to :skill
  belongs_to :skill_group

  validates :skill_id, presence: true

end
