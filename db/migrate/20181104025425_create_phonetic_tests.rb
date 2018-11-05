class CreatePhoneticTests < ActiveRecord::Migration[5.2]
  def change
    create_table :phonetic_tests do |t|
      t.string :question
      t.string :cand1
      t.string :cand2
      t.string :cand3
      t.integer :answer

      t.timestamps
    end
  end
end
