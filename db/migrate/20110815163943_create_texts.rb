class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.text :content
      t.integer :index_id
      t.integer :priority

      t.timestamps
    end
  end
end
