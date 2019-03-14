class CreateTrials < ActiveRecord::Migration[5.1]
  def change
    create_table :trials do |t|
      t.text :attacks
      t.references :user, foreign_key: true
      t.integer :damage_reduction
      t.integer :crit_immune
      t.text :table

      t.timestamps
    end
  end
end
