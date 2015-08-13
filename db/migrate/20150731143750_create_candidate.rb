class CreateCandidate < ActiveRecord::Migration
  def change
    create_table :candidate do |t|
      t.string :first_name
      t.string :last_name
      t.string :patronymic

      t.timestamps
    end

    add_index :candidate, [:first_name, :last_name, :patronymic], unique: true

  end
end
