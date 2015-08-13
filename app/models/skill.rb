class Skill < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true

  has_many :skill_groups, foreign_key: 'skill_id',  class_name:  'SkillGroupToSkillRelationship', dependent: :destroy
  has_many :candidates, foreign_key: 'skill_id',  class_name:  'CandidateToSkillRelationship', dependent: :destroy

end
