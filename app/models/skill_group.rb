class SkillGroup < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true
  has_many :skills, foreign_key: 'skill_id',  class_name: 'SkillGroupToSkillRelationship'

  has_many :report_templates, foreign_key: 'skill_id',  class_name: 'ReportTemplateToSkillGroupRelationship'  , dependent: :destroy

end
