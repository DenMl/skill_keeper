class SkillGroup < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true
  
  has_many :skill_group_to_skill_relationships, dependent: :destroy
  has_many :skills, through: :skill_group_to_skill_relationships

  has_many :report_template_to_skill_group_relationships, dependent: :destroy
  has_many :report_templates, through: :report_template_to_skill_group_relationships

  def candidates
    Candidate.from_skill_group(self)
  end

end
