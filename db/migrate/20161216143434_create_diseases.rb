class CreateDiseases < ActiveRecord::Migration[5.0]
  def change
    create_table :diseases do |t|
      t.string :category
      t.timestamps
    end
  end
end
