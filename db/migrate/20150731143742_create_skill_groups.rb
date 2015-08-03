class CreateSkillGroups < ActiveRecord::Migration
  def change
    create_table :skill_groups do |t|
      t.string :name
      t.string :description

      t.timestamps
    end

    add_index :skill_groups, :name, unique: true

  end
end
