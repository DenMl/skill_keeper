class Skill < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true

  has_many :skill_group_to_skill_relationships, dependent: :destroy
  has_many :skill_groups, through: :skill_group_to_skill_relationships

  has_many :candidate_to_skill_relationships, dependent: :destroy
  has_many :candidates, through: :candidate_to_skill_relationships

  def in_group?(skill_group)
    skill_group_to_skill_relationships.find_by(skill_group_id: skill_group.id)
  end

  def belongs_to_candidate?(candidate)
    candidate_to_skill_relationships.find_by(candidate_id: candidate.id)
  end

end
