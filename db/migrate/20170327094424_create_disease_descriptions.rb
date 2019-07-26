class CreateDiseaseDescriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :disease_descriptions do |t|
      t.string :name
      t.text :description
      t.references :disease, foreign_key: true

      t.timestamps
    end
    #add_index :disease_descriptions, :disease_id
  end
end
