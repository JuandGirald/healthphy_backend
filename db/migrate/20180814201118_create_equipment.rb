class CreateEquipment < ActiveRecord::Migration[5.2]
  def change
    create_table :equipment do |t|
      t.string :title
      t.integer :exercises_id

      t.timestamps
    end
  end
end
