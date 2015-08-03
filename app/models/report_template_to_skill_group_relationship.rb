class ReportTemplateToSkillGroupRelationship < ActiveRecord::Base

  belongs_to :report_template, class_name: 'ReportTemplate'
  belongs_to :skill_group, class_name: 'SkillGroup'

  validates :report_template_id, presence: true
  validates :skill_group_id, presence: true

end
