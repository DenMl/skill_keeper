class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :patronymic

      t.timestamps
    end

    add_index :people, [:first_name, :last_name, :patronymic], unique: true

  end
end
