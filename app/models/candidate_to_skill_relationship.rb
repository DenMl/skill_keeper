class CandidateToSkillRelationship < ActiveRecord::Base

  belongs_to :candidate, class_name: 'Candidate'
  belongs_to :skill, class_name: 'Skill'

  validates :candidate_id, presence: true
  validates :skill_id, presence: true

end
