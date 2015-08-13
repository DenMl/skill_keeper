class ReportTemplate < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true

  has_many :skill_groups, foreign_key: 'report_template_id',  class_name:  'ReportTemplateToSkillGroupRelationship'

end
