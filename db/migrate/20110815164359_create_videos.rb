class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :name
      t.text :description
      t.integer :index_id
      t.integer :priority
      t.string :remote_id
      t.string :remote_type

      t.timestamps
    end
  end
end
