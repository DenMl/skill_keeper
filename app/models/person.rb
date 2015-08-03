class Person < ActiveRecord::Base

  has_many :skills, foreign_key: 'skill_id',  class_name:  'PersonToSkillGroupRelationship'

end
