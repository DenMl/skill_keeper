class CreateCandidateToSkillRelationships < ActiveRecord::Migration
  def change
    create_table :candidate_to_skill_relationships do |t|
      t.integer :candidate_id
      t.integer :skill_id

      t.timestamps
    end
  end
end
