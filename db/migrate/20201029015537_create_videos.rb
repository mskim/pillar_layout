class CreateVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :videos do |t|
      t.decimal :x
      t.decimal :y
      t.decimal :width
      t.decimal :height
      t.string :player_type
      t.string :source_video_url
      t.references :web_page, null: false, foreign_key: true

      t.timestamps
    end
  end
end
