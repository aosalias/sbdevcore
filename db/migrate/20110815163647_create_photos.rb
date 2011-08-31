class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :name
      t.text :description
      t.string :klass, :default => "center"
      t.string :asset_file_name
      t.string :asset_content_type
      t.integer :asset_file_size
      t.integer :index_id
      t.integer :priority

      t.timestamps
    end
  end
end
