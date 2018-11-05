class CreateHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :histories do |t|
      t.string :user_name
      t.datetime :study_date
      t.integer :section
      t.integer :score
      t.integer :num_questions

      t.timestamps
    end
  end
end
