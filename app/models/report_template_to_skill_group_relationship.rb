class ReportTemplateToSkillGroupRelationship < ActiveRecord::Base

  belongs_to :report_template
  belongs_to :skill_group

  validates :skill_group_id, presence: true

end
