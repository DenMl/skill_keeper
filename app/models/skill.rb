class Skill < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true

  has_many :skill_group_to_skill_relationships, dependent: :destroy
  has_many :skill_groups, through: :skill_group_to_skill_relationships
  has_many :candidates, foreign_key: 'skill_id',  class_name:  'CandidateToSkillRelationship', dependent: :destroy

  def in_group?(skill_group)
    skill_group_to_skill_relationships.find_by(skill_group_id: skill_group.id)
  end
end
