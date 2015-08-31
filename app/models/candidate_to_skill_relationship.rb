class CandidateToSkillRelationship < ActiveRecord::Base
  belongs_to :candidate
  belongs_to :skill

  validates :skill_id, presence: true

end
