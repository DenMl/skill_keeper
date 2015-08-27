class CreateCandidateToSkillRelationships < ActiveRecord::Migration
  def change
    create_table :candidate_to_skill_relationships do |t|
      t.integer :candidate_id
      t.integer :skill_id

      t.timestamps
    end

    add_index :candidate_to_skill_relationships, [:skill_id, :candidate_id], unique: true, name: 'index_candidate_id_to_skill_id'
  end
end
