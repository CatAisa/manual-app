class CreateReleases < ActiveRecord::Migration[6.0]
  def change
    create_table :releases do |t|
      t.references :user, null: false, foreign_key: true
      t.references :manual, null: false, foreign_key: true
      t.timestamps
    end
  end
end
