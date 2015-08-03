class ReportTemplate < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true

  has_many :skill_groups, foreign_key: 'skill_group_id',  class_name:  'ReportTemplateToSkillGroupRelationship'

end
