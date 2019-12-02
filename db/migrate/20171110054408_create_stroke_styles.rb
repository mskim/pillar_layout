class CreateStrokeStyles < ActiveRecord::Migration[5.1]
  def change
    create_table :stroke_styles do |t|
      t.string :klass
      t.string :name
      t.text :stroke
      t.references :publication, foreign_key: true

      t.timestamps
    end
  end
end
