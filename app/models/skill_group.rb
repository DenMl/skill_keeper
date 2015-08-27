class SkillGroup < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true
  
  has_many :skills, foreign_key: 'skill_group_id',  class_name: 'SkillGroupToSkillRelationship', dependent: :destroy
  has_many :report_templates, foreign_key: 'skill_group_id',  class_name: 'ReportTemplateToSkillGroupRelationship'  , dependent: :destroy

end
