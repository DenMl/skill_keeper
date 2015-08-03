class Skill < ActiveRecord::Base

  belongs_to :created_by, class_name: 'User'
  belongs_to :updated_by, class_name: 'User'

  validates :name, presence: true, uniqueness: true

  has_many :skill_groups, foreign_key: 'skill_id',  class_name:  'SkillGroupToSkillRelationship', dependent: :destroy
  has_many :persons, foreign_key: 'skill_id',  class_name:  'PersonToSkillGroupRelationship', dependent: :destroy

end
