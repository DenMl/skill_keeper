class CandidateToSkillRelationship < ActiveRecord::Base
  belongs_to :candidate
  belongs_to :skill

  validates :candidate_id, presence: true
  validates :skill_id, presence: true

end
