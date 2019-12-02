class CreateIssues < ActiveRecord::Migration[5.0]
  def change
    create_table :issues do |t|
      t.date :date
      t.string :number
      t.text :plan
      t.references :publication, foreign_key: true

      t.timestamps
    end
  end
end
