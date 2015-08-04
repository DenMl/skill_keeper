class PersonToSkillRelationship < ActiveRecord::Base

  belongs_to :person, class_name: 'Person'
  belongs_to :skill, class_name: 'Skill'

  validates :person_id, presence: true
  validates :skill_id, presence: true

end
