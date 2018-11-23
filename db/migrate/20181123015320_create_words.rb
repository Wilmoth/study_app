class CreateWords < ActiveRecord::Migration[5.2]
  def change
    create_table :words do |t|
      t.integer :level
      t.string :question
      t.string :cand1
      t.string :cand2
      t.string :cand3
      t.integer :answer

      t.timestamps
    end
  end
end
