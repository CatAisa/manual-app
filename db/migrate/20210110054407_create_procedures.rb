class CreateProcedures < ActiveRecord::Migration[6.0]
  def change
    create_table :procedures do |t|
      t.string :title, null: false
      t.text :description
      t.references :manual, null: false, foreign_key: true
      t.timestamps
    end
  end
end
