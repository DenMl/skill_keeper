class Skill < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true

  has_many :skill_group_to_skill_relationships, dependent: :destroy
  has_many :skill_groups, through: :skill_group_to_skill_relationships

  has_many :candidate_to_skill_relationships, dependent: :destroy
  has_many :candidates, through: :candidate_to_skill_relationships


end
