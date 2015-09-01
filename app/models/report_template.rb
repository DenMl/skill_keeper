class ReportTemplate < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true

  has_many :report_template_to_skill_group_relationships, dependent: :destroy
  has_many :skill_groups, through: :report_template_to_skill_group_relationships


end
