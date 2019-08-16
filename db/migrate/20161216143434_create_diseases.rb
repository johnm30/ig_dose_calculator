class CreateDiseases < ActiveRecord::Migration[5.0]
  def change
    create_table :diseases do |t|
      t.text :speciality
      t.string :commissioning
      t.string :priority
      t.string :regimen
      t.text :criteria
      t.text :outcome

      t.timestamps
    end
  end
end
