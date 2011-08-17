class CreateDownloadables < ActiveRecord::Migration
  def change
    create_table :downloadables do |t|
      t.string :name
      t.text :description
      t.string :asset_file_name
      t.string :asset_content_type
      t.integer :asset_file_size
      t.integer :index_id
      t.integer :priority

      t.timestamps
    end
  end
end
